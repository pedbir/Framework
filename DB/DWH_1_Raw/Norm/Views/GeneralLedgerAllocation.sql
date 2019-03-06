CREATE VIEW Norm.GeneralLedgerAllocation
AS
SELECT  SysValidFromDateTime
       ,SysSrcGenerationDateTime
       ,SysDatetimeDeletedUTC
       ,SysModifiedUTC
	   ,GeneralLedgerAllocation_bkey = CAST(NEWID() AS NVARCHAR(100))
       ,AllocationPercent_bkey
       ,AllocationPrinciple_bkey
       ,FinanceVendor_From_bkey
       ,GLAccount_From_bkey
       ,LegalEntity_From_bkey
       ,Calender_From_bkey
       ,FinanceSegment_To_bkey
       ,AllocationPercent
       ,GLAccountLegalEntity_bkey
	   ,AllocationSource
FROM    OPENQUERY (MDS, '
SELECT      SysValidFromDateTime      = (SELECT MAX(v.LastChgDateTime) FROM (VALUES (vap.LastChgDateTime), (am.LastChgDateTime)) v (LastChgDateTime) )
           ,SysSrcGenerationDateTime  = CAST(vap.EnterDateTime AS DATETIME2(0))
           ,SysDatetimeDeletedUTC     = CAST(IIF(vap.State = ''Deleted'', vap.LastChgDateTime, NULL) AS DATETIME2(0))
           ,SysModifiedUTC            = CAST(GETUTCDATE() AS DATETIME2(0))
           ,AllocationPercent_bkey    = CAST(vap.Code AS NVARCHAR(50))
           ,AllocationPrinciple_bkey  = CAST(am.AllocationPrinciple_Code AS NVARCHAR(50))
           ,FinanceVendor_From_bkey   = CAST(IIF(vap.Vendor_Code = -1, ''-1'',  vap.Vendor_Code + ''#'' + ISNULL(am.LegalEntity_Code, ''-1'') ) AS NVARCHAR(100))
           ,GLAccount_From_bkey       = CAST(CAST(ISNULL(am.Account_Code, -1) AS NVARCHAR(50)) + ''#'' + ISNULL(am.LegalEntity_Code, ''-1'') AS NVARCHAR(100))
           ,LegalEntity_From_bkey     = CAST(am.LegalEntity_Code AS NVARCHAR(100))
           ,Calender_From_bkey        = CAST(ISNULL(EOMONTH(TRY_CAST(CAST(vap.Period AS NVARCHAR(6)) + ''01'' AS DATE)), ''1900-01-01'') AS DATETIME)
           ,FinanceSegment_To_bkey    = CAST(vap.Segment_Code AS NVARCHAR(100))
           ,AllocationPercent         = vap.AllocationPercent
           ,GLAccountLegalEntity_bkey = CAST(CAST(ISNULL(am.Account_Code, -1) AS NVARCHAR(50)) + ''#'' + ISNULL(am.LegalEntity_Code, ''-1'') AS NVARCHAR(100))
		   ,''VendorAllocation'' as AllocationSource
FROM        MDS.mdm.VendorAllocationPercent vap
INNER JOIN  MDS.mdm.AllocationMapping       am ON am.AllocationPrinciple_Code = 18
UNION ALL
SELECT      SysValidFromDateTime      = (SELECT MAX(v.LastChgDateTime) FROM (VALUES (vap.LastChgDateTime), (am.LastChgDateTime)) v (LastChgDateTime) )
           ,SysSrcGenerationDateTime  = CAST(vap.EnterDateTime AS DATETIME2(0))
           ,SysDatetimeDeletedUTC     = CAST(IIF(vap.State = ''Deleted'', vap.LastChgDateTime, NULL) AS DATETIME2(0))
           ,SysModifiedUTC            = CAST(GETUTCDATE() AS DATETIME2(0))
           ,AllocationPercent_bkey    = CAST(vap.Code AS NVARCHAR(50))
           ,AllocationPrinciple_bkey  = CAST(am.AllocationPrinciple_Code AS NVARCHAR(50))
           ,FinanceVendor_From_bkey   = ''%'' 
           ,GLAccount_From_bkey       = CAST(CAST(ISNULL(am.Account_Code, -1) AS NVARCHAR(50)) + ''#'' + ISNULL(am.LegalEntity_Code, ''-1'') AS NVARCHAR(100))
           ,LegalEntity_From_bkey     = CAST(am.LegalEntity_Code AS NVARCHAR(100))
           ,Calender_From_bkey        = CAST(ISNULL(EOMONTH(TRY_CAST(CAST(vap.Period AS NVARCHAR(6)) + ''01'' AS DATE)), ''1900-01-01'') AS DATETIME)
           ,FinanceSegment_To_bkey    = CAST(vap.Segment_Code AS NVARCHAR(100))
           ,AllocationPercent         = vap.AllocationPercent
           ,GLAccountLegalEntity_bkey = CAST(CAST(ISNULL(am.Account_Code, -1) AS NVARCHAR(50)) + ''#'' + ISNULL(am.LegalEntity_Code, ''-1'') AS NVARCHAR(100))
		   ,''AccountAllocation'' as AllocationSource
FROM        MDS.mdm.AllocationMapping am
INNER JOIN  MDS.mdm.AllocationPercent vap ON vap.AllocationPrinciple_Code = am.AllocationPrinciple_Code
') am
WHERE SysDatetimeDeletedUTC IS NULL