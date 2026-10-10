
aspect DocKey {
    key doc_year   : String(4);
    key doc_number : String(20);
    key item_no    : String(4);
}

type DocStatus       : String(4) enum {
    posted = 'POST';
    deleted = 'DELE';
    recounted = 'RECO';
    active = 'ACTI';
    inactive = 'INAC'
}

type StotrageType    : String(4);
type StorageArea     : String(4);
type StorageBin      : String(18);
type ProductNo       : String(40);
type BatchNo         : String(10);
type StorageCategory : String(2);

entity Settings {
    param : String;
    value : String;
}

