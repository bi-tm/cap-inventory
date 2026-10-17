// @ts-nocheck
import type { ODataModelResponseV4 } from "@odata2ts/odata-core";
import type { StringCollection } from "@odata2ts/odata-query-objects";
import { QStringCollection } from "@odata2ts/odata-query-objects";
import type { ODataHttpClient, ODataHttpClientConfig, HttpResponseModel } from "@odata2ts/http-client-api";
import { ODataService, EntityTypeServiceV4, ODataServiceOptionsInternal, CollectionServiceV4, EntitySetServiceV4 } from "@odata2ts/odata-service";
import type { PiDocumentTypeId, PiDocumentType, EditablePiDocumentType, SapMessage, EditableSapMessage, ZewvaUiPiCount, PiDocumentType_StartCountingParams, ZewvaUiPiSaveResult, PiDocumentType_SaveCountingParams } from "./ComSapGatewaySrvdA2xZewUiPiV0001Model";
import type { QPiDocumentType, QSapMessage } from "./QComSapGatewaySrvdA2xZewUiPiV0001";
import { QPiDocumentTypeId, qPiDocumentType, qSapMessage, PiDocumentType_QUnassign, PiDocumentType_QStartCounting, PiDocumentType_QSaveCounting } from "./QComSapGatewaySrvdA2xZewUiPiV0001";

export class ComSapGatewaySrvdA2xZewUiPiV0001Service<in out ClientType extends ODataHttpClient> extends ODataService<ClientType> {
    public piDocument(): PiDocumentTypeCollectionService<ClientType>;
    public piDocument(id: PiDocumentTypeId): PiDocumentTypeService<ClientType>;
    public piDocument(id?: PiDocumentTypeId | undefined) {
        const fieldName = "PiDocument";
        const { client, path, options, isUrlNotEncoded } = this.__base;
        return typeof id === "undefined" || id === null
        ? new PiDocumentTypeCollectionService(client, path, fieldName, options)
        : new PiDocumentTypeService(client, path, new QPiDocumentTypeId(fieldName).buildUrl(id, isUrlNotEncoded()), options);
    }
}

export class PiDocumentTypeService<in out ClientType extends ODataHttpClient> extends EntityTypeServiceV4<ClientType, PiDocumentType, EditablePiDocumentType, QPiDocumentType> {
    private _sapMessages?: CollectionServiceV4<ClientType, SapMessage, QSapMessage, EditableSapMessage>;
    private _piDocumentTypeQUnassign?: PiDocumentType_QUnassign;

    constructor(client: ClientType, basePath: string, name: string, options?: ODataServiceOptionsInternal) {
        super(client, basePath, name, qPiDocumentType, options);
    }

    public sapMessages(): CollectionServiceV4<ClientType, SapMessage, QSapMessage, EditableSapMessage> {
        if(!this._sapMessages) {
          const { client, path, options } = this.__base;
          this._sapMessages = new CollectionServiceV4(client, path, "SAP__Messages", qSapMessage, options)
        }

        return this._sapMessages
    }

    public async unassign(requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<void>>> {
        if(!this._piDocumentTypeQUnassign) {
          this._piDocumentTypeQUnassign = new PiDocumentType_QUnassign()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._piDocumentTypeQUnassign.buildUrl());
        return client.post(url, {}, requestConfig, getDefaultHeaders());
        
    }
}

export class PiDocumentTypeCollectionService<in out ClientType extends ODataHttpClient> extends EntitySetServiceV4<ClientType, PiDocumentType, EditablePiDocumentType, QPiDocumentType, PiDocumentTypeId> {
    private _piDocumentTypeQStartCounting?: PiDocumentType_QStartCounting;
    private _piDocumentTypeQSaveCounting?: PiDocumentType_QSaveCounting;

    constructor(client: ClientType, basePath: string, name: string, options?: ODataServiceOptionsInternal) {
        super(client, basePath, name, qPiDocumentType, new QPiDocumentTypeId(name), options);
    }

    public async startCounting(params: PiDocumentType_StartCountingParams, requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<ZewvaUiPiCount>>> {
        if(!this._piDocumentTypeQStartCounting) {
          this._piDocumentTypeQStartCounting = new PiDocumentType_QStartCounting()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._piDocumentTypeQStartCounting.buildUrl());
        const response = await  client.post(url, this._piDocumentTypeQStartCounting.convertUserParams(params), requestConfig, getDefaultHeaders());
        return this._piDocumentTypeQStartCounting.convertResponse(response);
    }

    public async saveCounting(params: PiDocumentType_SaveCountingParams, requestConfig?: ODataHttpClientConfig<ClientType>): Promise<HttpResponseModel<ODataModelResponseV4<ZewvaUiPiSaveResult>>> {
        if(!this._piDocumentTypeQSaveCounting) {
          this._piDocumentTypeQSaveCounting = new PiDocumentType_QSaveCounting()
        }

        const { addFullPath, client, getDefaultHeaders, isUrlNotEncoded } = this.__base;
        const url = addFullPath(this._piDocumentTypeQSaveCounting.buildUrl());
        const response = await  client.post(url, this._piDocumentTypeQSaveCounting.convertUserParams(params), requestConfig, getDefaultHeaders());
        return this._piDocumentTypeQSaveCounting.convertResponse(response);
    }
}

export class SapMessageService<in out ClientType extends ODataHttpClient> extends EntityTypeServiceV4<ClientType, SapMessage, EditableSapMessage, QSapMessage> {
    private _additionalTargets?: CollectionServiceV4<ClientType, StringCollection, QStringCollection>;

    constructor(client: ClientType, basePath: string, name: string, options?: ODataServiceOptionsInternal) {
        super(client, basePath, name, qSapMessage, options);
    }

    public additionalTargets() {
        if(!this._additionalTargets) {
          const { client, path, options } = this.__base;
          this._additionalTargets = new CollectionServiceV4(client, path, "additionalTargets", new QStringCollection(), options)
        }

        return this._additionalTargets
    }
}
