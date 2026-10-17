// @ts-nocheck
import type { ODataModelResponseV4 } from "@odata2ts/odata-core";
import type { ODataHttpClient, ODataHttpClientConfig, HttpResponseModel } from "@odata2ts/http-client-api";
import { ODataService, EntityTypeServiceV4, ODataServiceOptionsInternal, EntitySetServiceV4 } from "@odata2ts/odata-service";
import type { UserParamTypeId, UserParamType, EditableUserParamType, ZewvcUiRsrc, UserParamType_RsrcLogoffParams, ZewvcUiUserParam, UserParamType_RsrcLogonParams } from "./ComSapGatewaySrvdA2xZewUiUserParamV4V0001Model";
import type { QUserParamType } from "./QComSapGatewaySrvdA2xZewUiUserParamV4V0001";
import { QUserParamTypeId, qUserParamType, UserParamType_QRsrcLogoff, UserParamType_QGetUserParam, UserParamType_QRsrcLogon } from "./QComSapGatewaySrvdA2xZewUiUserParamV4V0001";

export class ComSapGatewaySrvdA2xZewUiUserParamV4V0001Service<in out ClientType extends ODataHttpClient> extends ODataService<ClientType> {
    public userParam(): UserParamTypeCollectionService<ClientType>;
    public userParam(id: UserParamTypeId): UserParamTypeService<ClientType>;
    public userParam(id?: UserParamTypeId | undefined) {
        const fieldName = "UserParam";
        const { client, path, options, isUrlNotEncoded } = this.__base;
        return typeof id === "undefined" || id === null
        ? new UserParamTypeCollectionService(client, path, fieldName, options)
        : new UserParamTypeService(client, path, new QUserParamTypeId(fieldName).buildUrl(id, isUrlNotEncoded()), options);
    }
}

export class UserParamTypeService<in out ClientType extends ODataHttpClient> extends EntityTypeServiceV4<ClientType, UserParamType, EditableUserParamType, QUserParamType> {
    constructor(client: ClientType, basePath: string, name: string, options?: ODataServiceOptionsInternal) {
        super(client, basePath, name, qUserParamType, options);
    }
}

export class UserParamTypeCollectionService<in out ClientType extends ODataHttpClient> extends EntitySetServiceV4<ClientType, UserParamType, EditableUserParamType, QUserParamType, UserParamTypeId> {
    private _userParamTypeQRsrcLogoff?: UserParamType_QRsrcLogoff;
    private _userParamTypeQGetUserParam?: UserParamType_QGetUserParam;
    private _userParamTypeQRsrcLogon?: UserParamType_QRsrcLogon;

    constructor(client: ClientType, basePath: string, name: string, options?: ODataServiceOptionsInternal) {
        super(client, basePath, name, qUserParamType, new QUserParamTypeId(name), options);
    }

    public async rsrcLogoff(params: UserParamType_RsrcLogoffParams, requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<ZewvcUiRsrc>>> {
        if(!this._userParamTypeQRsrcLogoff) {
          this._userParamTypeQRsrcLogoff = new UserParamType_QRsrcLogoff()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._userParamTypeQRsrcLogoff.buildUrl(params, isUrlNotEncoded()));
        const response = await  client.get(url, requestConfig, getDefaultHeaders());
        return this._userParamTypeQRsrcLogoff.convertResponse(response);
    }

    public async getUserParam(requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<ZewvcUiUserParam>>> {
        if(!this._userParamTypeQGetUserParam) {
          this._userParamTypeQGetUserParam = new UserParamType_QGetUserParam()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._userParamTypeQGetUserParam.buildUrl(isUrlNotEncoded()));
        const response = await  client.get(url, requestConfig, getDefaultHeaders());
        return this._userParamTypeQGetUserParam.convertResponse(response);
    }

    public async rsrcLogon(params: UserParamType_RsrcLogonParams, requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<ZewvcUiRsrc>>> {
        if(!this._userParamTypeQRsrcLogon) {
          this._userParamTypeQRsrcLogon = new UserParamType_QRsrcLogon()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._userParamTypeQRsrcLogon.buildUrl(params, isUrlNotEncoded()));
        const response = await  client.get(url, requestConfig, getDefaultHeaders());
        return this._userParamTypeQRsrcLogon.convertResponse(response);
    }
}
