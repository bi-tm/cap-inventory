import { AxiosClient } from "@odata2ts/http-client-axios";
import { ComSapGatewaySrvdA2xZewUiPiV0001Service } from "inventory1/src-gen/main-service/ComSapGatewaySrvdA2xZewUiPiV0001Service";
import { ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service } from "../src-gen/user-service/ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service";

export default class ODataClientFactory {
  private static userServiceInstance: ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service<AxiosClient>;
  private static mainServiceInstance: ComSapGatewaySrvdA2xZewUiPiV0001Service<AxiosClient>;

  static USER_SERVICE_PATH =
    "/sap/opu/odata4/sap/zew_ui_user_param_v4/srvd_a2x/sap/zew_ui_user_param_v4/0001";
  static MAIN_SERVICE_PATH =
    "/odata/v4/v0001";

  public static getUserServiceClient(): ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service<AxiosClient> {
    if (!ODataClientFactory.userServiceInstance) {
      const httpClient = new AxiosClient(
        { baseURL: "/", withCredentials: true },
        {
          useCsrfProtection: true,
          csrfTokenFetchUrl: this.USER_SERVICE_PATH,
        }
      );
      ODataClientFactory.userServiceInstance =
        new ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service(
          httpClient,
          this.USER_SERVICE_PATH
        );
    }
    return ODataClientFactory.userServiceInstance;
  }

  public static getMainServiceClient(): ComSapGatewaySrvdA2xZewUiPiV0001Service<AxiosClient> {
    if (!ODataClientFactory.mainServiceInstance) {
      const httpClient = new AxiosClient(
        { baseURL: "/", withCredentials: true },
        {
          useCsrfProtection: true,
          csrfTokenFetchUrl: this.MAIN_SERVICE_PATH,
        }
      );
      ODataClientFactory.mainServiceInstance =
        new ComSapGatewaySrvdA2xZewUiPiV0001Service<AxiosClient>(
          httpClient,
          this.MAIN_SERVICE_PATH
        );
    }
    return ODataClientFactory.mainServiceInstance;
  }
}
