import type ResourceBundle from "sap/base/i18n/ResourceBundle";
import type { DocKey, PiDoc, PiItem } from "inventory1/types/AppTypes";

import ResourceModel from "sap/ui/model/resource/ResourceModel";
import { ZewvaUiPiSaveResult } from "inventory1/src-gen/main-service/ComSapGatewaySrvdA2xZewUiPiV0001Model";
import CoreService from "./CoreService";
import ODataClientFactory from "./ODataClientFactory";

/**
 * Service für <Beschreibung>
 *
 * Bound Functions:
 * <Bound Functions>
 */
export default class MainService extends CoreService {
  private static instance: MainService;
  private client = ODataClientFactory.getMainServiceClient();
  private resourceModel: ResourceModel = new ResourceModel({
    bundleName: "inventory1.i18n.i18n",
    supportedLocales: ["de"],
    fallbackLocale: "de",
  });
  private resourcBundle =
    this.resourceModel.getResourceBundle() as ResourceBundle;

  private constructor() {
    super();
  }

  public static getInstance(): MainService {
    if (!MainService.instance) {
      MainService.instance = new MainService();
    }
    return MainService.instance;
  }

  public getResourceModel(): ResourceModel {
    return this.resourceModel;
  }

  public getText(key: string, args?: string[]): string {
    return this.resourcBundle.getText(key, args) ?? key;
  }

  public setScan(scan = ""): void {
    this.appState.setScan(scan);
  }

  public async readOpenPiDocs(): Promise<PiDoc[]> {
    this.appState.setPiItems([]);
    return this.execute<PiDoc[]>(() =>
      this.client
        .piDocument()
        .query()
        .then(response => {
          this.appState.setPiDocuments(response.data.value);
          return response.data.value;
        })
    );
  }

  public async startCounting(scan: string): Promise<void> {
    return scan
      ? this.execute<void>(() =>
        this.client
          .piDocument()
          .startCounting({ scan })
          .then(response => {
            this.appState.setPiHeader(response.data);
            const piItems = response.data.items.map<PiItem>(r => ({
              ...r,
              huDeleted: false,
            }));
            this.appState.setPiItems(piItems);
          })
      )
      : Promise.resolve();
  }

  public async selectPiDocument(key: DocKey): Promise<void> {
    let piItems = this.appState.getPiItems();
    if (
      !piItems.length ||
      piItems[0].docYear !== key.docYear ||
      piItems[0].docNumber !== key.docNumber ||
      piItems[0].itemNo !== key.itemNo
    ) {
      await this.startCounting(`${key.docYear}-${key.docNumber}-${key.itemNo}`);
    }
  }

  public async unassignPiDoc(key: DocKey): Promise<void> {
    return this.execute<void>(() =>
      this.client
        .piDocument(key)
        .unassign()
        .then(() => {
          this.appState.setAssigned(key, false);
        })
    );
  }

  public getPiItems(): PiItem[] {
    return this.appState.getPiItems();
  }

  public async saveCounting(): Promise<ZewvaUiPiSaveResult | undefined> {
    const piItems = this.appState.getPiItems();
    const piHeader = this.appState.getPiHeader();
    if (!piHeader) {
      return;
    }
    // eslint-disable-next-line consistent-return
    return this.execute<ZewvaUiPiSaveResult | undefined>(() => {
      if (!this.isCountComplete()) {
        throw new Error(this.getText("countingIncomplete"));
      }
      return this.client
        .piDocument()
        .saveCounting({
          docNumber: piHeader.docNumber,
          docYear: piHeader.docYear,
          itemNo: piHeader.itemNo,
          items: piItems.map(i => ({
            docYear: i.docYear,
            docNumber: i.docNumber,
            itemNo: i.itemNo,
            huident: i.huident,
            matnr: i.matnr,
            charg: i.charg,
            cat: i.cat,
            enteredQuantity: i.enteredQuantity,
            enteredUnit: i.enteredUnit,
            huDeleted: i.huDeleted,
          })),
        })
        .then(response => response.data);
    });
  }

  public selectTab(key: string): void {
    this.appState.selectTab(key);
  }

  public getHuScan(): string {
    return this.appState.getHuScan();
  }

  public setHuScan(value: string): void {
    this.appState.setHuScan(value);
  }

  public setEnteredQuantity(huident: string, enteredQuantity: number): void {
    this.appState.setEnteredQuantity(huident, enteredQuantity);
  }

  public isCountComplete(): boolean {
    const countResult = this.appState.getPiItems();
    for (const line of countResult) {
      if (!line.huDeleted && !line.enteredQuantity) {
        return false;
      }
    }
    return true;
  }

  public async saveCountOfHu(): Promise<ZewvaUiPiSaveResult | undefined> {
    const piItems = this.appState.getPiItems();
    piItems.forEach(line => {
      line.enteredQuantity = line.stockQuantity;
    });
    this.appState.setPiItems(piItems);
    return this.saveCounting();
  }
}
