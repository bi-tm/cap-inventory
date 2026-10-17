/* eslint-disable @typescript-eslint/unbound-method */
import type Dialog from "sap/m/Dialog";
import type { DocKey, PiDoc, PiItem } from "inventory1/types/AppTypes";

import { type Button$PressEvent } from "sap/m/Button";
import { type ListBase$ItemPressEvent } from "sap/m/ListBase";
import MessageToast from "sap/m/MessageToast";
import { type Route$MatchedEvent } from "sap/ui/core/routing/Route";
import { ROUTE } from "inventory1/types/AppTypes";
import BaseController from "./BaseController";

/**
 * @namespace inventory1
 */
export default class HomeController extends BaseController {
  private equalHuDialog: Dialog;
  private emptyBinDialog: Dialog;

  public onInit(): void {
    this.equalHuDialog = this.getView()?.byId("equalHuQuestionId") as Dialog;
    this.emptyBinDialog = this.getView()?.byId("emptyBinQuestionId") as Dialog;
    // empty
    this.getRouter()
      .getRoute("Home")
      ?.attachMatched(this.onRouteHomeMatched.bind(this));
    this.getRouter()
      .getRoute("Scan")
      ?.attachMatched(this.onRouteScanMatched.bind(this));
  }

  public onRouteHomeMatched(): void {
    this.setShellBarBackNavigation(this.navigateToLaunchpad);
    void this.onRefresh();
  }

  public onRouteScanMatched(event: Route$MatchedEvent): void {
    this.setShellBarBackNavigation(this.navigateToLaunchpad);
    void this.onRefresh();
    const { scan } = event.getParameters().arguments! as { scan: string };
    this.appState.setScan(scan);
    this.onScanChanged();
  }

  public onOpenPiDocSetListItemPress(event: ListBase$ItemPressEvent): void {
    const selectedItem = event
      .getParameters()
      .listItem?.getBindingContext()
      ?.getObject() as unknown as PiDoc;
    // Kompletten Schlüssel "year-document-item" der Zeile als Scan verwenden
    void this.startCounting(
      `${selectedItem.docYear}-${selectedItem.docNumber}-${selectedItem.itemNo}`
    );
  }

  public async onUnassignPressed(event: Button$PressEvent): Promise<void> {
    const selectedItem = event
      .getSource()
      .getBindingContext()
      ?.getObject() as unknown as PiDoc;
    await this.mainService.unassignPiDoc({
      docNumber: selectedItem.docNumber,
      docYear: selectedItem.docYear,
      itemNo: selectedItem.itemNo,
    });
    this.onRefresh();
  }

  public onRefresh(): void {
    this.mainService.setScan();
    void this.mainService.readOpenPiDocs();
    this.setFocus("idScan");
  }

  public onScanChanged(): void {
    const scan = this.appState.getScan();
    void this.startCounting(scan);
  }

  private async startCounting(scan: string): Promise<void> {
    try {
      await this.mainService.startCounting(scan);
      const piItems = this.appState.getPiItems();
      if (piItems.length > 0) {
        if (this.equalItems(piItems)) {
          this.equalHuDialog.open();
        } else {
          this.startHuPi();
        }
      } else {
        this.emptyBinDialog.open();
      }
    } catch (error: unknown) {
      // eslint-disable-next-line no-console
      console.error(error);
    }
  }

  private equalItems(items: PiItem[]): boolean {
    if (items.length === 1) {
      return false;
    }
    const firstItem = items[0];
    for (let i = 1; i < items.length; i++) {
      const nextItem = items[i];
      if (
        nextItem.matnr !== firstItem.matnr ||
        nextItem.stockQuantity !== firstItem.stockQuantity
      ) {
        return false;
      }
    }
    return true;
  }

  public startBulkPi(): void {
    this.equalHuDialog?.close();
    const key = this.appState.getPiHeader() as DocKey;
    this.navigateTo(ROUTE.BlkPi, key);
  }

  public startHuPi(): void {
    this.equalHuDialog?.close();
    const key = this.appState.getPiHeader() as DocKey;
    this.navigateTo(ROUTE.HuPi, key);
  }

  public async countEmptyBin(): Promise<void> {
    const nextDocument = await this.mainService.saveCounting();
    MessageToast.show(this.mainService.getText("countingSuccessfull"), {
      closeOnBrowserNavigation: false,
    });
    this.emptyBinDialog?.close();
    let scan = "";
    if (nextDocument?.nextDocNumber) {
      scan = `${nextDocument.nextDocYear}-${nextDocument.nextDocNumber}-${nextDocument.nextItemNo}`;
      void this.startCounting(scan);
    }
    if (this.appState.getScan() === scan) {
      this.onRefresh();
    } else {
      if (scan) {
        this.navigateTo(ROUTE.Scan, { scan: scan });
      } else {
        this.navigateTo(ROUTE.Home);
      }
    }
  }

  public cancelEqualHuDialog(): void {
    this.appState.setScan();
    this.setFocus("idScan");
    this.equalHuDialog?.close();
  }

  public cancelEmptyBinDialog(): void {
    this.appState.setScan();
    this.setFocus("idScan");
    this.emptyBinDialog?.close();
  }
}
