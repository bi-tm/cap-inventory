// @ts-nocheck
import { QStringPath, QueryObject, QId, QStringParam, QFunction, OperationReturnType, ReturnTypes, QComplexParam } from "@odata2ts/odata-query-objects";
import type { UserParamTypeId, UserParamType_RsrcLogoffParams, UserParamType_RsrcLogonParams } from "./ComSapGatewaySrvdA2xZewUiUserParamV4V0001Model";

export class QUserParamType extends QueryObject {
    public readonly username = new QStringPath(this.withPrefix("Username"));
    public readonly warehouse = new QStringPath(this.withPrefix("Warehouse"));
    public readonly plant = new QStringPath(this.withPrefix("Plant"));
    public readonly rsrc = new QStringPath(this.withPrefix("Rsrc"));
}

export const qUserParamType = new QUserParamType();

export class QUserParamTypeId extends QId<UserParamTypeId> {
    private readonly params = [new QStringParam("Username", "username")];

    getParams() {
        return this.params
    }
}

export class UserParamType_QRsrcLogoff extends QFunction<UserParamType_RsrcLogoffParams> {
    private readonly params = [new QStringParam("Warehouse", "warehouse"),new QStringParam("Rsrc", "rsrc")];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_user_param_v4.v0001.RsrcLogoff", new OperationReturnType(ReturnTypes.COMPLEX, new QComplexParam("NONE", new QZewvcUiRsrc)))
    }

    getParams() {
        return this.params
    }
}

export class UserParamType_QGetUserParam extends QFunction {
    private readonly params: [] = [];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_user_param_v4.v0001.GetUserParam", new OperationReturnType(ReturnTypes.COMPLEX, new QComplexParam("NONE", new QZewvcUiUserParam)))
    }

    getParams() {
        return this.params
    }

    buildUrl(notEncoded = false) {
        return super.buildUrl(undefined, notEncoded)
    }
}

export class UserParamType_QRsrcLogon extends QFunction<UserParamType_RsrcLogonParams> {
    private readonly params = [new QStringParam("Warehouse", "warehouse"),new QStringParam("Rsrc", "rsrc")];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_user_param_v4.v0001.RsrcLogon", new OperationReturnType(ReturnTypes.COMPLEX, new QComplexParam("NONE", new QZewvcUiRsrc)))
    }

    getParams() {
        return this.params
    }
}

export class QZewvcUiUserParam extends QueryObject {
    public readonly plant = new QStringPath(this.withPrefix("Plant"));
    public readonly rsrc = new QStringPath(this.withPrefix("Rsrc"));
    public readonly username = new QStringPath(this.withPrefix("Username"));
    public readonly warehouse = new QStringPath(this.withPrefix("Warehouse"));
}

export const qZewvcUiUserParam = new QZewvcUiUserParam();

export class QZewvcUiRsrc extends QueryObject {
    public readonly queue = new QStringPath(this.withPrefix("Queue"));
    public readonly rsrc = new QStringPath(this.withPrefix("Rsrc"));
    public readonly rsrcGroup = new QStringPath(this.withPrefix("RsrcGroup"));
    public readonly rsrcType = new QStringPath(this.withPrefix("RsrcType"));
    public readonly username = new QStringPath(this.withPrefix("Username"));
    public readonly warehouse = new QStringPath(this.withPrefix("Warehouse"));
}

export const qZewvcUiRsrc = new QZewvcUiRsrc();
