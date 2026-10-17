import BaseComponent from "sap/ui/core/UIComponent";
import Device from "sap/ui/Device";
import JSONModel from "sap/ui/model/json/JSONModel";
import AppState from "./model/AppState";
import MainService from "./service/MainService";
import UserService from "./service/UserService";

/**
 * @namespace iventory1
 */
export default class Component extends BaseComponent {
    public static metadata = {
        manifest: "json",
        interfaces: ["sap.ui.core.IAsyncContentCreation"],
    };

    // Resolved by App.controller once the userParam/login flow (started in
    // App.controller#onInit) has finished, so other controllers can await the
    // outcome instead of racing AppState while it is still loading.
    private resolveAppStateReady!: () => void;
    private readonly appStateReady: Promise<void> = new Promise(resolve => {
        this.resolveAppStateReady = resolve;
    });
    public init(): void {
        // call the base component's init function
        super.init();

        // set the device model
        const deviceModel = new JSONModel(Device);
        deviceModel.setDefaultBindingMode("OneWay");
        this.setModel(deviceModel, "device");

        this.setModel(MainService.getInstance().getResourceModel(), "i18n");

        AppState.getInstance().registerOnComponent(this);

        // enable routing
        this.getRouter().initialize();
    }

    public getAppStateReady(): Promise<void> {
        return this.appStateReady;
    }

    public markAppStateReady(): void {
        this.resolveAppStateReady();
    }

    public exit(): void {
        // FLP back button fires Component.exit() while the FLP SPA context stays alive,
        // so the Axios request will complete even though the component is being torn down.
        const state = AppState.getInstance();
        if (state.isLoggedIn()) {
            const userParam = state.getUserParam();
            if (userParam) {
                void UserService.getInstance()
                    .rsrcLogoff(userParam.warehouse, userParam.rsrc)
                    .catch(() => { });
            }
        }
    }
}
