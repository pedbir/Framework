


CREATE VIEW [Norm].[BridgeReportStructure]
AS

WITH source AS (
	SELECT  vr.SysDatetimeDeletedUTC
		   ,vr.SysSrcGenerationDateTime
		   ,vr.SysModifiedUTC
		   ,SysValidFromDateTime       = CAST(vr.LastUpdate AS DATETIME2(0))
		   ,BridgeReportStructure_bkey = vr.ID
		   ,GLAccount_bkey             = CAST(CAST(ISNULL(vr.Account, '-1') AS NVARCHAR(50)) + '#' + ISNULL(vr.Ftg, '-1') AS NVARCHAR(100))
		   ,LegalEntity_bkey           = CAST(ISNULL(vr.Ftg, le.LegalEntity_bkey) AS NVARCHAR(100))
		   ,GLAccountLegalEntity_bkey  = CAST(CAST(ISNULL(Account, '-1') AS NVARCHAR(50)) + '#' + ISNULL(vr.Ftg, le.LegalEntity_bkey) AS NVARCHAR(100))
		   ,ReportStructure_bkey       = CAST(ISNULL(vr.Str2account, '-1') AS NVARCHAR(100))
		   ,vr.UserId
	FROM Agresso_RawTyped.rt_Rapportstruktur_01 vr
	LEFT JOIN Norm.LegalEntity le ON ISNULL(vr.Ftg, '-1')  = IIF(vr.Ftg IS NULL, '-1', le.LegalEntity_bkey)
	WHERE vr.SysSrcGenerationDateTime = (SELECT MAX(vr.SysSrcGenerationDateTime) FROM Agresso_RawTyped.rt_Rapportstruktur_01 vr)
) 
-- Delete
SELECT  SysDatetimeDeletedUTC    = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysSrcGenerationDateTime 
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysValidFromDateTime     = CAST(GETUTCDATE() AS DATETIME2(0))
       ,BridgeReportStructure_bkey = CAST(BridgeReportStructure_bkey AS INT)
       ,GLAccount_bkey             = CAST(GLAccount_bkey AS NVARCHAR(100)) 
	   ,LegalEntity_bkey
	   ,GLAccountLegalEntity_bkey
       ,ReportStructure_bkey
       ,UserId	   
FROM     (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY ReportStructure_bkey ORDER BY SysValidFromDateTime DESC) FROM [$(DWH_2_Norm)].Norm.n_BridgeReportStructure nbrs) nbrs
WHERE nbrs.BridgeReportStructure_bkey NOT IN (SELECT BridgeReportStructure_bkey FROM source)
AND BridgeReportStructure_bkey <> '-1' AND nbrs._isFirst = 1 AND nbrs.SysDatetimeDeletedUTC IS NULL
-- Insert or Update
UNION ALL
SELECT s.SysDatetimeDeletedUTC
      ,s.SysSrcGenerationDateTime
      ,s.SysModifiedUTC
      ,s.SysValidFromDateTime
      ,BridgeReportStructure_bkey = CAST(s.BridgeReportStructure_bkey AS INT)
      ,GLAccount_bkey           = CAST(s.GLAccount_bkey AS NVARCHAR(100))
      ,s.LegalEntity_bkey
      ,s.GLAccountLegalEntity_bkey
      ,s.ReportStructure_bkey
      ,s.UserId 
FROM source s
GO
