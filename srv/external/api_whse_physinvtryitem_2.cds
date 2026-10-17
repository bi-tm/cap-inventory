/* checksum : a88431a673709e16fcbc8e3428924746 */
@cds.external                                       : true
@CodeList.UnitsOfMeasure.Url                        : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.UnitsOfMeasure.CollectionPath             : 'UnitsOfMeasure'
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering: true
@Capabilities.FilterFunctions                       : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@SAP__support.TechnicalInfoLinks.Url                : '../../../../default/iwbep/common/0001/$metadata'
@SAP__support.TechnicalInfoLinks.FunctionImport     : 'GetTechnicalInfoLinks'
@Capabilities.SupportedFormats                      : [
  'application/json',
  'application/pdf'
]
@PDF.Features.DocumentDescriptionReference          : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection         : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat                         : true
@PDF.Features.Border                                : true
@PDF.Features.CoverPage                             : true
@PDF.Features.FitToPage                             : true
@PDF.Features.FontName                              : true
@PDF.Features.FontSize                              : true
@PDF.Features.HeaderFooter                          : true
@PDF.Features.IANATimezoneFormat                    : true
@PDF.Features.Margin                                : true
@PDF.Features.Padding                               : true
@PDF.Features.ResultSizeDefault                     : 20000
@PDF.Features.ResultSizeMaximum                     : 20000
@PDF.Features.Signature                             : true
@PDF.Features.TextDirectionLayout                   : true
@PDF.Features.Treeview                              : true
@PDF.Features.UploadToFileShare                     : true
@Capabilities.BatchSupport.SupportedFormats         : [
  'application/json',
  'multipart/mixed'
]
@Capabilities.KeyAsSegmentSupported                 : true
@Capabilities.AsynchronousRequestsSupported         : true
service api_whse_physinvtryitem_2 {
  @cds.external: true
  type SAP__Message {
    code              : String not null;
    message           : String not null;
    target            : String;
    additionalTargets : many String not null;
    transition        : Boolean not null;

    @odata.Type: 'Edm.Byte'
    numericSeverity   : Integer not null;
    longtextUrl       : String;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Warehouse Physical Inventory Count Item'
  @Common.SAPObjectNodeType.Name                                   : 'WhsePhysicalInventoryCountItem'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _WhsePhysicalInventoryItem,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _WhsePhysicalInventorySrlNmbr,
      InsertRestrictions: {Insertable: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_WhsePhysicalInventoryItem',
    '_WhsePhysicalInventorySrlNmbr'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['PInvItemChgUTCDateTime']
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions    : [{
    Property          : RequestedQuantity,
    AllowedExpressions: 'MultiValue'
  }]
  entity WhsePhysicalInventoryCountItem {
        @Common.SAPObjectNodeTypeReference: 'Warehouse'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Warehouse Number'
        @Common.Heading                   : 'WhN'
        @Common.QuickInfo                 : 'Warehouse Number/Warehouse Complex'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse                   : String(4) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'PI Document Number'
        @Common.QuickInfo                 : 'Physical Inventory Document Number'
    key PhysicalInventoryDocNumber     : String(20) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Document Year'
        @Common.QuickInfo                 : 'Document Year of Physical Inventory Document'
    key PhysicalInventoryDocYear       : String(4) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Item'
    key PhysicalInventoryItemNumber    : String(6) not null;

        @Core.Computed                    : true
        @Common.Label                     : 'Table Row'
        @Common.Heading                   : 'Row'
        @Common.QuickInfo                 : 'Row Index of Internal Tables'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SYTABIX'
    key LineIndexOfPInvItem            : Integer not null;

        @Core.Computed                    : true
        @Common.Label                     : 'Table Row'
        @Common.Heading                   : 'Row'
        @Common.QuickInfo                 : 'Row Index of Internal Tables'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SYTABIX'
    key PInvQuantitySequence           : Integer not null;

        @Common.Label                     : 'Level in Tree'
        @Common.QuickInfo                 : 'Level in Tree Hierarchy Observed from Leaf'
        PhysicalInventoryItemLevel     : Integer not null;

        @Common.Label                     : 'Parent Item Type'
        @Common.QuickInfo                 : 'Parent Item Type'
        @Common.IsUpperCase               : true
        @Common.Heading                   : 'Par. Obj.'
        PInvItemParentType             : String(1) not null;

        @Common.Label                     : 'Storage Bin'
        @Common.QuickInfo                 : 'Storage Bin'
        @Common.IsUpperCase               : true
        @Common.Heading                   : 'Bin'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGPLA'
        EWMStorageBin                  : String(18) not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStorageType'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Storage Type'
        @Common.Heading                   : 'Ty.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGTYP'
        EWMStorageType                 : String(4) not null;

        @Common.Label                     : 'Parent Handling Unit'
        @Common.QuickInfo                 : 'Parent Handling Unit'
        @Common.IsUpperCase               : true
        @Common.Heading                   : 'Source Handling Unit'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLENR_NOCONV'
        ParentHandlingUnitNumber       : String(20) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Cat. of Item Object'
        @Common.Heading                   : 'Cat.Item'
        @Common.QuickInfo                 : 'Object Category of Physical Inventory (Item Object)'
        PhysicalInventoryItemType      : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Source Handling Unit'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLENR_NOCONV'
        HandlingUnitNumber             : String(20) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
        Product                        : String(18) not null;

        @Common.Label                     : 'Product'
        @Common.QuickInfo                 : 'Product UUID'
        ProductUUID                    : UUID;

        @Common.Label      : 'Batch'
        BatchUUID                      : UUID;

        @Common.Label                     : 'Batch Number'
        @Common.QuickInfo                 : 'Batch Number'
        Batch                          : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Serial No. Requiremt'
        @Common.QuickInfo                 : 'Serial Number Requirement'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_SER_STOCK'
        SerialNumberRequiredLevel      : String(1) not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStockType'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Stock Type'
        @Common.Heading                   : 'Typ'
        EWMStockType                   : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Owner'
        EWMStockOwner                  : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Partner Role'
        @Common.Heading                   : 'Role'
        @Common.QuickInfo                 : 'Partner Role of Owner'
        StockOwnerPartnerRole          : String(2) not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStockUsage'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Usage'
        @Common.Heading                   : 'Use'
        @Common.QuickInfo                 : 'Stock Usage'
        EWMStockUsage                  : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Disposal Party'
        @Common.Heading                   : 'Disposal'
        @Common.QuickInfo                 : 'Party Entitled to Dispose'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ENTITLED'
        EntitledToDisposeParty         : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Partner Role'
        @Common.Heading                   : 'Role'
        @Common.QuickInfo                 : 'Partner Role of Party Entitled to Dispose'
        EntitledToDisposePartnerRole   : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Type'
        @Common.Heading                   : 'Tpe'
        @Common.QuickInfo                 : 'Special Reference Stock Type'
        StockDocumentCategory          : String(3) not null;

        @Common.Label                     : 'Stock Reference Doc.'
        @Common.Heading                   : 'Stock Reference Document'
        @Common.QuickInfo                 : 'Reference Document for Special Reference Stock'
        StockDocumentNumber            : String(35) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Sales Order Item'
        @Common.Heading                   : 'SlsOrd.Itm'
        @Common.QuickInfo                 : 'Sales Order Item for Sales Order Stock'
        StockItemNumber                : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'WBS Element'
        @Common.QuickInfo                 : 'Work Breakdown Structure Element (WBS Element) Edited'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
        WBSElementExternalID           : String(24) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'WBS Internal ID'
        @Common.Heading                   : 'WBS Elem'
        @Common.QuickInfo                 : 'WBS Element'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PS_S4_PSPNR'
        WBSElementInternalID           : String(8) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'SD Document'
        @Common.Heading                   : 'Document'
        @Common.QuickInfo                 : 'Sales and Distribution Document Number'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VBELN'
        SpecialStockIdfgSalesOrder     : String(10) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'NUMC06'
        @Common.QuickInfo                 : 'numc06'
        SpecialStockIdfgSalesOrderItem : String(6) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Document Category'
        @Common.Heading                   : 'Cat'
        @Common.QuickInfo                 : 'Doc. Category for Doc. Reference and Doc.-Related Stock'
        DocumentReltdStockDocCat       : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Inspection ID Type'
        @Common.Heading                   : 'In.ID Ty.'
        WhseQualityInspectionType      : String(1) not null;

        @Common.Label                     : 'Inspection Object'
        @Common.QuickInfo                 : 'Identification of a Quality Object'
        QualityInspectionDocUUID       : UUID;

        @Common.Label                     : 'Stock ID'
        @Common.QuickInfo                 : 'Identification Number of Stock'
        StockIdentificationNumber      : String(20) not null;

        @Common.Label                     : 'Document ID'
        @Common.QuickInfo                 : 'Doc. Identification for Document-Related Stocks'
        DocumentReltdStockDocUUID      : UUID;

        @Common.Label                     : 'Document Item'
        @Common.QuickInfo                 : 'Document Item for Document-Related Stocks'
        DocumentReltdStockDocItemUUID  : UUID;

        @odata.Precision                  : 0
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'GR Date'
        @Common.QuickInfo                 : 'Date and Time of Goods Receipt'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLVS_WDATU_NOCONV'
        WhseTaskGoodsReceiptDateTime   : DateTime;

        @Common.Label                     : 'Expiration Date'
        @Common.Heading                   : 'Expiration'
        @Common.QuickInfo                 : 'Shelf Life Expiration Date'
        ShelfLifeExpirationDate        : Date;

        @Common.Label                     : 'Country or Region of Origin'
        @Common.QuickInfo                 : 'Country or Region of Origin'
        @Common.IsUpperCase               : true
        @Common.Heading                   : 'Origin'
        CountryOfOrigin                : String(3) not null;

        @Common.Label                     : 'Batch in restr.-use'
        @Common.Heading                   : 'RU'
        @Common.QuickInfo                 : 'Batch in Restricted-Use Stock'
        MatlBatchIsInRstrcdUseStock    : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        HndlgUnitItemCountedIsComplete : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        HndlgUnitItemCountedIsEmpty    : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        HndlgUnitItemCountedIsNotExist : Boolean not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Packaging Material'
        @Common.Heading                   : 'Pack.Mat.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_PMAT'
        PackagingMaterial              : String(18) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Handling Unit Type'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_HUTYP'
        HandlingUnitType               : String(4) not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        EWMStorageBinIsEmpty           : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        PInvIsZeroCount                : Boolean not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Inv.-Managed UoM'
        @Common.Heading                   : 'UoM'
        @Common.QuickInfo                 : 'Inventory-Managed Unit of Measure'
        RequestedQuantityUnit          : String(3) not null;

        @Measures.Unit                    : RequestedQuantityUnit
        @Common.Label                     : 'Quantity Entered'
        @Common.QuickInfo                 : 'Quantity Entered in Physical Inventory'
        RequestedQuantity              : Decimal(31, 14) not null;

        @odata.Precision                  : 7
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'End Time Stamp'
        @Common.QuickInfo                 : 'LIME Internal Time Stamp (YYYYMMDDhhmmss,mmmuuun)'
        PInvItemChgUTCDateTime         : Timestamp;
        SAP__Messages                  : many SAP__Message not null;
        _WhsePhysicalInventoryItem     : Association to one WhsePhysicalInventoryItem
                                           on _WhsePhysicalInventoryItem.PhysicalInventoryItemNumber = PhysicalInventoryItemNumber;

        @Common.Composition: true
        _WhsePhysicalInventorySrlNmbr  : Composition of many WhsePhysicalInventorySrlNmbr
                                           on _WhsePhysicalInventorySrlNmbr._WhsePhysicalInventoryCntItem = $self;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Warehouse Physical Inventory Item'
  @Common.SAPObjectNodeType.Name                                   : 'WarehousePhysicalInventoryDoc'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [{
    NavigationProperty: _WhsePhysicalInventoryCntItem,
    InsertRestrictions: {Insertable: false}
  }]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.RequiredProperties              : [
    'EWMWarehouse',
    'PhysicalInventoryDocumentType',
    'EWMStorageBin'
  ]
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported            : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_WhsePhysicalInventoryCntItem']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported               : true
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Core.OptimisticConcurrency                                      : ['PInvItemChgUTCDateTime']
  entity WhsePhysicalInventoryItem {
        @Common.SAPObjectNodeTypeReference: 'Warehouse'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Warehouse Number'
        @Common.Heading                   : 'WhN'
        @Common.QuickInfo                 : 'Warehouse Number/Warehouse Complex'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse                   : String(4) not null;

        @Core.ComputedDefaultValue        : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'PI Document Number'
        @Common.QuickInfo                 : 'Physical Inventory Document Number'
    key PhysicalInventoryDocNumber     : String(20) not null;

        @Core.ComputedDefaultValue        : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Document Year'
        @Common.QuickInfo                 : 'Document Year of Physical Inventory Document'
    key PhysicalInventoryDocYear       : String(4) not null;

        @Core.ComputedDefaultValue        : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Item'
    key PhysicalInventoryItemNumber    : String(6) not null;

        @Common.Label                     : 'GUID'
        @Common.QuickInfo                 : 'GUID for Physical Inventory Document'
        PhysicalInventoryDocumentUUID  : UUID;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Phys. Inv. Procedure'
        @Common.Heading                   : 'Physical Inventory Procedure'
        @Common.QuickInfo                 : 'Physical Inventory Procedure (Document Type of Phys. Inv.)'
        PhysicalInventoryDocumentType  : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Reason f. Phys. Inv.'
        @Common.Heading                   : 'Reason for Physical Inventory'
        @Common.QuickInfo                 : 'Reason for Physical Inventory/Inventory Difference'
        EWMPhysInvtryDifferenceReason  : String(4) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Reason f. Phys. Inv.'
        @Common.Heading                   : 'Reason for Physical Inventory'
        @Common.QuickInfo                 : 'Reason for Physical Inventory/Inventory Difference'
        EWMPhysInvtryReason            : String(4) not null;

        @Common.SAPObjectNodeTypeReference: 'WhsePhysicalInventoryPriority'
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Phys. Inv. Prior.'
        @Common.Heading                   : 'Phys. Inv. Priority'
        @Common.QuickInfo                 : 'Priority of Physical Inventory'
        EWMPhysicalInventoryPriority   : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'PI Status'
        @Common.Heading                   : 'Physical Inventory Status'
        @Common.QuickInfo                 : 'Physical Inventory Status'
        PhysicalInventoryStatusText    : String(4) not null;

        @odata.Precision                  : 7
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'Creation Date'
        @Common.QuickInfo                 : 'Creation Date of Physical Inventory Doc. Item (Time Stamp)'
        PhysInventoryCrtnUTCDateTime   : Timestamp;

        @odata.Precision                  : 7
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'Count Date PhysInv'
        @Common.Heading                   : 'Date of Last Phys. Inv. Count'
        @Common.QuickInfo                 : 'Entered Date of Physical Inventory Count (Time Stamp)'
        PInvCountedUTCDateTime         : Timestamp;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'User Name'
        PhysicalInventoryCountUserName : String(12) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Warehouse Order'
        @Common.Heading                   : 'Whse Order'
        @Common.QuickInfo                 : 'Warehouse Order Number'
        WarehouseOrder                 : String(10) not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        PInvDocumentItemIsPrinted      : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        PhysicalInventoryIsBlock       : Boolean not null;

        @Common.Label                     : 'TRUE'
        @Common.QuickInfo                 : 'Data element for domain BOOLE: TRUE (=''X'') and FALSE (='' '')'
        PInvBookQuantityIsFreeze       : Boolean not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStorageType'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Storage Type'
        @Common.Heading                   : 'Ty.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGTYP'
        EWMStorageType                 : String(4) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Storage Bin'
        @Common.Heading                   : 'Bin'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGPLA'
        EWMStorageBin                  : String(18) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Phys. Inv. Area'
        @Common.QuickInfo                 : 'Physical Inventory Area'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FLIME%2FPI_DE_PI_AREAD'
        PhysicalInventoryArea          : String(20) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Activity Area'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_AAREA'
        ActivityArea                   : String(4) not null;

        @Common.Label                     : 'Product'
        @Common.QuickInfo                 : 'Product UUID'
        ProductUUID                    : UUID;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
        Product                        : String(18) not null;

        @Common.Label      : 'Batch'
        BatchUUID                      : UUID;
        Batch                          : String(10) not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStockType'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Stock Type'
        @Common.Heading                   : 'Typ'
        EWMStockType                   : String(2) not null;

        @Common.SAPObjectNodeTypeReference: 'WarehouseStockUsage'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Usage'
        @Common.Heading                   : 'Use'
        @Common.QuickInfo                 : 'Stock Usage'
        EWMStockUsage                  : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Owner'
        EWMStockOwner                  : String(10) not null;
        StockOwnerName                 : String(81) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Disposal Party'
        @Common.Heading                   : 'Disposal'
        @Common.QuickInfo                 : 'Party Entitled to Dispose'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ENTITLED'
        EntitledToDisposeParty         : String(10) not null;
        NameOfEntitledToDisposeParty   : String(81) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Type'
        @Common.Heading                   : 'Tpe'
        @Common.QuickInfo                 : 'Special Reference Stock Type'
        StockDocumentCategory          : String(3) not null;

        @Common.Label                     : 'Stock Reference Doc.'
        @Common.Heading                   : 'Stock Reference Document'
        @Common.QuickInfo                 : 'Reference Document for Special Reference Stock'
        StockDocumentNumber            : String(35) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Sales Order Item'
        @Common.Heading                   : 'SlsOrd.Itm'
        @Common.QuickInfo                 : 'Sales Order Item for Sales Order Stock'
        StockItemNumber                : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'WBS Element'
        @Common.QuickInfo                 : 'Work Breakdown Structure Element (WBS Element) Edited'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
        WBSElementExternalID           : String(24) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'WBS Internal ID'
        @Common.Heading                   : 'WBS Elem'
        @Common.QuickInfo                 : 'WBS Element'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PS_S4_PSPNR'
        WBSElementInternalID           : String(8) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'SD Document'
        @Common.Heading                   : 'Document'
        @Common.QuickInfo                 : 'Sales and Distribution Document Number'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=VBELN'
        SpecialStockIdfgSalesOrder     : String(10) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'NUMC06'
        @Common.QuickInfo                 : 'numc06'
        SpecialStockIdfgSalesOrderItem : String(6) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Document Year'
        @Common.QuickInfo                 : 'Document Year of Physical Inventory Document'
        PhysicalInventoryRefDocYear    : String(4) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'PI Document Number'
        @Common.QuickInfo                 : 'Physical Inventory Document Number'
        EWMRefPhysicalInventoryDoc     : String(20) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Item'
        PhysicalInventoryRefDocItem    : String(6) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Document ID'
        @Common.Heading                   : 'DocID'
        @Common.QuickInfo                 : 'Document ID of Reference Document'
        PInvFreeDefinedRefText         : String(70) not null;

        @odata.Precision                  : 7
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'End Time Stamp'
        @Common.QuickInfo                 : 'LIME Internal Time Stamp (YYYYMMDDhhmmss,mmmuuun)'
        PInvItemChgUTCDateTime         : Timestamp;
        SAP__Messages                  : many SAP__Message not null;

        @Common.Composition: true
        _WhsePhysicalInventoryCntItem  : Composition of many WhsePhysicalInventoryCountItem
                                           on _WhsePhysicalInventoryCntItem._WhsePhysicalInventoryItem = $self;
  } actions {
    action DeletePhysicalInventoryItem();
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Physical Inventory Serial Number'
  @Common.SAPObjectNodeType.Name                                   : 'WhsePhysInventorySerialNumber'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties        : [
    {
      NavigationProperty: _WhsePhysicalInventoryCntItem,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    },
    {
      NavigationProperty: _WhsePhysicalInventoryItem,
      InsertRestrictions: {Insertable: false},
      DeepUpdateSupport : {Supported: false}
    }
  ]
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Capabilities.UpdateRestrictions.Updatable                       : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: [
    '_WhsePhysicalInventoryCntItem',
    '_WhsePhysicalInventoryItem'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  entity WhsePhysicalInventorySrlNmbr {
        @Common.SAPObjectNodeTypeReference: 'Warehouse'
        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Warehouse Number'
        @Common.Heading                   : 'WhN'
        @Common.QuickInfo                 : 'Warehouse Number/Warehouse Complex'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse                  : String(4) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'PI Document Number'
        @Common.QuickInfo                 : 'Physical Inventory Document Number'
    key PhysicalInventoryDocNumber    : String(20) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Document Year'
        @Common.QuickInfo                 : 'Document Year of Physical Inventory Document'
    key PhysicalInventoryDocYear      : String(4) not null;

        @Core.Computed                    : true
        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Item'
    key PhysicalInventoryItemNumber   : String(6) not null;

        @Core.Computed                    : true
        @Common.Label                     : 'Table Row'
        @Common.Heading                   : 'Row'
        @Common.QuickInfo                 : 'Row Index of Internal Tables'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SYTABIX'
    key LineIndexOfPInvItem           : Integer not null;

        @Core.Computed                    : true
        @Common.Label                     : 'Table Row'
        @Common.Heading                   : 'Row'
        @Common.QuickInfo                 : 'Row Index of Internal Tables'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SYTABIX'
    key PInvQuantitySequence          : Integer not null;

        @Core.Computed                    : true
        @Common.Label                     : 'Table Row'
        @Common.Heading                   : 'Row'
        @Common.QuickInfo                 : 'Row Index of Internal Tables'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SYTABIX'
    key EWMPhysInvtrySrlNmbrSqnc      : Integer not null;

        @Common.Label                : 'Serial Number'
        EWMSerialNumber               : String(30) not null;
        SAP__Messages                 : many SAP__Message not null;
        _WhsePhysicalInventoryCntItem : Association to one WhsePhysicalInventoryCountItem
                                          on _WhsePhysicalInventoryCntItem.PInvQuantitySequence = PInvQuantitySequence;

        @Common.ReferentialConstraint: [
          {
            Property          : EWMWarehouse,
            ReferencedProperty: ![_WhsePhysicalInventoryItem/EWMWarehouse]
          },
          {
            Property          : PhysicalInventoryDocNumber,
            ReferencedProperty: ![_WhsePhysicalInventoryItem/PhysicalInventoryDocNumber]
          },
          {
            Property          : PhysicalInventoryDocYear,
            ReferencedProperty: ![_WhsePhysicalInventoryItem/PhysicalInventoryDocYear]
          },
          {
            Property          : PhysicalInventoryItemNumber,
            ReferencedProperty: ![_WhsePhysicalInventoryItem/PhysicalInventoryItemNumber]
          }
        ]
        _WhsePhysicalInventoryItem    : Association to one WhsePhysicalInventoryItem {};
  };
};
