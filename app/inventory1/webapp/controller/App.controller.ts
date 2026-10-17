import type Component from "../Component";

import ErrorHandler from "../service/ErrorHandler";
import UserService from "../service/UserService";
import BaseController from "./BaseController";

/**
 * @namespace inventory1
 */
export default class AppController extends BaseController {
  public onInit(): void {
    void this.loadAppState();
  }

  public onExit(): void {
    this.appState.reset();
  }

  private async loadAppState(): Promise<void> {
    try {
      try {
        await UserService.getInstance().getUserParams();
      } catch (error) {
        this.appState.setError(ErrorHandler.getInstance().parseError(error));
        this.showErrorStrip();
        return;
      }
      await this.login();
    } finally {
      (this.getOwnerComponent() as unknown as Component).markAppStateReady();
    }
  }

  private async login(): Promise<void> {
    const userParam = this.appState.getUserParam();
    if (!userParam) {
      this.appState.setInitialized();
      this.appState.setError("Keine Benutzerparameter gefunden");
      this.navigateTo("RouteHome");
      this.showErrorStrip();
      return;
    }
    try {
      await UserService.getInstance().rsrcLogon(
        userParam.warehouse,
        userParam.rsrc
      );
      this.appState.setInitialized();
    } catch (error) {
      this.appState.setInitialized();
      this.appState.setError(ErrorHandler.getInstance().parseError(error));
      this.navigateTo("RouteHome");
      this.showErrorStrip();
    }
  }
}
