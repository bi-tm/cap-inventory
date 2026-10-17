import { Request, ApplicationService } from "@sap/cds";
import cds from "@sap/cds";
import api_whse_physinvtryitem_2, { WhsePhysicalInventoryItem } from "../@cds-models/api_whse_physinvtryitem_2";
import api_whse_physstockprod, { WarehousePhysicalStockProduct } from "#cds-models/api_whse_physstockprod";
import api_warehouse_order_task_2, { WarehouseOrder } from "#cds-models/api_warehouse_order_task_2";

import getParams, { Params } from "../lib/params";
import { ZewvaUiPiCount, ZewvaUiPiCountItm } from "#cds-models/inventory1";

export default class PiDocument {

    private params!: Params;
    private api_inventory!: cds.CdsFunctions<typeof api_whse_physinvtryitem_2> & cds.Service;
    private api_stock!: cds.CdsFunctions<typeof api_whse_physstockprod> & cds.Service;
    private api_warehouse!: cds.CdsFunctions<typeof api_warehouse_order_task_2> & cds.Service;

    async register(service: ApplicationService) {
        const { PiDocument } = service.entities;
        this.params = await getParams();
        this.api_inventory = await cds.connect.to(api_whse_physinvtryitem_2);
        this.api_stock = await cds.connect.to(api_whse_physstockprod);
        this.api_warehouse = await cds.connect.to(api_warehouse_order_task_2);

        service.on('READ', PiDocument, this.readDocuments.bind(this));
        service.on('StartCounting', PiDocument, this.startCounting.bind(this));
    }

    async readDocuments(req: Request) {
        const { warehouse, CONST } = this.params;
        const docs = await this.api_inventory.run(SELECT
            .from(WhsePhysicalInventoryItem)
            .columns(
                'EWMWarehouse',
                'PhysicalInventoryDocNumber',
                'PhysicalInventoryDocYear',
                'PhysicalInventoryItemNumber',
                'PhysicalInventoryDocumentType',
                'WarehouseOrder',
                'EWMStorageType',
                'PhysicalInventoryStatusText',
                'EWMPhysInvtryReason',
                'EWMStockType',
                'PhysicalInventoryArea',
                'EWMStorageBin'
            ).where(
                {
                    PhysicalInventoryStatusText: CONST.StatusActi,
                    EWMWarehouse: warehouse
                }
            ).limit(50)
        );

        const huCount = await this.getHuCount(docs.map(d => d.EWMStorageBin!));
        const orders = await this.getOrders(docs.map(d => d.WarehouseOrder!));
        req.reply(
            docs.map(doc => ({
                doc_year: doc.PhysicalInventoryDocYear,
                doc_number: doc.PhysicalInventoryDocNumber,
                item_no: doc.PhysicalInventoryItemNumber,
                who: doc.WarehouseOrder,
                doc_type: doc.PhysicalInventoryDocumentType,
                doc_status: doc.PhysicalInventoryStatusText,
                reason: doc.EWMPhysInvtryReason,
                reason_txt: '',
                lgtyp: doc.EWMStorageType,
                lgber: doc.PhysicalInventoryArea,
                lgpla: doc.EWMStorageBin,
                count_of_hu: huCount.get(doc.EWMStorageBin!) ?? 0,
                assigned: !!orders.find(o => o.WarehouseOrder === doc.WarehouseOrder)?.ExecutingResource
            }))
        );
    }

    private async getHuCount(storageBins: string[]): Promise<Map<string, number>> {
        const huCount = new Map<string, number>();
        if (storageBins.length > 0) {
            const { warehouse } = this.params;
            const handlingunits = await this.api_stock.run(
                SELECT
                    .from(WarehousePhysicalStockProduct)
                    .columns("EWMStorageBin", "HandlingUnitNumber")
                    .where({
                        EWMWarehouse: warehouse,
                        EWMStorageBin: {
                            in: storageBins
                        }
                    })
            );
            for (const hu of handlingunits) {
                const count = huCount.get(hu.EWMStorageBin!) ?? 0;
                huCount.set(hu.EWMStorageBin!, count + 1);
            }
        }
        return huCount;
    }

    private async getOrders(ordersNo: string[]): Promise<{ WarehouseOrder?: string, ExecutingResource?: string }[]> {
        const { warehouse } = this.params;
        return await this.api_warehouse.run(SELECT
            .from(WarehouseOrder)
            .columns("WarehouseOrder", "ExecutingResource")
            .where({
                EWMWarehouse: warehouse,
                WarehouseOrder: {
                    in: ordersNo
                }
            })
        );
    }
    // 	App:     /odata/v4/v0001/PiDocument/com.sap.gateway.srvd_a2x.zew_ui_pi.v0001.StartCounting
    async startCounting(req: Request) {
        const { warehouse, CONST } = this.params;
        const { Scan } = req.data as { Scan: string };
        console.debug("Action startCounting scan=", Scan);

        let result: ZewvaUiPiCount | undefined;
        const matches = Scan.match(/^(\d+)-(\d+)-(\d+)/);
        if (matches?.length === 4) {
            const piDoc = await this.api_inventory.run(
                SELECT.one
                    .from(WhsePhysicalInventoryItem)
                    .columns(
                        'EWMStorageBin'
                    ).where(
                        {
                            EWMWarehouse: warehouse,
                            PhysicalInventoryDocYear: matches[1],
                            PhysicalInventoryDocNumber: matches[2],
                            PhysicalInventoryItemNumber: matches[3]
                        }
                    )
            );
            const items = await this.buildItems(piDoc?.EWMStorageBin!);
            result = {
                doc_year: matches[1],
                doc_number: matches[2],
                item_no: matches[3],
                isBulk: false,
                lgpla: piDoc?.EWMStorageBin,
                items: items
            }
        }
        req.reply(result);
    }

    async buildItems(EWMStorageBin: string): Promise<ZewvaUiPiCountItm[]> {
        const { warehouse, CONST } = this.params;
        const stock = await this.api_stock.run(SELECT
            .from(WarehousePhysicalStockProduct)
            .columns(
                "HandlingUnitNumber", "Product", "Batch",
                "EWMHghstLvlHandlingUnitNumber", "EWMStockType",
                "EWMStockQuantityInBaseUnit", "EWMStockQuantityBaseUnit"
            )
            .where(
                {
                    EWMWarehouse: warehouse,
                    EWMStorageBin: EWMStorageBin
                }
            )
        );
        return stock.map(s => ({
            huident: s.HandlingUnitNumber,
            matnr: s.Product,
            charg: s.Batch,
            huTop: s.EWMHghstLvlHandlingUnitNumber,
            maktx: `Material ${s.Product}`,
            cat: s.EWMStockType,
            catText: `Bestandsart ${s.EWMStockType}`,
            stockQuantity: s.EWMStockQuantityInBaseUnit,
            entered_quantity: 0,
            entered_unit: s.EWMStockQuantityBaseUnit
        }));
    }

}