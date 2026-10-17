import type AppComponent from "sap/fe/core/AppComponent";
import type Router from "sap/m/routing/Router";
import type Control from "sap/ui/core/Control";
import type BaseComponent from "sap/ui/core/UIComponent";
import type CrossApplicationNavigation from "sap/ushell/services/CrossApplicationNavigation";

import Controller from "sap/ui/core/mvc/Controller";
import History from "sap/ui/core/routing/History";
import MainService from "inventory1/service/MainService";
import { ROUTE } from "inventory1/types/AppTypes";
import AppState from "../model/AppState";

type RouteParams = Record<string, string>;
type EncodedRouteParams<T extends RouteParams> = { [K in keyof T]: string };

function parseRouteParams<T extends RouteParams>(
  params: EncodedRouteParams<T>
): T {
  return Object.fromEntries(
    Object.entries(params).map(([k, v]): [string, string] => [
      k,
      decodeURIComponent(v),
    ])
  ) as T;
}

/**
 * @namespace inventory1
 */
export default abstract class BaseController extends Controller {
  private static errorStripTimer: ReturnType<typeof setTimeout> | undefined;
  protected readonly appState = AppState.getInstance();
  protected readonly mainService = MainService.getInstance();

  public navigateBack(): void {
    const previousHash = History.getInstance().getPreviousHash();
    if (previousHash !== undefined) {
      window.history.go(-1);
    } else {
      this.navigateTo(ROUTE.Home);
    }
  }

  public navigateToLaunchpad(): void {
    this.getOwnerComponent()
      .getService("CrossApplicationNavigation")
      .then(crossAppNavigator => {
        void (crossAppNavigator as CrossApplicationNavigation).toExternal({
          target: { semanticObject: "#" },
        });
      })
      .catch(() => {
        // eslint-disable-next-line no-console
        console.error("Unable to navigate to launchpad");
        this.navigateBack();
      });
  }

  public onMessagesButtonPress(): void { }

  /**
   * Convenience method for accessing the component of the controller's view.
   * @returns The component of the controller's view
   */
  public getOwnerComponent(): AppComponent {
    return super.getOwnerComponent() as AppComponent;
  }

  protected getRouter(): Router {
    const component = this.getOwnerComponent() as BaseComponent;
    if (!component) {
      throw new Error("No owner component found");
    }
    return component.getRouter() as Router;
  }

  protected getCurrentRouteParameters<T extends RouteParams>(): T {
    const router = this.getRouter();
    const currentHash = router.getHashChanger().getHash();
    const { arguments: routeArguments } =
      router.getRouteInfoByHash(currentHash) ?? {};
    return parseRouteParams<T>((routeArguments ?? {}) as EncodedRouteParams<T>);
  }

  protected navigateTo(
    routeName: string,
    parameters?: Record<string, string>
  ): void {
    this.getRouter().navTo(routeName, parameters ?? {});
  }

  protected showErrorStrip(): void {
    clearTimeout(BaseController.errorStripTimer);
    this.appState.setShowError(true);
    // eslint-disable-next-line @sap-ux/fiori-tools/sap-timeout-usage
    BaseController.errorStripTimer = setTimeout(() => {
      this.appState.setShowError(false);
    }, 5000);
  }

  protected setBusy(busy: boolean): void {
    this.appState.setLoading(busy);
  }

  protected setFocus(controlId: string | Control): void {
    const control =
      typeof controlId === "string"
        ? this.getView()?.byId(controlId)
        : controlId;
    if (control) {
      // eslint-disable-next-line @sap-ux/fiori-tools/sap-timeout-usage
      setTimeout(() => {
        control.focus();
      }, 500);
    }
  }

  /**
   * define callback for back navigation in fiori launchpad
   */
  public setShellBarBackNavigation(backNavigator: () => void): void {
    try {
      // eslint-disable-next-line @typescript-eslint/no-floating-promises
      this.getOwnerComponent()
        .getService("ShellUIService")
        .then(shellService => {
          // eslint-disable-next-line @typescript-eslint/no-unsafe-call, @typescript-eslint/no-unsafe-member-access
          shellService.setBackNavigation(backNavigator.bind(this));
        });
    } catch {
      // eslint-disable-next-line no-console
      console.error("Unable set shell navigation");
    }
  }
}
