

CREATE VIEW [Norm].[AllocationPrinciple]
AS
SELECT  SysValidFromDateTime     = CAST(LastChgDateTime AS DATETIME2(0))
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysDatetimeDeletedUTC    = CAST(IIF(state = 'Deleted', LastChgDateTime, NULL) AS DATETIME2(0))
       ,SysSrcGenerationDateTime = CAST(EnterDateTime AS DATETIME2(0))
       ,AllocationPrinciple_bkey = CAST(Code AS NVARCHAR(50))
       ,AllocationPrincipleName  = CAST(Name AS NVARCHAR(255))
FROM    OPENQUERY (MDS, 'SELECT * FROM MDS.mdm.AllocationPrinciple')
UNION ALL
SELECT  SysValidFromDateTime     = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
       ,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
       ,AllocationPrinciple_bkey = '-99'
       ,AllocationPrincipleName  = '# Counter Booking'
UNION ALL
SELECT  SysValidFromDateTime     = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
       ,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
       ,AllocationPrinciple_bkey = '-999'
       ,AllocationPrincipleName  = '# Original Booking'