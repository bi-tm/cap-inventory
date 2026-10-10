//using {api_whse_physinvtryitem_2.WhsePhysicalInventoryItem as WhsePhysicalInventoryItem} from '../srv/external/api_whse_physinvtryitem_2';
using { DocKey, DocStatus, StotrageType, StorageArea, StorageBin, ProductNo, BatchNo, StorageCategory} from '../db/schema.cds';

service Inventory {
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
        matnr       : ProductNo;
        maktx       : String(40);
        charg       : BatchNo;
        cat         : StorageCategory;
        cat_text    : String(30);
        count_of_hu : Integer;
        assigned    : Boolean;
    }

}
