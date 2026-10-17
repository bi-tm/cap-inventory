// @ts-nocheck

export interface UserParamType {
    username: string;
    warehouse: string;
    plant: string;
    rsrc: string;
}

export type UserParamTypeId = string | {username: string};

export interface EditableUserParamType extends Pick<UserParamType, "warehouse" | "plant" | "rsrc"> {
}

export interface UserParamType_RsrcLogoffParams {
    warehouse: string;
    rsrc: string;
}

export interface UserParamType_RsrcLogonParams {
    warehouse: string;
    rsrc: string;
}

export interface ZewvcUiUserParam {
    plant: string;
    rsrc: string;
    username: string;
    warehouse: string;
}

export interface EditableZewvcUiUserParam extends Pick<ZewvcUiUserParam, "plant" | "rsrc" | "username" | "warehouse"> {
}

export interface ZewvcUiRsrc {
    queue: string;
    rsrc: string;
    rsrcGroup: string;
    rsrcType: string;
    username: string;
    warehouse: string;
}

export interface EditableZewvcUiRsrc extends Pick<ZewvcUiRsrc, "queue" | "rsrc" | "rsrcGroup" | "rsrcType" | "username" | "warehouse"> {
}
