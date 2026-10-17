/* checksum : 61333581dbe6bc343ac99e0bfda41aae */
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
service api_whse_physstockprod {
  @cds.external: true
  type D_WhseRelPMtlReqStkRefSrlNrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseScrapStkSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseConsumeStkSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseChgStkTypeSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseChgProdOrBatSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseChgStkOwAnUsgSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseChgDsplPtySrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

  @cds.external: true
  type D_WhseChgSlOrOrPrjSrlNmbrP {
    @Common.Label: 'Serial Number'
    EWMSerialNumber : String(30) not null;
  };

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
  @Common.Label                                                    : 'Warehouse Physical Stock by Product'
  @Common.Messages                                                 : SAP__Messages
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.FilterRestrictions.NonFilterableProperties         : ['EWMPhysStkMigrtnStsCode']
  @Capabilities.SortRestrictions.NonSortableProperties             : ['EWMPhysStkMigrtnStsCode']
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Capabilities.UpdateRestrictions.Updatable                       : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_SerialNumber']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  entity WarehousePhysicalStockProducts {
        @Core.Computed                    : true
        @Common.Label                     : 'Parent'
        @Common.Heading                   : 'Parent GUID'
        @Common.QuickInfo                 : 'Parent GUID'
    key ParentHandlingUnitUUID         : UUID not null;

        @Core.Computed                    : true
        @Common.Label                     : 'GUID Stock'
        @Common.QuickInfo                 : 'GUID Stock Item'
    key StockItemUUID                  : UUID not null;

        @Common.SAPObjectNodeTypeReference: 'Warehouse'
        @Common.IsUpperCase               : true
        @Common.Label                     : 'Warehouse Number'
        @Common.Heading                   : 'WhN'
        @Common.QuickInfo                 : 'Warehouse Number/Warehouse Complex'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
        EWMWarehouse                   : String(4) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Product'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
        Product                        : String(18) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Stock Type'
        @Common.Heading                   : 'ST'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_CAT'
        EWMStockType                   : String(2) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Stock Owner'
        EWMStockOwner                  : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Disposal Party'
        @Common.Heading                   : 'Disposal'
        @Common.QuickInfo                 : 'Party Entitled to Dispose'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ENTITLED'
        EntitledToDisposeParty         : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Usage'
        @Common.Heading                   : 'Use'
        @Common.QuickInfo                 : 'Stock Usage'
        EWMStockUsage                  : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Batch'
        @Common.QuickInfo                 : 'Batch Number'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=CHARG_D'
        Batch                          : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Special Reference Stock Type'
        StockDocumentCategory          : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Stock Reference Document'
        @Common.QuickInfo                 : 'Stock Reference Document of a Sales Order or Project Stock'
        StockDocumentNumber            : String(35) not null;

        @Common.Label                     : 'Stock Reference Doc.'
        @Common.Heading                   : 'Stock Reference Document'
        @Common.QuickInfo                 : 'Reference Document for Special Reference Stock'
        ExternalStockDocumentNumber    : String(35) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Sales Order Item'
        @Common.Heading                   : 'SlsOrd.Itm'
        @Common.QuickInfo                 : 'Sales Order Item for Sales Order Stock'
        StockItemNumber                : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Reference Document Category'
        EWMStockReferenceDocCategory   : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Reference Document'
        EWMStockReferenceDocument      : String(35) not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Reference Document Item'
        EWMStockReferenceDocumentItem  : String(10) not null;

        @Common.Label                     : 'Stock ID'
        @Common.QuickInfo                 : 'Identification Number of Stock'
        StockIdentificationNumber      : String(20) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Quality Inspection Type'
        WhseQualityInspectionType      : String(1) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Quality Inspection'
        @Common.Heading                   : 'Quality Insp'
        @Common.QuickInfo                 : 'Inspection Lot or Inspection Document Number'
        QualityInspectionDocument      : String(35) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Highest-Level Handling Unit'
        EWMHghstLvlHandlingUnitNumber  : String(20) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Handling Unit'
        HandlingUnitNumber             : String(20) not null;

        @Common.Label                     : 'Storage Bin'
        @Common.Heading                   : 'Stor. Bin'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_LGPLA'
        EWMStorageBin                  : String(18) not null;

        @Measures.Unit                    : EWMStockQtyBaseUnitSAPCode
        @Measures.UNECEUnit               : EWMStockQtyBaseUnitISOCode
        @Common.Label                     : 'Quantity in Base Unit'
        @Common.QuickInfo                 : 'Quantity in Base Unit of Measure'
        EWMStockQuantityInBaseUnit     : Decimal(31, 14) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Base Unit of Measure'
        @Common.Heading                   : 'BUn'
        EWMStockQuantityBaseUnit       : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'ISO Code'
        @Common.Heading                   : 'ISO'
        @Common.QuickInfo                 : 'ISO Code for Unit of Measurement'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
        EWMStockQtyBaseUnitISOCode     : String(3) not null;

        @Common.Label                     : 'Internal SAP Code'
        @Common.QuickInfo                 : 'Unit of Measurement, Internal SAP Code (No Conversion)'
        EWMStockQtyBaseUnitSAPCode     : String(3) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Alternative Unit of Measure'
        EWMStockQuantityAltvUnit       : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'ISO Code'
        @Common.Heading                   : 'ISO'
        @Common.QuickInfo                 : 'ISO Code for Unit of Measurement'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
        EWMStockQtyAltvUnitISOCode     : String(3) not null;

        @Common.Label                     : 'Internal SAP Code'
        @Common.QuickInfo                 : 'Unit of Measurement, Internal SAP Code (No Conversion)'
        EWMStockQtyAltvUnitSAPCode     : String(3) not null;

        @Measures.Unit                    : EWMLoadgOrNetWgtUntSAPCode
        @Measures.UNECEUnit               : EWMLoadgOrNetWgtUntISOCode
        @Common.Label                     : 'Loading Weight'
        @Common.QuickInfo                 : 'Loading or Net Weight'
        EWMLoadingOrNetWeight          : Decimal(15, 3) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Weight Unit'
        @Common.Heading                   : 'Un'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WGT_UOM'
        EWMLoadingOrNetWeightUnit      : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'ISO Code'
        @Common.Heading                   : 'ISO'
        @Common.QuickInfo                 : 'ISO Code for Unit of Measurement'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
        EWMLoadgOrNetWgtUntISOCode     : String(3) not null;

        @Common.Label                     : 'Internal SAP Code'
        @Common.QuickInfo                 : 'Unit of Measurement, Internal SAP Code (No Conversion)'
        EWMLoadgOrNetWgtUntSAPCode     : String(3) not null;

        @Measures.Unit                    : EWMLoadgOrNetVolUntSAPCode
        @Measures.UNECEUnit               : EWMLoadgOrNetVolUntISOCode
        @Common.Label                     : 'Loading Volume'
        @Common.QuickInfo                 : 'Loading or Net Volume'
        EWMLoadingOrNetVolume          : Decimal(15, 3) not null;

        @Common.IsUnit                    : true
        @Common.Label                     : 'Volume Unit'
        @Common.Heading                   : 'VUn'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_VOL_UOM'
        EWMLoadingOrNetVolumeUnit      : String(3) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'ISO Code'
        @Common.Heading                   : 'ISO'
        @Common.QuickInfo                 : 'ISO Code for Unit of Measurement'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
        EWMLoadgOrNetVolUntISOCode     : String(3) not null;

        @Common.Label                     : 'Internal SAP Code'
        @Common.QuickInfo                 : 'Unit of Measurement, Internal SAP Code (No Conversion)'
        EWMLoadgOrNetVolUntSAPCode     : String(3) not null;

        @Common.Label                     : 'Capacity Consumption'
        @Common.Heading                   : 'Capacity Consumpt.'
        EWMStorageBinCapConsumptionVal : Decimal(15, 3) not null;

        @odata.Precision                  : 0
        @odata.Type                       : 'Edm.DateTimeOffset'
        @Common.Label                     : 'Goods Receipt Date'
        @Common.Heading                   : 'GR Date'
        EWMGoodsReceiptDateTime        : DateTime;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Time Zone'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=TZNZONE'
        WarehouseTimeZone              : String(6) not null;

        @Common.Label                     : 'Expiration Date'
        @Common.Heading                   : 'Expiration'
        @Common.QuickInfo                 : 'Shelf Life Expiration Date'
        ShelfLifeExpirationDate        : Date;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Country/Region of Origin'
        CountryOfOrigin                : String(3) not null;

        @Common.Label      : 'Batch in Restricted Use'
        EWMBatchIsInRestrictedUseStock : Boolean not null;

        @Common.IsDigitSequence           : true
        @Common.Label                     : 'Partial Inspection Lot'
        InspectionPartialLot           : String(6) not null;

        @Common.Label                     : 'Stock Is Blocked by PI'
        @Common.QuickInfo                 : 'Stock Is Blocked by Physical Inventory'
        EWMStockIsBlockedForInventory  : Boolean not null;

        @Common.Label                     : 'Consolidation Group'
        @Common.Heading                   : 'CnsGrp'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_DSTGRP'
        EWMConsolidationGroup          : String(10) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Serial Number Requirement'
        SerialNumberRequiredLevel      : String(1) not null;

        @Common.Label      : 'Storage Bin Is Blocked for Putaway'
        EWMStorBinIsBlockedForPutaway  : Boolean not null;

        @Common.Label      : 'Storage Bin Is Blocked for Removal'
        EWMStorBinIsBlockedForRemoval  : Boolean not null;

        @Common.Label                     : 'Storage Bin Is Blocked by PI'
        @Common.QuickInfo                 : 'Storage Bin Is Blocked by Physical Inventory'
        EWMStorBinIsBlockedDueToPInv   : Boolean not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Storage Type'
        @Common.Heading                   : 'Ty.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGTYP'
        EWMStorageType                 : String(4) not null;

        @Common.IsUpperCase               : true
        @Common.Label                     : 'Storage Section'
        @Common.Heading                   : 'Sec.'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGBER'
        EWMStorageSection              : String(4) not null;

        @Core.Computed                    : true
        @Common.IsUpperCase               : true
        @Common.Label                     : 'migration status'
        @Common.QuickInfo                 : 'Status of a silent data migration'
        @Common.DocumentationRef          : 'urn:sap-com:documentation:key?=type=DE&id=SDM_MIGRATION_STATUS'
        EWMPhysStkMigrtnStsCode        : String(1) not null;
        SAP__Messages                  : many SAP__Message not null;

        @Common.Composition: true
        _SerialNumber                  : Composition of many WhsePhysStockProdSerialNumber
                                           on _SerialNumber._PhysStock = $self;
  } actions {
    action ConsumeStock(
                        @Common.IsUpperCase: true
                        @Common.Label: 'Movement Reason'
                        @Common.Heading: 'Reasn'
                        @Common.QuickInfo: 'Reason for Movements in the Warehouse'
                        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_REASON'
                        WarehouseMovementsReason: String(4) not null default null,
                        @Common.Label: 'Additional Text'
                        @Common.Heading: 'Add. Text'
                        WarehouseMovementsText: String(50) not null default null,
                        @Common.IsUpperCase: true
                        @Common.Label: 'Account Assignment Category'
                        EWMAccountAssignmentCategory: String(2) not null default null,
                        @Common.IsUpperCase: true
                        @Common.Label: 'Account Assignment Object'
                        EWMAccountAssignmentObject: String(35) not null default null,
                        @Common.IsUnit: true
                        @Common.Label: 'Unit Entered for Goods Movement'
                        EWMGoodsMovementEntryUnit: String(3) not null default null,
                        @Measures.Unit: EWMGoodsMovementEntryUnit
                        @Common.Label: 'Quantity Entered for Goods Movement'
                        EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                        _PhysStockProdSerialNumber: many D_WhseConsumeStkSrlNmbrP not null)                      returns WarehousePhysicalStockProducts not null;
    action ChangeSalesOrderOrProject(
                                     @Common.IsUpperCase: true
                                     @Common.Label: 'Type'
                                     @Common.Heading: 'Tpe'
                                     @Common.QuickInfo: 'Special Reference Stock Type'
                                     StockDocumentCategory: String(3) not null default null,
                                     @Common.Label: 'Stock Reference Doc.'
                                     @Common.Heading: 'Stock Reference Document'
                                     @Common.QuickInfo: 'Reference Document for Special Reference Stock'
                                     ExternalStockDocumentNumber: String(35) not null default null,
                                     @Common.Label: 'Sales Order Item'
                                     @Common.Heading: 'SlsOrd.Itm'
                                     @Common.QuickInfo: 'Sales Order Item for Sales Order Stock'
                                     StockItemNumber: String(10) not null default null,
                                     @Common.IsUnit: true
                                     @Common.Label: 'Unit Entered for Goods Movement'
                                     EWMGoodsMovementEntryUnit: String(3) not null default null,
                                     @Measures.Unit: EWMGoodsMovementEntryUnit
                                     @Common.Label: 'Quantity Entered for Goods Movement'
                                     EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                                     _PhysStockProdSerialNumber: many D_WhseChgSlOrOrPrjSrlNmbrP not null)       returns WarehousePhysicalStockProducts not null;
    action ScrapStock(
                      @Common.IsUpperCase: true
                      @Common.Label: 'Movement Reason'
                      @Common.Heading: 'Reasn'
                      @Common.QuickInfo: 'Reason for Movements in the Warehouse'
                      @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_REASON'
                      WarehouseMovementsReason: String(4) not null default null,
                      @Common.Label: 'Additional Text'
                      @Common.Heading: 'Add. Text'
                      WarehouseMovementsText: String(50) not null default null,
                      @Common.IsUpperCase: true
                      @Common.Label: 'Account Assignment Category'
                      EWMAccountAssignmentCategory: String(2) not null default null,
                      @Common.IsUpperCase: true
                      @Common.Label: 'Account Assignment Object'
                      EWMAccountAssignmentObject: String(35) not null default null,
                      @Common.IsUnit: true
                      @Common.Label: 'Unit Entered for Goods Movement'
                      EWMGoodsMovementEntryUnit: String(3) not null default null,
                      @Measures.Unit: EWMGoodsMovementEntryUnit
                      @Common.Label: 'Quantity Entered for Goods Movement'
                      EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                      _PhysStockProdSerialNumber: many D_WhseScrapStkSrlNmbrP not null)                          returns WarehousePhysicalStockProducts not null;
    action RelProdnMatlReqStockReference(
                                         @Common.IsUnit: true
                                         @Common.Label: 'Unit Entered for Goods Movement'
                                         EWMGoodsMovementEntryUnit: String(3) not null default null,
                                         @Measures.Unit: EWMGoodsMovementEntryUnit
                                         @Common.Label: 'Quantity Entered for Goods Movement'
                                         EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                                         _PhysStockProdSerialNumber: many D_WhseRelPMtlReqStkRefSrlNrP not null) returns WarehousePhysicalStockProducts not null;
    action ChangeDisposalParty(
                               @Common.IsUpperCase: true
                               @Common.Label: 'Disposal Party'
                               @Common.Heading: 'Disposal'
                               @Common.QuickInfo: 'Party Entitled to Dispose'
                               @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ENTITLED'
                               EntitledToDisposeParty: String(10) not null default null,
                               @Common.IsUpperCase: true
                               @Common.Label: 'Batch'
                               @Common.QuickInfo: 'Batch Number'
                               @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=CHARG_D'
                               Batch: String(10) not null default null,
                               @Common.IsUnit: true
                               @Common.Label: 'Unit Entered for Goods Movement'
                               EWMGoodsMovementEntryUnit: String(3) not null default null,
                               @Measures.Unit: EWMGoodsMovementEntryUnit
                               @Common.Label: 'Quantity Entered for Goods Movement'
                               EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                               _PhysStockProdSerialNumber: many D_WhseChgDsplPtySrlNmbrP not null)               returns WarehousePhysicalStockProducts not null;
    action ChangeProductOrBatch(
                                @Common.IsUpperCase: true
                                @Common.Label: 'Material'
                                @Common.QuickInfo: 'Material Number'
                                @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=MATNR'
                                Product: String(40) not null default null,
                                @Common.IsUpperCase: true
                                @Common.Label: 'Batch'
                                @Common.QuickInfo: 'Batch Number'
                                @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=CHARG_D'
                                Batch: String(10) not null default null,
                                @Common.IsUnit: true
                                @Common.Label: 'Unit Entered for Goods Movement'
                                EWMGoodsMovementEntryUnit: String(3) not null default null,
                                @Measures.Unit: EWMGoodsMovementEntryUnit
                                @Common.Label: 'Quantity Entered for Goods Movement'
                                EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                                _PhysStockProdSerialNumber: many D_WhseChgProdOrBatSrlNmbrP not null)            returns WarehousePhysicalStockProducts not null;
    action ChangeStockOwnerAndUsage(
                                    @Common.IsUpperCase: true
                                    @Common.Label: 'Owner'
                                    @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_OWNER'
                                    EWMStockOwner: String(10) not null default null,
                                    @Common.IsUpperCase: true
                                    @Common.Label: 'Stock Usage'
                                    EWMStockUsage: String(1) not null default null,
                                    @Common.IsUnit: true
                                    @Common.Label: 'Unit Entered for Goods Movement'
                                    EWMGoodsMovementEntryUnit: String(3) not null default null,
                                    @Measures.Unit: EWMGoodsMovementEntryUnit
                                    @Common.Label: 'Quantity Entered for Goods Movement'
                                    EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                                    _PhysStockProdSerialNumber: many D_WhseChgStkOwAnUsgSrlNmbrP not null)       returns WarehousePhysicalStockProducts not null;
    action ChangeStockType(
                           @Common.IsUpperCase: true
                           @Common.Label: 'Stock Type'
                           @Common.Heading: 'ST'
                           @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_CAT'
                           EWMStockType: String(2) not null default null,
                           @Common.IsUnit: true
                           @Common.Label: 'Unit Entered for Goods Movement'
                           EWMGoodsMovementEntryUnit: String(3) not null default null,
                           @Measures.Unit: EWMGoodsMovementEntryUnit
                           @Common.Label: 'Quantity Entered for Goods Movement'
                           EWMGoodsMovementEntryQuantity: Decimal(13, 3) not null default null,
                           _PhysStockProdSerialNumber: many D_WhseChgStkTypeSrlNmbrP not null)                   returns WarehousePhysicalStockProducts not null;
  };

  @cds.external                                                    : true
  @cds.persistence.skip                                            : true
  @Common.Label                                                    : 'Whse Phys Stock by Product Serial Nmbr'
  @Capabilities.SearchRestrictions.Searchable                      : false
  @Capabilities.InsertRestrictions.Insertable                      : false
  @Capabilities.DeleteRestrictions.Deletable                       : false
  @Capabilities.UpdateRestrictions.Updatable                       : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties: ['_PhysStock']
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported    : true
  entity WhsePhysStockProdSerialNumber {
        @Core.Computed          : true
        @Common.Label           : 'Parent'
        @Common.Heading         : 'Parent GUID'
        @Common.QuickInfo       : 'Parent GUID'
    key ParentHandlingUnitUUID : UUID not null;

        @Core.Computed          : true
        @Common.Label           : 'GUID Stock'
        @Common.QuickInfo       : 'GUID Stock Item'
    key StockItemUUID          : UUID not null;

        @Core.Computed          : true
        @Common.IsUpperCase     : true
        @Common.Label           : '30 Characters'
    key EWMSerialNumber        : String(30) not null;

        @Core.Computed          : true
        @Common.IsUpperCase     : true
        @Common.Label           : 'Warehouse Number'
        @Common.Heading         : 'WhN'
        @Common.QuickInfo       : 'Warehouse Number/Warehouse Complex'
        @Common.DocumentationRef: 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
        EWMWarehouse           : String(4) not null;
        _PhysStock             : Association to one WarehousePhysicalStockProducts
                                   on _PhysStock.StockItemUUID = StockItemUUID;
  };
};
