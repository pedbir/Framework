


   
CREATE VIEW [Norm].[CostCenter]
AS

WITH DimRelationer AS (
SELECT  *
FROM    ( SELECT  rdr.Relatedattr
                 ,rdr.Relvalue
                 ,rdr.Attvalue
				 ,rdr.Client 
          FROM    Agresso_RawTyped.vrt_DimRelationer_01 rdr
          WHERE   rdr.Attname = 'KST') p
PIVOT ( MAX(Relvalue)
        FOR Relatedattr IN ([AE],[ANV],[ATT2],[AVD],[ROLLID])) pvt
)
SELECT  SysValidFromDateTime   = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysModifiedUTC         = CAST(GETUTCDATE() AS DATETIME2(0))
       ,vd.SysDatetimeDeletedUTC
       ,vd.SysSrcGenerationDateTime
	   ,CostCenter_bkey        = CAST(ISNULL(vd.DimValue, '-1') + '#' + ISNULL(vd.Client, '-1') AS NVARCHAR(100))
       ,CostCenterCode         = ISNULL(vd.DimValue,'-1')
	   ,CostCenterName         = CAST(COALESCE(vd.DimDescription, vdbfab.DimDescription, 'N/A') AS NVARCHAR(250))
	   ,LegalEntity_bkey       = vd.Client
       ,vd.Status
       ,UpdatedBy              = vd.Userid
       ,CostCenterManagerCode  = CAST(ISNULL(dr.ANV, '-1') AS NVARCHAR(100))
       ,CostCenterManger       = CAST(ISNULL(vd1.DimDescription, 'N/A') AS NVARCHAR(100))
       ,SecondLineApproverCode = CAST(ISNULL(dr.ATT2, '-1') AS NVARCHAR(100))
       ,SecondLineApprover     = CAST(ISNULL(vd2.DimDescription, 'N/A') AS NVARCHAR(100))
       ,DepartmentCode         = CAST(ISNULL(dr.AVD, '-1') AS NVARCHAR(100))
       ,Department             = CAST(ISNULL(vd3.DimDescription, 'N/A') AS NVARCHAR(100))
FROM    Agresso_RawTyped.vrt_Dimension_01 vd
LEFT JOIN (SELECT DimValue,DimDescription FROM Agresso_RawTyped.vrt_Dimension_01 WHERE Attributeid = 'C1' AND Client = 'BFAB') vdbfab ON   vd.DimValue = vdbfab.DimValue
LEFT JOIN DimRelationer dr ON dr.Attvalue   = vd.DimValue AND dr.Client = vd.Client 
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd1 ON dr.ANV = vd1.DimValue AND vd1.Attname = 'ANV' AND vd1.Client = vd.Client
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd2 ON dr.ATT2 = vd2.DimValue AND vd2.Attname = 'ATT2' AND vd2.Client = vd.Client
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd3 ON dr.AVD = vd3.DimValue AND vd3.Attname = 'AVD' AND vd3.Client = vd.Client
WHERE     vd.Attributeid = 'C1'
