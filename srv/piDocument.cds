namespace inventory1;

aspect DocKey {
    key doc_year   : String(4);
    key doc_number : String(20);
    key item_no    : String(4);
}

type DocStatus           : String(4) enum {
    posted = 'POST';
    deleted = 'DELE';
    recounted = 'RECO';
    active = 'ACTI';
    inactive = 'INAC'
}

type StotrageType        : String(4);
type StorageArea         : String(4);
type StorageBin          : String(18);
type ProductNo           : String(40);
type BatchNo             : String(10);
type StorageCategory     : String(2);

type StartCountingResult : DocKey {
    lgpla  : StorageBin;
    isBulk : Boolean;
// items =  QZewvaUiPiCountItm
}

type ZewvaUiPiCountItm   : DocKey {
    huident          : String;
    matnr            : String;
    charg            : String;
    huTop            : String;
    maktx            : String;
    cat              : String;
    catText          : String;
    stockQuantity    : Decimal;
    entered_quantity : Decimal;
    entered_unit     : String;

}

type ZewvaUiPiCount      : DocKey {
    lgpla  : String;
    isBulk : Boolean;
    items  : array of ZewvaUiPiCountItm;
}

@cds.persistence.skip
@readonly
entity PiDocument : DocKey {
    who         : String(4);
    doc_type    : String(2);
    doc_status  : DocStatus;
    reason      : String(4);
    reason_txt  : String(40);
    lgtyp       : StotrageType;
    lgber       : StorageArea;
    lgpla       : StorageBin;
    count_of_hu : Integer;
    assigned    : Boolean;
}
