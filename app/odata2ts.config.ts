import { ConfigFileOptions, EmitModes } from "@odata2ts/odata2ts";

const { BACKEND_URL, SAP_USERNAME, SAP_PASSWORD, SAP_CLIENT } = process.env;

const RAP_MANAGED_PROPERTIES = [
  "CreatedAt",
  "CreatedBy",
  "ModifiedAt",
  "ModifiedBy",
  "SAP__Messages",
].map(prop => ({
  name: prop,
  managed: true,
}));

const sourceUrlConfig = {
  username: SAP_USERNAME ?? "",
  password: SAP_PASSWORD ?? "",
  custom: {
    headers: {
      "sap-client": SAP_CLIENT ?? "",
    },
  },
};

const config: ConfigFileOptions = {
  allowRenaming: true,
  emitMode: EmitModes.ts,
  skipComments: true,

  services: {
    userService: {
      source: "webapp/localService/user-service/metadata.xml",
      sourceUrl: `${BACKEND_URL}/sap/opu/odata4/sap/zew_ui_user_param_v4/srvd_a2x/sap/zew_ui_user_param_v4/0001/$metadata`,
      output: "webapp/src-gen/user-service",
      sourceUrlConfig,
      propertiesByName: RAP_MANAGED_PROPERTIES,
    },
    mainService: {
      source: "webapp/localService/main-service/metadata.xml",
      sourceUrl: `${BACKEND_URL}/<BACKEND_SERVICE>/$metadata`,
      output: "webapp/src-gen/main-service",
      sourceUrlConfig,
      propertiesByName: RAP_MANAGED_PROPERTIES,
    },
  },
};

export default config;
