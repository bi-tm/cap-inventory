import type UIComponent from "sap/ui/core/UIComponent";
import type { ZewvcUiUserParam } from "../src-gen/user-service/ComSapGatewaySrvdA2xZewUiUserParamV4V0001Model";
import type {
  AppStateData,
  DocKey,
  PiDoc,
  PiHeader,
  PiItem,
} from "../types/AppTypes";
import type { TypeSafeJsonModel } from "../types/TypeSafeJsonModel";

import { createJsonModel } from "../types/TypeSafeJsonModel";

export default class AppState {
  private static instance: AppState;
  private model: TypeSafeJsonModel<AppStateData>;

  private static readonly INITIAL_STATE: AppStateData = {
    userParam: null,
    isInitialized: false,
    isLoggedIn: false,
    isLoading: false,
    error: null,
    showError: false,
    piDocuments: [],
    piHeader: null,
    piItems: [],
    countOfHu: 0,
    scan: "",
    itemIndex: 0,
    selectedTab: "1",
    huScan: "",
  };

  private constructor() {
    this.model = createJsonModel({ ...AppState.INITIAL_STATE });
  }

  public static getInstance(): AppState {
    if (!AppState.instance) {
      AppState.instance = new AppState();
    }
    return AppState.instance;
  }

  public registerOnComponent(component: UIComponent): void {
    component.setModel(this.model);
  }

  // -------------------------------------------------------
  // Getter
  // -------------------------------------------------------
  public getUserParam(): ZewvcUiUserParam | null {
    return this.model.getData().userParam;
  }

  public isInitialized(): boolean {
    return this.model.getData().isInitialized;
  }

  public isLoggedIn(): boolean {
    return this.model.getData().isLoggedIn;
  }

  public getScan(): string {
    return this.model.getData().scan;
  }

  public getPiHeader(): PiHeader | null {
    return this.model.getData().piHeader;
  }

  public getPiItems(): PiItem[] {
    return this.model.getData().piItems;
  }

  public getHuScan(): string {
    return this.model.getData().huScan;
  }

  public getCountOfHu(): number {
    return this.model.getData().countOfHu;
  }

  // -------------------------------------------------------
  // Setter
  // -------------------------------------------------------
  public setUserParam(userParam: ZewvcUiUserParam): void {
    this.model.setData({ userParam }, true);
  }

  public setLoading(isLoading: boolean): void {
    this.model.setData({ isLoading }, true);
  }

  public setInitialized(): void {
    this.model.setData({ isInitialized: true, error: null }, true);
  }

  public setError(message: string): void {
    this.model.setData(
      { error: message, isLoading: false, showError: true },
      true
    );
  }

  public clearError(): void {
    this.model.setData({ error: null, showError: false }, true);
  }

  public setShowError(show: boolean): void {
    this.model.setData({ showError: show }, true);
  }

  public logIn(): void {
    this.model.setData({ isLoggedIn: true, error: null }, true);
  }

  public logOut(): void {
    this.model.setData({ isLoggedIn: false }, true);
  }

  public reset(): void {
    this.model.setData({ ...AppState.INITIAL_STATE });
  }

  public setPiDocuments(piDocuments: PiDoc[]): void {
    const odata = { ...this.model.getData(), piDocuments: piDocuments };
    this.model.setData(odata, false);
  }

  public setPiHeader(piHeader: PiHeader): void {
    this.model.setData({ piHeader: piHeader }, true);
  }

  public setPiItems(piItems: PiItem[]): void {
    const odata = { ...this.model.getData(), piItems: piItems };
    this.model.setData(odata, false);
  }

  public setScan(scan = ""): void {
    this.model.setData({ scan: scan }, true);
  }

  public selectTab(key: string): void {
    this.model.setData({ selectedTab: key }, true);
  }

  public setHuScan(value: string): void {
    this.model.setData({ huScan: value }, true);
  }

  public setEnteredQuantity(huident: string, enteredQuantity: number): void {
    const piItems = this.getPiItems();
    const line = piItems.find(i => i.huident === huident);
    if (line) {
      line.enteredQuantity = enteredQuantity;
      this.setPiItems(piItems);
    }
  }

  public clearCountOfHu(): void {
    this.model.setData({ countOfHu: 0 }, true);
  }

  public setAssigned(key: DocKey, assigned: boolean = true): void {
    const piDocuments = this.model.getData().piDocuments;
    const item = piDocuments.find(
      i =>
        i.docNumber === key.docNumber &&
        i.docYear === key.docYear &&
        i.itemNo === key.itemNo
    );
    if (item) {
      // set assigned flag for all PI documents with same WHO number
      piDocuments
        .filter(i => i.who === item.who)
        .forEach(i => (i.assigned = assigned));
      this.setPiDocuments(piDocuments);
    }
  }
}
