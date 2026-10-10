const cds = require('@sap/cds');
const { SELECT } = require('@sap/cds/lib/ql/cds-ql');
// const { SELECT } = require('@sap/cds/lib/ql/cds-ql');

class Inventory extends cds.ApplicationService {

    init() {
        const { PiDocument } = this.entities;

        this.on('READ', PiDocument, this.readDocuments)

        return super.init();
    }

    async readDocuments(req) {
        const srv = await cds.connect.to('api_whse_physinvtryitem_2');
        const docs = await srv.run(SELECT.from('api_whse_physinvtryitem_2.WhsePhysicalInventoryItem')
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
                { PhysicalInventoryStatusText: 'ACTI' }
            ).limit(50)
        );
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
                matnr: '',
                maktx: '',
                charg: '',
                cat: doc.EWMStockType,
                cat_text: '',
                count_of_hu: 0,
                assigned: false
            }))
        );
    }

}

module.exports = Inventory;