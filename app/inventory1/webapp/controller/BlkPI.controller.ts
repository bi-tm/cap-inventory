import type { BlkPiRouteParam } from "inventory1/types/AppTypes";

import MessageBox from "sap/m/MessageBox";
import MessageToast from "sap/m/MessageToast";
import { type Route$MatchedEvent } from "sap/ui/core/routing/Route";
import { ROUTE } from "inventory1/types/AppTypes";
import BaseController from "./BaseController";

/**
 * @namespace inventory1
 */
export default class BlkPiController extends BaseController {
  private routeParam: BlkPiRouteParam;

  public onInit(): void {
    // empty
    this.getRouter()
      .getRoute(ROUTE.BlkPi)
      ?.attachMatched(this.onRouteMatched.bind(this));
  }

  public onRouteMatched(event: Route$MatchedEvent): void {
    this.setShellBarBackNavigation(this.navigateBack.bind(this));
    this.routeParam = event.getParameters().arguments as BlkPiRouteParam;
    void this.selectPiDocument();
    this.appState.clearCountOfHu();
    this.setFocus("idCountOfHu");
  }

  private async selectPiDocument(): Promise<void> {
    await this.mainService.selectPiDocument(this.routeParam);
    this.getView()?.bindObject(`/piItems/0`);
    this.setFocus("idQty");
    // this.setFocus("idHU");
  }

  public navigateBack(scan?: string): void {
    if (scan) {
      this.navigateTo(ROUTE.Scan, { scan: scan });
    } else {
      this.navigateTo(ROUTE.Home);
    }
  }

  public async onCountOfHuSubmit(): Promise<void> {
    await this.onSave();
  }

  public async onSave(): Promise<void> {
    const countOfHu = this.appState.getCountOfHu();
    if (!countOfHu) {
      this.setFocus("idCountOfHu");
      return;
    }
    const items = this.appState.getPiItems();
    if (countOfHu === items.length) {
      // Anzahl passt, Inventurbeleg quittieren
      const nextDocument = await this.mainService.saveCountOfHu();
      MessageToast.show(this.mainService.getText("countingSuccessfull"), {
        closeOnBrowserNavigation: false,
      });
      const scan = nextDocument?.nextItemNo
        ? `${nextDocument.nextDocYear}-${nextDocument.nextDocNumber}-${nextDocument.nextItemNo}`
        : undefined;
      this.navigateBack(scan);
    } else {
      // Anzahl passt nicht, MessageBox anzeigen und anschließende zu Erfassung der einzelnen HU
      MessageBox.error(this.mainService.getText("wrongCountOfHu"), {
        onClose: () => {
          this.navigateTo(ROUTE.HuPi, this.routeParam);
        },
      });
    }
  }
}
