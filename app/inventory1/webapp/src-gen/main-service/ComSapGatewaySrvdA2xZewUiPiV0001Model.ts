// @ts-nocheck

export interface PiDocumentType {
    docYear: string;
    docNumber: string;
    itemNo: string;
    who: string;
    docType: string;
    docStatus: string;
    reason: string;
    reasonTxt: string;
    lgtyp: string;
    lgber: string;
    lgpla: string;
    matnr: string;
    maktx: string;
    charg: string;
    cat: string;
    catText: string;
    countOfHu: number;
    assigned: boolean;
    sapMessages: Array<SapMessage>;
}

export type PiDocumentTypeId = {docYear: string,docNumber: string,itemNo: string};

export interface EditablePiDocumentType extends Pick<PiDocumentType, "docYear" | "docNumber" | "itemNo" | "who" | "docType" | "docStatus" | "reason" | "reasonTxt" | "lgtyp" | "lgber" | "lgpla" | "matnr" | "maktx" | "charg" | "cat" | "catText" | "countOfHu" | "assigned"> {
}

export interface PiDocumentType_StartCountingParams {
    scan: string;
}

export interface PiDocumentType_SaveCountingParams {
    docYear: string;
    docNumber: string;
    itemNo: string;
    items: Array<ZewvaUiPiItmSave>;
}

export interface ZewvaUiPiItmSave {
    docYear: string;
    docNumber: string;
    itemNo: string;
    huident: string;
    matnr: string;
    charg: string;
    cat: string;
    enteredQuantity: number;
    enteredUnit: string;
    huDeleted: boolean;
}

export interface EditableZewvaUiPiItmSave extends Pick<ZewvaUiPiItmSave, "docYear" | "docNumber" | "itemNo" | "huident" | "matnr" | "charg" | "cat" | "enteredQuantity" | "enteredUnit" | "huDeleted"> {
}

export interface ZewvaUiPiCount {
    docYear: string;
    docNumber: string;
    itemNo: string;
    lgpla: string;
    isBulk: boolean;
    items: Array<ZewvaUiPiCountItm>;
}

export interface EditableZewvaUiPiCount extends Pick<ZewvaUiPiCount, "docYear" | "docNumber" | "itemNo" | "lgpla" | "isBulk"> {
    items: Array<EditableZewvaUiPiCountItm>;
}

export interface ZewvaUiPiSaveResult {
    nextDocNumber: string;
    nextDocYear: string;
    nextItemNo: string;
}

export interface EditableZewvaUiPiSaveResult extends Pick<ZewvaUiPiSaveResult, "nextDocNumber" | "nextDocYear" | "nextItemNo"> {
}

export interface ZewvaUiPiCountItm {
    docYear: string;
    docNumber: string;
    itemNo: string;
    huident: string;
    matnr: string;
    charg: string;
    huTop: string;
    maktx: string;
    cat: string;
    catText: string;
    stockQuantity: number;
    enteredQuantity: number;
    enteredUnit: string;
}

export interface EditableZewvaUiPiCountItm extends Pick<ZewvaUiPiCountItm, "docYear" | "docNumber" | "itemNo" | "huident" | "matnr" | "charg" | "huTop" | "maktx" | "cat" | "catText" | "stockQuantity" | "enteredQuantity" | "enteredUnit"> {
}

export interface SapMessage {
    code: string;
    message: string;
    target: string | null;
    additionalTargets: Array<string>;
    transition: boolean;
    numericSeverity: number;
    longtextUrl: string | null;
}

export interface EditableSapMessage extends Pick<SapMessage, "code" | "message" | "additionalTargets" | "transition" | "numericSeverity">, Partial<Pick<SapMessage, "target" | "longtextUrl">> {
}
