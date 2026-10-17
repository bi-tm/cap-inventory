// @ts-nocheck
import { QStringPath, QNumberPath, QBooleanPath, QEntityCollectionPath, QueryObject, QId, QStringParam, QAction, OperationReturnType, ReturnTypes, QComplexParam, QCollectionPath, QStringCollection } from "@odata2ts/odata-query-objects";
import type { PiDocumentTypeId, PiDocumentType_StartCountingParams, PiDocumentType_SaveCountingParams } from "./ComSapGatewaySrvdA2xZewUiPiV0001Model";

export class QPiDocumentType extends QueryObject {
    public readonly docYear = new QStringPath(this.withPrefix("doc_year"));
    public readonly docNumber = new QStringPath(this.withPrefix("doc_number"));
    public readonly itemNo = new QStringPath(this.withPrefix("item_no"));
    public readonly who = new QStringPath(this.withPrefix("who"));
    public readonly docType = new QStringPath(this.withPrefix("doc_type"));
    public readonly docStatus = new QStringPath(this.withPrefix("doc_status"));
    public readonly reason = new QStringPath(this.withPrefix("reason"));
    public readonly reasonTxt = new QStringPath(this.withPrefix("reason_txt"));
    public readonly lgtyp = new QStringPath(this.withPrefix("lgtyp"));
    public readonly lgber = new QStringPath(this.withPrefix("lgber"));
    public readonly lgpla = new QStringPath(this.withPrefix("lgpla"));
    public readonly matnr = new QStringPath(this.withPrefix("matnr"));
    public readonly maktx = new QStringPath(this.withPrefix("maktx"));
    public readonly charg = new QStringPath(this.withPrefix("charg"));
    public readonly cat = new QStringPath(this.withPrefix("cat"));
    public readonly catText = new QStringPath(this.withPrefix("cat_text"));
    public readonly countOfHu = new QNumberPath(this.withPrefix("count_of_hu"));
    public readonly assigned = new QBooleanPath(this.withPrefix("assigned"));
    public readonly sapMessages = new QEntityCollectionPath(this.withPrefix("SAP__Messages"), () => QSapMessage);
}

export const qPiDocumentType = new QPiDocumentType();

export class QPiDocumentTypeId extends QId<PiDocumentTypeId> {
    private readonly params = [new QStringParam("doc_year", "docYear"),new QStringParam("doc_number", "docNumber"),new QStringParam("item_no", "itemNo")];

    getParams() {
        return this.params
    }
}

export class PiDocumentType_QUnassign extends QAction {
    private readonly params: [] = [];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_pi.v0001.Unassign")
    }

    getParams() {
        return this.params
    }
}

export class PiDocumentType_QStartCounting extends QAction<PiDocumentType_StartCountingParams> {
    private readonly params = [new QStringParam("Scan", "scan")];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_pi.v0001.StartCounting", new OperationReturnType(ReturnTypes.COMPLEX, new QComplexParam("NONE", new QZewvaUiPiCount)))
    }

    getParams() {
        return this.params
    }
}

export class PiDocumentType_QSaveCounting extends QAction<PiDocumentType_SaveCountingParams> {
    private readonly params = [new QStringParam("doc_year", "docYear"),new QStringParam("doc_number", "docNumber"),new QStringParam("item_no", "itemNo"),new QComplexParam("items", new QZewvaUiPiItmSave())];

    constructor() {
        super("com.sap.gateway.srvd_a2x.zew_ui_pi.v0001.SaveCounting", new OperationReturnType(ReturnTypes.COMPLEX, new QComplexParam("NONE", new QZewvaUiPiSaveResult)))
    }

    getParams() {
        return this.params
    }
}

export class QZewvaUiPiItmSave extends QueryObject {
    public readonly docYear = new QStringPath(this.withPrefix("doc_year"));
    public readonly docNumber = new QStringPath(this.withPrefix("doc_number"));
    public readonly itemNo = new QStringPath(this.withPrefix("item_no"));
    public readonly huident = new QStringPath(this.withPrefix("huident"));
    public readonly matnr = new QStringPath(this.withPrefix("matnr"));
    public readonly charg = new QStringPath(this.withPrefix("charg"));
    public readonly cat = new QStringPath(this.withPrefix("cat"));
    public readonly enteredQuantity = new QNumberPath(this.withPrefix("entered_quantity"));
    public readonly enteredUnit = new QStringPath(this.withPrefix("entered_unit"));
    public readonly huDeleted = new QBooleanPath(this.withPrefix("huDeleted"));
}

export const qZewvaUiPiItmSave = new QZewvaUiPiItmSave();

export class QZewvaUiPiCount extends QueryObject {
    public readonly docYear = new QStringPath(this.withPrefix("doc_year"));
    public readonly docNumber = new QStringPath(this.withPrefix("doc_number"));
    public readonly itemNo = new QStringPath(this.withPrefix("item_no"));
    public readonly lgpla = new QStringPath(this.withPrefix("lgpla"));
    public readonly isBulk = new QBooleanPath(this.withPrefix("is_bulk"));
    public readonly items = new QEntityCollectionPath(this.withPrefix("items"), () => QZewvaUiPiCountItm);
}

export const qZewvaUiPiCount = new QZewvaUiPiCount();

export class QZewvaUiPiSaveResult extends QueryObject {
    public readonly nextDocNumber = new QStringPath(this.withPrefix("next_doc_number"));
    public readonly nextDocYear = new QStringPath(this.withPrefix("next_doc_year"));
    public readonly nextItemNo = new QStringPath(this.withPrefix("next_item_no"));
}

export const qZewvaUiPiSaveResult = new QZewvaUiPiSaveResult();

export class QZewvaUiPiCountItm extends QueryObject {
    public readonly docYear = new QStringPath(this.withPrefix("doc_year"));
    public readonly docNumber = new QStringPath(this.withPrefix("doc_number"));
    public readonly itemNo = new QStringPath(this.withPrefix("item_no"));
    public readonly huident = new QStringPath(this.withPrefix("huident"));
    public readonly matnr = new QStringPath(this.withPrefix("matnr"));
    public readonly charg = new QStringPath(this.withPrefix("charg"));
    public readonly huTop = new QStringPath(this.withPrefix("hu_top"));
    public readonly maktx = new QStringPath(this.withPrefix("maktx"));
    public readonly cat = new QStringPath(this.withPrefix("cat"));
    public readonly catText = new QStringPath(this.withPrefix("cat_text"));
    public readonly stockQuantity = new QNumberPath(this.withPrefix("stock_quantity"));
    public readonly enteredQuantity = new QNumberPath(this.withPrefix("entered_quantity"));
    public readonly enteredUnit = new QStringPath(this.withPrefix("entered_unit"));
}

export const qZewvaUiPiCountItm = new QZewvaUiPiCountItm();

export class QSapMessage extends QueryObject {
    public readonly code = new QStringPath(this.withPrefix("code"));
    public readonly message = new QStringPath(this.withPrefix("message"));
    public readonly target = new QStringPath(this.withPrefix("target"));
    public readonly additionalTargets = new QCollectionPath(this.withPrefix("additionalTargets"), () => QStringCollection);
    public readonly transition = new QBooleanPath(this.withPrefix("transition"));
    public readonly numericSeverity = new QNumberPath(this.withPrefix("numericSeverity"));
    public readonly longtextUrl = new QStringPath(this.withPrefix("longtextUrl"));
}

export const qSapMessage = new QSapMessage();
