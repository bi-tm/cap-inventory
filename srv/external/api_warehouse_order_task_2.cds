/* checksum : 2087b57c2c2955c65f6c50214e4c8ea2 */
@cds.external : true
@CodeList.UnitsOfMeasure.Url : '../../../../default/iwbep/common/0001/$metadata'
@CodeList.UnitsOfMeasure.CollectionPath : 'UnitsOfMeasure'
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
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
@SAP__support.TechnicalInfoLinks.Url : '../../../../default/iwbep/common/0001/$metadata'
@SAP__support.TechnicalInfoLinks.FunctionImport : 'GetTechnicalInfoLinks'
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features.DocumentDescriptionReference : '../../../../default/iwbep/common/0001/$metadata'
@PDF.Features.DocumentDescriptionCollection : 'MyDocumentDescriptions'
@PDF.Features.ArchiveFormat : true
@PDF.Features.Border : true
@PDF.Features.CoverPage : true
@PDF.Features.FitToPage : true
@PDF.Features.FontName : true
@PDF.Features.FontSize : true
@PDF.Features.HeaderFooter : true
@PDF.Features.IANATimezoneFormat : true
@PDF.Features.Margin : true
@PDF.Features.Padding : true
@PDF.Features.ResultSizeDefault : 20000
@PDF.Features.ResultSizeMaximum : 20000
@PDF.Features.Signature : true
@PDF.Features.TextDirectionLayout : true
@PDF.Features.Treeview : true
@PDF.Features.UploadToFileShare : true
@Capabilities.BatchSupport.SupportedFormats : [ 'application/json', 'multipart/mixed' ]
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service api_warehouse_order_task_2 {
  @cds.external : true
  type D_WhseOrderMergeChildP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Lagerauftrag'
    @Common.Heading : 'LagAuftrag'
    @Common.QuickInfo : 'Lagerauftragsnummer'
    WarehouseOrder : String(10) not null;
  };

  @cds.external : true
  type D_WhseOrderSplitChildP {
    @Common.IsDigitSequence : true
    @Common.Label : 'Lageraufgabe'
    @Common.Heading : 'LagAufgabe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTANUM_NOCONV'
    WarehouseTask : String(12) not null;
  };

  @cds.external : true
  type SAP__Message {
    code : String not null;
    message : String not null;
    target : String;
    additionalTargets : many String not null;
    transition : Boolean not null;
    @odata.Type : 'Edm.Byte'
    numericSeverity : Integer not null;
    longtextUrl : String;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Lagerauftrag'
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _WarehouseOrderPickHndlgUnit,
      InsertRestrictions: { Insertable: false }
    },
    {
      NavigationProperty: _WarehouseTask,
      InsertRestrictions: { Insertable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.DeltaUpdateSupported : true
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_WarehouseOrderPickHndlgUnit', '_WarehouseTask' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeepUpdateSupport.ContentIDSupported : true
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : [ 'WhseOrderLastChgUTCDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    {
      Property: WarehouseOrderPlannedDuration,
      AllowedExpressions: 'MultiValue'
    }
  ]
  entity WarehouseOrder {
    @Common.SAPObjectNodeTypeReference : 'Warehouse'
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagernummer'
    @Common.Heading : 'LNr'
    @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse : String(4) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lagerauftrag'
    @Common.Heading : 'LagAuftrag'
    @Common.QuickInfo : 'Lagerauftragsnummer'
    key WarehouseOrder : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagerauftragsstatus'
    @Common.QuickInfo : 'Status des Lagerauftrags'
    WarehouseOrderStatus : String(1) not null;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Erstellungsuhrzeit'
    WhseOrderCreationDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Startzeitpunkt'
    WarehouseOrderStartDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Quittierungszeitp.'
    @Common.QuickInfo : 'Quittierungsszeitpunkt'
    WhseOrderConfirmedDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Kurzform Zeitstempel'
    @Common.Heading : 'Kurzform des Zeitstempels'
    @Common.QuickInfo : 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TZNTSTMPS'
    WhseOrderLastChgUTCDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Core.Computed : true
    @Common.Label : 'Spät. Starttermin'
    @Common.Heading : 'SST'
    @Common.QuickInfo : 'Spätester Starttermin (SST)'
    WhseOrderLatestStartDateTime : DateTime;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'LA-Erstellungsregel'
    @Common.Heading : 'Lagerauftragserstellungsregel'
    @Common.QuickInfo : 'Lagerauftragserstellungsregel'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WCR'
    WarehouseOrderCreationRule : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Typ LA-ErstellRegel'
    @Common.QuickInfo : 'Typ einer Lagerauftragerstellungsregel'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WCRTYPE'
    WhseOrderCreationRuleCategory : String(1) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Aktivitätsbereich'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_AAREA'
    ActivityArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Queue'
    @Common.Heading : 'Q'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_QUEUE'
    Queue : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ausführender'
    Processor : String(12) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseResource'
    @Core.Computed : true
    @Common.Label : 'Ressource'
    @Common.QuickInfo : 'Ressource (Transportmittel oder Benutzer)'
    ExecutingResource : String(18) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Welle'
    EWMWave : String(10) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Kopf-LagProzArt'
    @Common.Heading : 'Kopf-LPA'
    @Common.QuickInfo : 'Belegkopf-Lagerprozessart'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_HEAD_PROCTY'
    WhseProcessTypeDocumentHdr : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Angelegt von'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_CREATOR'
    CreatedByUser : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Änderer'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EDITOR'
    LastChangedByUser : String(12) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Quittiert von'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_CONFIRMEDBY'
    ConfirmedByUser : String(12) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Splitt-LA'
    @Common.QuickInfo : 'Lagerauftragsnummer des LAs von dem gesplittet wurde'
    WhseOrderForSplitWhseOrder : String(10) not null;
    @Core.Computed : true
    @Common.Label : 'Gesplittet'
    @Common.QuickInfo : 'Lagerauftrag wurde gesplittet'
    WarehouseOrderIsSplit : Boolean not null;
    @Core.Computed : true
    @Measures.Unit : WhseOrderPlanDurationTimeUnit
    @Common.Label : 'Gepl Ausführungszeit'
    @Common.QuickInfo : 'Geplante Ausführungszeit des Lagerauftrags'
    WarehouseOrderPlannedDuration : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Core.Computed : true
    @Common.Label : 'Zeiteinheit'
    @Common.Heading : 'Zeit'
    @Common.QuickInfo : 'Lagerauftrag: Zeiteinheit'
    WhseOrderPlanDurationTimeUnit : String(3) not null;
    SAP__Messages : many SAP__Message not null;
    @Common.Composition : true
    _WarehouseOrderPickHndlgUnit : Composition of many WarehouseOrderPickHndlgUnit on _WarehouseOrderPickHndlgUnit._WarehouseOrder = $self;
    @Common.Composition : true
    _WarehouseTask : Composition of many WarehouseTask on _WarehouseTask._WarehouseOrder = $self;
  } actions {
    action AssignWarehouseOrder(
      @Common.IsUpperCase : true
      @Common.Label : 'Ressource'
      @Common.QuickInfo : 'Ressource (Transportmittel oder Benutzer)'
      EWMResource : String(18) not null
    );
    action MergeWarehouseOrder(
      @Common.IsUpperCase : true
      @Common.Label : 'Lagernummer'
      @Common.Heading : 'LNr'
      @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
      EWMWarehouse : String(4) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'LA-Erstellungsregel'
      @Common.Heading : 'Lagerauftragserstellungsregel'
      @Common.QuickInfo : 'Lagerauftragserstellungsregel'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WCR'
      WarehouseOrderCreationRule : String(4) not null,
      _WarehouseOrderMergeChild : many D_WhseOrderMergeChildP not null
    ) returns many WarehouseOrder not null;
    action SplitWarehouseOrder(
      @Common.IsUpperCase : true
      @Common.Label : 'LA-Erstellungsregel'
      @Common.Heading : 'Lagerauftragserstellungsregel'
      @Common.QuickInfo : 'Lagerauftragserstellungsregel'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WCR'
      WarehouseOrderCreationRule : String(4) not null,
      _WarehouseOrderSplitChild : many D_WhseOrderSplitChildP not null
    ) returns many WarehouseOrder not null;
    action SetWarehouseOrderToInProcess();
    action UnlockWarehouseOrder();
    action UnassignWarehouseOrder();
    action LockWarehouseOrder();
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Lagerauftrag Kommissionier-Handling-Unit'
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _WarehouseOrder,
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.RequiredProperties : [ 'HandlingUnitExternalID' ]
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_WarehouseOrder' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Core.OptimisticConcurrency : [ '_WarehouseOrder/WhseOrderLastChgUTCDateTime' ]
  entity WarehouseOrderPickHndlgUnit {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagernummer'
    @Common.Heading : 'LNr'
    @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse : String(4) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lagerauftrag'
    @Common.Heading : 'LagAuftrag'
    @Common.QuickInfo : 'Lagerauftragsnummer'
    key WarehouseOrder : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Handling Unit'
    key HandlingUnitExternalID : String(20) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Produkt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    PackagingMaterial : String(18) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'HU-Kennung'
    @Common.QuickInfo : 'Kennung einer Handling Unit in einem Lagerauftrag'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_HUKNG'
    EWMWhseOrderNmbrOfHndlgUnits : String(3) not null;
    SAP__Messages : many SAP__Message not null;
    _WarehouseOrder : Association to one WarehouseOrder on _WarehouseOrder.WarehouseOrder = WarehouseOrder;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Lageraufgabe'
  @Common.Messages : SAP__Messages
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _WarehouseOrder,
      DeepUpdateSupport: { Supported: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.UpdateRestrictions.NonUpdatableProperties : [ 'WarehouseOrder' ]
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [
    '_WarehouseOrder',
    '_WarehouseTaskExceptionCode',
    '_WarehouseTaskSerialNumber'
  ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  @Capabilities.DeleteRestrictions.Deletable : false
  @Core.OptimisticConcurrency : [ 'WhseTaskLastChgUTCDateTime' ]
  @Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
    { Property: TargetQuantityInBaseUnit, AllowedExpressions: 'MultiValue' },
    { Property: TargetQuantityInAltvUnit, AllowedExpressions: 'MultiValue' },
    { Property: ActualQuantityInBaseUnit, AllowedExpressions: 'MultiValue' },
    { Property: ActualQuantityInAltvUnit, AllowedExpressions: 'MultiValue' },
    {
      Property: DifferenceQuantityInBaseUnit,
      AllowedExpressions: 'MultiValue'
    },
    {
      Property: DifferenceQuantityInAltvUnit,
      AllowedExpressions: 'MultiValue'
    },
    { Property: WhseTaskNetWeight, AllowedExpressions: 'MultiValue' },
    { Property: WhseTaskNetVolume, AllowedExpressions: 'MultiValue' }
  ]
  entity WarehouseTask {
    @Common.SAPObjectNodeTypeReference : 'Warehouse'
    @Core.ComputedDefaultValue : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagernummer'
    @Common.Heading : 'LNr'
    @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse : String(4) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lageraufgabe'
    @Common.Heading : 'LagAufgabe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTANUM_NOCONV'
    key WarehouseTask : String(12) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'LB-Pos.'
    @Common.Heading : 'Pos.'
    @Common.QuickInfo : 'Lageraufgabenposition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTAPOS_NOCONV'
    key WarehouseTaskItem : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseOrder'
    @Core.Immutable : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lagerauftrag'
    @Common.Heading : 'LagAuftrag'
    @Common.QuickInfo : 'Lagerauftragsnummer'
    WarehouseOrder : String(10) not null;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Common.Label : 'Erstellungsuhrzeit'
    WhseTaskCrtnUTCDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Common.Label : 'Kurzform Zeitstempel'
    @Common.Heading : 'Kurzform des Zeitstempels'
    @Common.QuickInfo : 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TZNTSTMPS'
    WhseTaskLastChgUTCDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Common.Label : 'Zeitstempel'
    @Common.QuickInfo : 'UTC-Zeitstempel in Kurzform (JJJJMMTThhmmss)'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=TIMESTAMP'
    WhseTaskConfUTCDateTime : DateTime;
    ConfirmedByUser : String(12) not null;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Common.Label : 'Gepl. Abschluss'
    @Common.QuickInfo : 'Geplanter Abschlusszeitpunkt'
    WhseTaskPlannedClosingDateTime : DateTime;
    @odata.Precision : 0
    @odata.Type : 'Edm.DateTimeOffset'
    @Common.Label : 'WE-Datum'
    @Common.QuickInfo : 'Datum und Uhrzeit des Wareneingangs'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLVS_WDATU_NOCONV'
    WhseTaskGoodsReceiptDateTime : DateTime;
    @Common.IsUpperCase : true
    @Common.Label : 'LB-Status'
    @Common.QuickInfo : 'Lageraufgabenstatus'
    WarehouseTaskStatus : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Lagerprozessart'
    @Common.Heading : 'LagProzArt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_PROCTY'
    WarehouseProcessType : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Lagerprozesstyp'
    @Common.Heading : 'T'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLVS_TRART'
    WarehouseProcessCategory : String(1) not null;
    @Common.Label : 'HU-Lageraufgabe'
    @Common.Heading : 'HU-LB'
    @Common.QuickInfo : 'Handling-Unit-Lageraufgabe'
    IsHandlingUnitWarehouseTask : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Handling-Unit-Typ'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_HUTYP'
    EWMHandlingUnitType : String(4) not null;
    @Common.Label : 'HU-Typ-Gruppe'
    @Common.Heading : 'HU-Gr'
    @Common.QuickInfo : 'Handling-Unit-Typ-Gruppe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_HUTYPGRP'
    HandlingUnitTypeGroup : String(4) not null;
    @Common.Label : 'Entnahme ganze HU'
    @Common.Heading : 'Ganze HU'
    @Common.QuickInfo : 'Entnahme einer ganzen homogenen Handling Unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_HOMVE'
    HomogeneousFullPalletPick : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'EinlgInv. gepl.'
    @Common.Heading : 'Inv. gepl.'
    @Common.QuickInfo : 'Einlagerinventur geplant'
    EWMPutAwayPhysInvtryPlnSts : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'NdBestKtr. gepl'
    @Common.Heading : 'NBK gepl'
    @Common.QuickInfo : 'Niederbestandskontrolle geplant'
    EWMWhseTskLowStkChkPlnSts : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'EinlInv. ausgef'
    @Common.Heading : 'Inv. ausgf'
    @Common.QuickInfo : 'Einlagerinventur durchgeführt'
    EWMPutAwayPhysInvtryExecSts : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'NBstK durchgef.'
    @Common.Heading : 'NiBeKont'
    @Common.QuickInfo : 'Niederbestandskontrolle durchgeführt'
    EWMWhseTskLowStkChkExecSts : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Produkt'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PRODUCTNUMBER'
    Product : String(18) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Charge'
    Batch : String(10) not null;
    @Common.Label : 'Charge ändern'
    @Common.QuickInfo : 'Ändern der Charge ist nicht erlaubt'
    BatchChangeIsNotAllowed : Boolean not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Ursprungsl./-region'
    @Common.Heading : 'Herkunft'
    @Common.QuickInfo : 'Ursprungsland/-region'
    CountryOfOrigin : String(3) not null;
    @Common.Label : 'Verfallsdatum'
    @Common.Heading : 'Verf./MHD'
    @Common.QuickInfo : 'Verfallsdatum oder Mindesthaltbarkeitsdatum'
    ShelfLifeExpirationDate : Date;
    @Common.IsUpperCase : true
    @Common.Label : 'Bestandsart'
    @Common.Heading : 'Art'
    EWMStockType : String(2) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Verwendung'
    @Common.Heading : 'Vwd'
    @Common.QuickInfo : 'Bestandsverwendung'
    EWMStockUsage : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Characterfeld der Länge 10'
    EWMStockOwner : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'VerfügBer.'
    @Common.QuickInfo : 'Verfügungsberechtigter'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ENTITLED'
    EntitledToDisposeParty : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Interne PSP-ID'
    @Common.Heading : 'PSP-Elm.'
    @Common.QuickInfo : 'PSP-Element'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_S4_PSPNR'
    WBSElementInternalID : String(8) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'PSP-Element'
    @Common.QuickInfo : 'Projektstrukturplan-Element (PSP-Element) bearbeitet'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=PS_POSID_EDIT'
    WBSElementExternalID : String(24) not null;
    SpecialStockIdfgSalesOrder : String(10) not null;
    @Common.IsDigitSequence : true
    SpecialStockIdfgSalesOrderItem : String(6) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseResource'
    @Common.IsUpperCase : true
    @Common.Label : 'Ressource'
    @Common.Heading : 'Ausführende Ressource'
    @Common.QuickInfo : 'Ausführende Ressource (Transportmittel oder Benutzer)'
    ExecutingResource : String(18) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Grund der Bewegung'
    @Common.Heading : 'Grund'
    @Common.QuickInfo : 'Grund für Bewegungen im Lager'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_REASON'
    WarehouseMovementsReason : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Produktionsauftrag'
    ProductionOrder : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ProdVersorgBereich'
    @Common.Heading : 'Produktionsversorgungsbereich'
    @Common.QuickInfo : 'Produktionsversorgungsbereich'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_PSA'
    EWMProductionSupplyArea : String(15) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegtyp'
    @Common.Heading : 'Typ'
    @Common.QuickInfo : 'Belegtyp für Belegreferenz und belegbezogenen Bestand'
    EWMDocumentCategory : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegtyp'
    @Common.Heading : 'Typ'
    @Common.QuickInfo : 'Belegtyp für Belegreferenz und belegbezogenen Bestand'
    EWMReferenceDocumentCategory : String(3) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Welle'
    EWMWave : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Wellenposition'
    EWMWaveItem : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegnummer'
    EWMDelivery : String(35) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Positionsnummer'
    EWMDeliveryItem : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegnummer'
    EWMProductionMaterialRequest : String(35) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Positionsnummer'
    EWMProductionMaterialReqItem : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Bestellung'
    @Common.QuickInfo : 'Bestellnummer'
    PurchasingDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Bestellposition'
    @Common.Heading : 'Pos.'
    @Common.QuickInfo : 'Positionsnummer der Bestellung'
    PurchasingDocumentItem : String(5) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Vertriebsbeleg'
    @Common.Heading : 'Beleg'
    @Common.QuickInfo : 'Vertriebsbelegnummer'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=VBELN'
    SalesDocument : String(10) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Verkaufsbelegpos.'
    @Common.Heading : 'VBPos.'
    @Common.QuickInfo : 'Verkaufsbelegposition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=POSNR_VA'
    SalesDocumentItem : String(6) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegtyp'
    @Common.Heading : 'Typ'
    @Common.QuickInfo : 'Belegtyp für Belegreferenz und belegbezogenen Bestand'
    EWMStockReferenceDocCategory : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Belegnummer'
    EWMStockReferenceDocument : String(35) not null;
    @Common.IsDigitSequence : true
    @Common.Label : 'Positionsnummer'
    EWMStockReferenceDocumentItem : String(10) not null;
    @Common.IsUnit : true
    @Common.Label : 'Basismengeneinheit'
    @Common.Heading : 'BME'
    BaseUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO-Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO-Code Maßeinheit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    EWMBaseUnitISOCode : String(3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Alt.Mengeneinheit'
    @Common.Heading : 'AME'
    @Common.QuickInfo : 'Alternativmengeneinheit zur Lagermengeneinheit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_AUNIT'
    AlternativeUnit : String(3) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'ISO-Code'
    @Common.Heading : 'ISO'
    @Common.QuickInfo : 'ISO-Code Maßeinheit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=ISOCD_UNIT'
    EWMAlternativeUnitISOCode : String(3) not null;
    @Measures.Unit : BaseUnit
    @Common.Label : 'Zielmenge BME'
    @Common.QuickInfo : 'Zielmenge in Basismengeneinheit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VSOLM'
    TargetQuantityInBaseUnit : Decimal(31, 14) not null;
    @Measures.Unit : AlternativeUnit
    @Common.Label : 'Zielmenge AME'
    @Common.QuickInfo : 'Zielmenge in Alternativmengeneinheit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VSOLA'
    TargetQuantityInAltvUnit : Decimal(31, 14) not null;
    @Measures.Unit : BaseUnit
    ActualQuantityInBaseUnit : Decimal(31, 14) not null;
    @Measures.Unit : AlternativeUnit
    ActualQuantityInAltvUnit : Decimal(31, 14) not null;
    @Measures.Unit : BaseUnit
    DifferenceQuantityInBaseUnit : Decimal(31, 14) not null;
    @Measures.Unit : AlternativeUnit
    DifferenceQuantityInAltvUnit : Decimal(31, 14) not null;
    @Common.IsUnit : true
    @Common.Label : 'Gewichtseinheit'
    @Common.Heading : 'EH'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WGT_UOM'
    WhseTaskNetWeightUnitOfMeasure : String(3) not null;
    @Measures.Unit : WhseTaskNetWeightUnitOfMeasure
    @Common.Label : 'Ladungsgewicht'
    @Common.QuickInfo : 'Ladungs- oder Nettogewicht'
    WhseTaskNetWeight : Decimal(15, 3) not null;
    @Common.IsUnit : true
    @Common.Label : 'Volumeneinheit'
    @Common.Heading : 'VEH'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_VOL_UOM'
    WhseTaskNetVolumeUnitOfMeasure : String(3) not null;
    @Measures.Unit : WhseTaskNetVolumeUnitOfMeasure
    @Common.Label : 'Ladungsvolumen'
    @Common.QuickInfo : 'Ladungs- oder Nettovolumen'
    WhseTaskNetVolume : Decimal(15, 3) not null;
    Kanban : String(10) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseStorageType'
    @Common.IsUpperCase : true
    @Common.Label : 'Von-Lagertyp'
    @Common.Heading : 'Typ'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLTYP'
    SourceStorageType : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Vonlagerbereich'
    @Common.Heading : 'Ber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLBER'
    SourceStorageSection : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseStorageBin'
    @Common.IsUpperCase : true
    @Common.Label : 'Von-Lagerplatz'
    @Common.Heading : 'Von-Platz'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLPLA'
    SourceStorageBin : String(18) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseResource'
    @Common.IsUpperCase : true
    @Common.Label : 'Von-Ressource'
    @Common.QuickInfo : 'Von-Ressource (Transportmittel oder Benutzer)'
    SourceResource : String(18) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseStorageType'
    @Common.IsUpperCase : true
    @Common.Label : 'Nachlagertyp'
    @Common.Heading : 'Typ'
    DestinationStorageType : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Nachlagerbereich'
    @Common.Heading : 'Ber'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_NLBER'
    DestinationStorageSection : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseStorageBin'
    @Common.IsUpperCase : true
    @Common.Label : 'Nach-Lagerplatz'
    @Common.Heading : 'Nach-Platz'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_NLPLA'
    DestinationStorageBin : String(18) not null;
    @Common.SAPObjectNodeTypeReference : 'WarehouseResource'
    @Common.IsUpperCase : true
    @Common.Label : 'Nach-Ressource'
    @Common.QuickInfo : 'Nach-Ressource (Transportmittel oder Benutzer)'
    DestinationResource : String(18) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Lageraufgabenart'
    @Common.Heading : 'LB-Art'
    @Common.QuickInfo : 'LB-Art innerhalb der zweistufigen Kommissionierung'
    WhseTaskTwoStepPickingType : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Zweistuf. Kommiss.'
    @Common.Heading : '2stK'
    @Common.QuickInfo : 'Relevanz für zweistufige Kommissionierung'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_L2SKR'
    WhseTaskTwoStepPickingRlvnce : String(1) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Aktivitätsbereich'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_AAREA'
    ActivityArea : String(4) not null;
    @Common.SAPObjectNodeTypeReference : 'HandlingUnit'
    @Common.IsUpperCase : true
    @Common.Label : 'Von-Handling-Unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLENR_NOCONV'
    SourceHandlingUnit : String(20) not null;
    @Common.SAPObjectNodeTypeReference : 'HandlingUnit'
    @Common.IsUpperCase : true
    @Common.Label : 'Nach-HU'
    @Common.Heading : 'Nach-Handling Unit'
    @Common.QuickInfo : 'Nach-Handling-Unit'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_DESHU_NOCONV'
    DestinationHandlingUnit : String(20) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'LB an SUB-System'
    @Common.Heading : 'SUB'
    @Common.QuickInfo : 'Kennzeichen: Lageraufgabe an SUB-System übergeben'
    WrhsTaskSubsystemTransmn : String(1) not null;
    WarehouseTaskExceptionCode : String(4) not null;
    @Common.Label : 'Sortierreihenfolge'
    @Common.Heading : 'Sortierr.'
    WhseTaskSortingSequenceValue : Decimal(precision: 10) not null;
    @Common.Label : 'Reihenfolge'
    @Common.QuickInfo : 'Interne Reihenfolge des Lagerauftrags'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WHOSEQ'
    WarehouseOrderSequenceValue : Double not null;
    @Common.IsUpperCase : true
    @Common.Label : 'LA-Aktivitätsbereich'
    @Common.Heading : 'Aktivitätsbereich'
    @Common.QuickInfo : 'Lagerauftragsaktivitätsbereich'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WHOAA'
    WarehouseOrderActivityArea : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'LA-Erstellungsregel'
    @Common.Heading : 'Lagerauftragserstellungsregel'
    @Common.QuickInfo : 'Lagerauftragserstellungsregel'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WCR'
    WarehouseOrderCreationRule : String(4) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Queue'
    @Common.Heading : 'Q'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_QUEUE'
    WarehouseOrderQueue : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Aktivität'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_ACTTY'
    WarehouseActivityType : String(4) not null;
    @Common.Label : 'Konsolidierungsgrup.'
    @Common.Heading : 'KonsGr'
    @Common.QuickInfo : 'Konsolidierungsgruppe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_DSTGRP'
    EWMConsolidationGroup : String(10) not null;
    @odata.Type : 'Edm.Byte'
    @Common.Label : 'Priorität'
    @Common.Heading : 'Priorit.'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_PRIOR'
    EWMWarehouseTaskPriority : Integer not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Angelegt von'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_CREATOR'
    CreatedByUser : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Route'
    @Common.QuickInfo : 'Name der Route (Identifikation)'
    EWMRoute : String(10) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Wellentyp'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_WAVECAT'
    EWMWaveCategory : String(2) not null;
    @Common.IsDigitSequence : true
    EWMCanceledWarehouseTask : String(12) not null;
    @Common.IsUpperCase : true
    @Common.Label : 'Serialnummernpflicht'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_SER_STOCK'
    SerialNumberRequiredLevel : String(1) not null;
    SAP__Messages : many SAP__Message not null;
    _WarehouseOrder : Association to one WarehouseOrder on _WarehouseOrder.WarehouseOrder = WarehouseOrder;
    @Common.Composition : true
    _WarehouseTaskExceptionCode : Composition of many WarehouseTaskExceptionCode on _WarehouseTaskExceptionCode._WarehouseTask = $self;
    @Common.Composition : true
    _WarehouseTaskSerialNumber : Composition of many WarehouseTaskSerialNumber on _WarehouseTaskSerialNumber._WarehouseTask = $self;
  } actions {
    action AddSrlNmbrToTaskConf(
      @Common.FieldControl : #Mandatory
      EWMSerialNumber : String(30) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'Serialnummer für Differenzmenge'
      EWMSerialNumberIsForDiffQty : Boolean not null default null
    );
    action ConfirmWarehouseTaskProduct(
      @Common.FieldControl : #Mandatory
      @Common.IsUnit : true
      @Common.Label : 'Alt.Mengeneinheit'
      @Common.Heading : 'AME'
      @Common.QuickInfo : 'Alternative Mengeneinheit für Lagermengeneinheit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_AUNIT_NOCONV'
      AlternativeUnit : String(3) not null,
      @Common.FieldControl : #Mandatory
      @Measures.Unit : AlternativeUnit
      @Common.Label : 'Istmenge'
      @Common.QuickInfo : 'Istmenge in alternativer Mengeneinheit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_NISTA'
      ActualQuantityInAltvUnit : Decimal(31, 14) not null,
      @Common.FieldControl : #Mandatory
      @Measures.Unit : AlternativeUnit
      @Common.Label : 'Differenzmenge'
      @Common.QuickInfo : 'Menge der Differenzenbuchung in alternativer Mengeneinheit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_DMENA'
      DifferenceQuantityInAltvUnit : Decimal(31, 14) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Ausnahmecode'
      @Common.QuickInfo : 'Ausnahme-Code'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EXCCODE'
      WhseTaskExceptionCodeQtyDiff : String(4) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Nach-Lagerplatz'
      @Common.Heading : 'Nach-Platz'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_NLPLA'
      DestinationStorageBin : String(18) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Ausnahmecode'
      @Common.QuickInfo : 'Ausnahme-Code'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EXCCODE'
      WhseTaskExCodeDestStorageBin : String(4) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Von-Handling-Unit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLENR_NOCONV'
      SourceHandlingUnit : String(20) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Von-Handling-Unit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_VLENR_NOCONV'
      DestinationHandlingUnit : String(20) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'Nach-Ressource'
      @Common.QuickInfo : 'Nach-Ressource (Transportmittel oder Benutzer)'
      DestinationResource : String(18) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'EinlInv. ausgef'
      @Common.Heading : 'Inv. ausgf'
      @Common.QuickInfo : 'Einlagerinventur durchgeführt'
      EWMPutAwayPhysInvtryExecSts : String(1) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'NBstK durchgef.'
      @Common.Heading : 'NiBeKont'
      @Common.QuickInfo : 'Niederbestandskontrolle durchgeführt'
      EWMWhseTskLowStkChkExecSts : String(1) not null default null,
      @Measures.Unit : AlternativeUnit
      @Common.Label : 'Restmenge'
      @Common.QuickInfo : 'Restmenge auf dem Vonlagerplatz in alt. Mengeneinheit'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_RESTA'
      EWMWhseTaskLowStockCheckQty : Decimal(31, 14) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'HU-Entnahme'
      @Common.QuickInfo : 'Kennzeichen: Handling Unit wird komplett entnommen'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_HU_HUENT'
      EWMHandlingUnitIsNotWithdrawn : Boolean not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Direkte Quittierung oder Stornierung'
      @Common.QuickInfo : 'Direkte Quittierung oder Stornierung von Lageraufg. erlaubt'
      DirectWhseTaskConfIsAllowed : Boolean not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Charge'
      Batch : String(10) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Ausnahmecode'
      @Common.QuickInfo : 'Ausnahme-Code'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EXCCODE'
      EWMWhseTskExcptnCodeChgBatch : String(4) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Verarbeitung von externer Lageraufgabe'
      ExternalWhseTaskIsProcessable : Boolean not null default null
    );
    action CancelWarehouseTask(
      @Common.IsUpperCase : true
      @Common.Label : 'Direkte Quittierung oder Stornierung'
      @Common.QuickInfo : 'Direkte Quittierung oder Stornierung von Lageraufg. erlaubt'
      DirectWhseTaskConfIsAllowed : Boolean not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Verarbeitung von externer Lageraufgabe'
      ExternalWhseTaskIsProcessable : Boolean not null default null
    );
    action ReassignToWarehouseOrder(
      @Common.FieldControl : #Mandatory
      @Common.Label : 'Lagerauftrag'
      @Common.Heading : 'LagAuftrag'
      @Common.QuickInfo : 'Lagerauftragsnummer'
      WarehouseOrder : String(10) not null
    );
    action ConfirmWarehouseTaskHndlgUnit(
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Nach-Lagerplatz'
      @Common.Heading : 'Nach-Platz'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLTAP_NLPLA'
      DestinationStorageBin : String(18) not null,
      @Common.FieldControl : #Mandatory
      @Common.IsUpperCase : true
      @Common.Label : 'Ausnahmecode'
      @Common.QuickInfo : 'Ausnahme-Code'
      @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EXCCODE'
      WhseTaskExCodeDestStorageBin : String(4) not null,
      @Common.IsUpperCase : true
      @Common.Label : 'Nach-Ressource'
      @Common.QuickInfo : 'Nach-Ressource (Transportmittel oder Benutzer)'
      DestinationResource : String(18) not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Direkte Quittierung oder Stornierung'
      @Common.QuickInfo : 'Direkte Quittierung oder Stornierung von Lageraufg. erlaubt'
      DirectWhseTaskConfIsAllowed : Boolean not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Verarbeitung von externer Lageraufgabe'
      ExternalWhseTaskIsProcessable : Boolean not null default null
    );
    action ConfirmWarehouseTaskExact(
      @Common.IsUpperCase : true
      @Common.Label : 'Direkte Quittierung oder Stornierung'
      @Common.QuickInfo : 'Direkte Quittierung oder Stornierung von Lageraufg. erlaubt'
      DirectWhseTaskConfIsAllowed : Boolean not null default null,
      @Common.IsUpperCase : true
      @Common.Label : 'Verarbeitung von externer Lageraufgabe'
      ExternalWhseTaskIsProcessable : Boolean not null default null
    );
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Lageraufgabe Ausnahmecode'
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _WarehouseTask,
      InsertRestrictions: { Insertable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_WarehouseTask' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity WarehouseTaskExceptionCode {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagernummer'
    @Common.Heading : 'LNr'
    @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse : String(4) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lageraufgabe'
    @Common.Heading : 'LagAufgabe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTANUM_NOCONV'
    key WarehouseTask : String(12) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'LB-Pos.'
    @Common.Heading : 'Pos.'
    @Common.QuickInfo : 'Lageraufgabenposition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTAPOS_NOCONV'
    key WarehouseTaskItem : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Ausnahmecode'
    @Common.QuickInfo : 'Ausnahme-Code'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_EXCCODE'
    key WarehouseTaskExceptionCode : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Geschäftskontext'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FDE_BUSCON'
    key BusinessContext : String(3) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'AusführSchritt'
    @Common.QuickInfo : 'Ausführungsschritt im Business-Kontext'
    key BusinessContextExecutionStep : String(2) not null;
    _WarehouseTask : Association to one WarehouseTask on _WarehouseTask.WarehouseTaskItem = WarehouseTaskItem;
  };

  @cds.external : true
  @cds.persistence.skip : true
  @Common.Label : 'Lageraufgabe Serialnummer'
  @Capabilities.NavigationRestrictions.RestrictedProperties : [
    {
      NavigationProperty: _WarehouseTask,
      InsertRestrictions: { Insertable: false }
    }
  ]
  @Capabilities.SearchRestrictions.Searchable : false
  @Capabilities.InsertRestrictions.Insertable : false
  @Capabilities.DeleteRestrictions.Deletable : false
  @Capabilities.UpdateRestrictions.Updatable : false
  @Capabilities.UpdateRestrictions.NonUpdatableNavigationProperties : [ '_WarehouseTask' ]
  @Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
  entity WarehouseTaskSerialNumber {
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : 'Lagernummer'
    @Common.Heading : 'LNr'
    @Common.QuickInfo : 'Lagernummer/Lagerkomplex'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FLGNUM'
    key EWMWarehouse : String(4) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'Lageraufgabe'
    @Common.Heading : 'LagAufgabe'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTANUM_CONV_ALPHA'
    key WarehouseTask : String(12) not null;
    @Core.Computed : true
    @Common.IsDigitSequence : true
    @Common.Label : 'LB-Pos.'
    @Common.Heading : 'Pos.'
    @Common.QuickInfo : 'Lageraufgabenposition'
    @Common.DocumentationRef : 'urn:sap-com:documentation:key?=type=DE&id=%2FSCWM%2FTAPOS_NOCONV'
    key WarehouseTaskItem : String(4) not null;
    @Core.Computed : true
    @Common.IsUpperCase : true
    @Common.Label : '30 Characters'
    key EWMSerialNumber : String(30) not null;
    _WarehouseTask : Association to one WarehouseTask on _WarehouseTask.WarehouseTaskItem = WarehouseTaskItem;
  };
};

