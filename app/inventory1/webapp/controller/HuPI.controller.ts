import type { DocKey, HuPiRouteParam, PiItem } from "inventory1/types/AppTypes";

import { type IconTabBar$SelectEvent } from "sap/m/IconTabBar";
import { type ListBase$ItemPressEvent } from "sap/m/ListBase";
import MessageToast from "sap/m/MessageToast";
import { type Route$MatchedEvent } from "sap/ui/core/routing/Route";
import { ROUTE } from "inventory1/types/AppTypes";
import BaseController from "./BaseController";

/**
 * @namespace inventory1
 */
export default class HuPiController extends BaseController {
  private routeParam: HuPiRouteParam;

  public onInit(): void {
    // empty
    this.getRouter()
      .getRoute(ROUTE.HuPi)
      // eslint-disable-next-line @typescript-eslint/no-misused-promises
      ?.attachMatched(this.onRouteMatched.bind(this));
  }

  public async onRouteMatched(event: Route$MatchedEvent): Promise<void> {
    // eslint-disable-next-line @typescript-eslint/unbound-method
    this.setShellBarBackNavigation(this.navigateBack);
    this.routeParam = event.getParameters().arguments! as HuPiRouteParam;
    if (this.routeParam.index === undefined) {
      this.routeParam.index = "";
    }
    await this.readPiDocument(this.routeParam);
    this.setIndex(this.routeParam.index);
  }

  public navigateBack(scan?: string): void {
    if (scan) {
      this.navigateTo(ROUTE.Scan, { scan: scan });
    } else {
      this.navigateTo(ROUTE.Home);
    }
  }

  public onTabSelected(event: IconTabBar$SelectEvent): void {
    const param = event.getParameters();
    if (param.key === "1") {
      // Fokus setzen
      this.setFocus(this.getFocusId());
    }
  }

  public onHuSelected(event: ListBase$ItemPressEvent): void {
    const item = event
      .getParameters()
      .listItem?.getBindingContext()
      ?.getObject() as PiItem | undefined;
    if (item) {
      const index = this.mainService
        .getPiItems()
        .findIndex(
          i =>
            i.docNumber === item.docNumber &&
            i.itemNo === item.itemNo &&
            i.huident === item.huident &&
            i.matnr === item.matnr &&
            i.charg === item.charg &&
            i.cat === item.cat
        );
      if (index >= 0) {
        this.setIndex(index.toString());
      }
    }
  }

  public onScanHu(): void {
    const piItems = this.mainService.getPiItems();
    const huScan = this.mainService.getHuScan();
    const index = piItems.findIndex(item => item.huident === huScan);
    if (index < 0) {
      this.mainService.setHuScan("");
      this.mainService.setErrorMessage(this.mainService.getText("wrongHu"));
      this.setFocus("idHuScan");
    } else {
      this.mainService.clearError();
      if (this.mainService.isCountComplete()) {
        // Zur Positionsliste zur Kontrolle
        this.mainService.selectTab("2");
      } else {
        // In der Maske bleiben und näxhste HU scannen
        this.setIndex(index.toString());
      }
    }
  }

  public async onQuantitySubmit(): Promise<void> {
    if (this.mainService.isCountComplete()) {
      await this.onSave();
    } else {
      this.setIndex("");
    }
  }

  public onHuDeletedChanged(): void {
    const correntLine = this.getCurrentResultLine();
    if (correntLine?.huDeleted) {
      this.mainService.setEnteredQuantity(correntLine.huident, 0);
      // weiter zur nächsten Zeile
      this.setBusy(true);
      // eslint-disable-next-line @sap-ux/fiori-tools/sap-timeout-usage
      setTimeout(() => {
        this.setBusy(false);
        void this.onQuantitySubmit();
      }, 200);
    } else {
      this.setFocus(this.getFocusId());
    }
  }

  public async onSave(): Promise<void> {
    try {
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      const nextDocument = await this.mainService.saveCounting();
      MessageToast.show(this.mainService.getText("countingSuccessfull"), {
        closeOnBrowserNavigation: false,
      });
      const scan = nextDocument?.nextItemNo
        ? `${nextDocument.nextDocYear}-${nextDocument.nextDocNumber}-${nextDocument.nextItemNo}`
        : undefined;
      this.navigateBack(scan);
    } catch {
      this.setFocus("idHuScan");
    }
  }

  private async readPiDocument(key: DocKey): Promise<void> {
    await this.mainService.selectPiDocument(key);
  }

  private getCurrentResultLine(): PiItem | undefined {
    return this.getView()?.getBindingContext()?.getObject() as
      | PiItem
      | undefined;
  }

  /**
   * Eine Zeile der mögliche HU auswählen.
   * Es wird der navigationspfad angepasst, und somit onRouteMatched durchlaufen
   * @param index
   * @returns
   */
  private setIndex(index: string | undefined): void {
    let newIndex = "";
    const items = this.mainService.getPiItems();
    let indexNo = index ? Number.parseInt(index, 10) : NaN;
    if (isNaN(indexNo)) {
      if (items.length === 1) {
        // wenn es nur eine Zeile gibt, diese anzeigen
        indexNo = 0;
        newIndex = "0";
      } else {
        // wenn es mehrere Zeilen gibt, keine auswählen, dann muss gescannt werden
      }
    } else if (indexNo >= 0 && indexNo < items.length) {
      // eine Zeile ist eindeutig ausgewählt
      newIndex = indexNo.toString();
    }
    if (newIndex !== this.routeParam.index) {
      // Index wurde geändert, Route ändern, dadurch wird neu geladen
      this.routeParam.index = newIndex;
      this.navigateTo(ROUTE.HuPi, this.routeParam);
    } else {
      // Daten zum augewählten Index anzeigen
      this.setBindingContext();
      this.mainService.selectTab("1");
      // huIdent in Feld huScan anzeigen
      this.mainService.setHuScan(this.getCurrentResultLine()?.huident ?? "");
      // Fokus setzen
      this.setFocus(this.getFocusId());
    }
  }

  private getFocusId(): string {
    const item = this.getView()?.getBindingContext()?.getObject() as
      | PiItem
      | undefined;
    if (!item?.matnr) {
      return "idHuScan";
    } else {
      const items = this.mainService.getPiItems();
      if (items.length === 1 || this.routeParam.index) {
        return "idQty";
      } else {
        return "idHuScan";
      }
    }
  }

  private setBindingContext(): void {
    if (this.routeParam.index) {
      this.getView()?.bindObject(`/piItems/${this.routeParam.index}`);
    } else {
      this.getView()?.unbindObject();
    }
  }
}
