CREATE VIEW Norm.ReportStructure
AS

WITH source AS (
	SELECT  SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
		   ,SysSrcGenerationDateTime = CAST(NULL AS DATETIME2(0))
		   ,SysValidFromDateTime     = MAX(v.SysSrcGenerationDateTime)
		   ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
		   ,ReportStructure_bkey     = CAST(ISNULL(rk.Str2account, '-1') AS NVARCHAR(100))
		   ,ReportStructureLvl1Code  = rk.Str0account
		   ,ReportStructureLvl1Name  = rd.DimDescription
		   ,ReportStructureLvl2Code  = rk.Str1account
		   ,ReportStructureLvl2Name  = rd2.DimDescription
		   ,ReportStructureLvl3Code  = rk.Str2account
		   ,ReportStructureLvl3Name  = rd3.DimDescription       
	FROM  Agresso_RawTyped.rt_Rapportstruktur_01  rk
	OUTER APPLY (SELECT TOP 1 * FROM Agresso_RawTyped.rt_Dimension_01 rd WHERE rd.Attributeid = 'RA11' AND rd.Client = 'BFAB' AND rd.DimValue = rk.Str0account ORDER BY rd.SysSrcGenerationDateTime DESC) rd
	OUTER APPLY (SELECT TOP 1 * FROM Agresso_RawTyped.rt_Dimension_01 rd2 WHERE rd2.Attributeid = 'RA12' AND rd2.Client = 'BFAB' AND rd2.DimValue = rk.Str1account ORDER BY rd2.SysSrcGenerationDateTime DESC) rd2
	OUTER APPLY (SELECT TOP 1 * FROM Agresso_RawTyped.rt_Dimension_01 rd3 WHERE rd3.Attributeid = 'RA13' AND rd3.Client = 'BFAB' AND rd3.DimValue = rk.Str2account ORDER BY rd3.SysSrcGenerationDateTime DESC) rd3
	OUTER APPLY (SELECT MAX(v.SysSrcGenerationDateTime) AS SysSrcGenerationDateTime FROM (VALUES (rk.SysSrcGenerationDateTime), (rd.SysSrcGenerationDateTime), (rd2.SysSrcGenerationDateTime), (rd3.SysSrcGenerationDateTime)) AS v(SysSrcGenerationDateTime)) v
	WHERE rk.SysSrcGenerationDateTime = (SELECT MAX(vr.SysSrcGenerationDateTime) FROM Agresso_RawTyped.rt_Rapportstruktur_01 vr)
	GROUP BY rk.Str0account
			,rd.DimDescription
			,rk.Str1account
			,rd2.DimDescription
			,rk.Str2account
			,rd3.DimDescription
)
-- New Transaction
SELECT  SysDatetimeDeletedUTC
       ,SysSrcGenerationDateTime
       ,SysValidFromDateTime
       ,SysModifiedUTC
       ,ReportStructure_bkey
       ,ReportStructureLvl1Code
       ,ReportStructureLvl1Name
       ,ReportStructureLvl2Code
       ,ReportStructureLvl2Name
       ,ReportStructureLvl3Code
       ,ReportStructureLvl3Name
FROM    source
-- Deleted Transactions
UNION ALL
SELECT  SysDatetimeDeletedUTC   = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysSrcGenerationDateTime
       ,SysValidFromDateTime    = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysModifiedUTC          = CAST(GETUTCDATE() AS DATETIME2(0))
       ,ReportStructure_bkey
       ,ReportStructureLvl1Code
       ,ReportStructureLvl1Name
       ,ReportStructureLvl2Code
       ,ReportStructureLvl2Name
       ,ReportStructureLvl3Code
       ,ReportStructureLvl3Name	   
FROM    (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY ReportStructure_bkey ORDER BY SysValidFromDateTime DESC) FROM [$(DWH_2_Norm)].Norm.n_ReportStructure) t
WHERE   t.ReportStructure_bkey NOT IN ( SELECT  s.ReportStructure_bkey FROM source s ) AND t.SysDatetimeDeletedUTC IS NULL
AND t.ReportStructure_bkey <> '-1' AND t._isFirst = 1
GO

