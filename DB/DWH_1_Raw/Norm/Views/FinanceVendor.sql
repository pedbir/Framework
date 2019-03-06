CREATE VIEW Norm.FinanceVendor
AS

WITH DimRelationer AS (
SELECT  *
FROM    ( SELECT  rdr.SysModifiedUTC
                 ,rdr.Relatedattr
                 ,rdr.Relvalue
                 ,rdr.Attvalue
				 ,rdr.Client 
          FROM    Agresso_RawTyped.vrt_DimRelationer_01 rdr
          WHERE   rdr.Attname = 'LEVNR') p
PIVOT ( MAX(Relvalue)
        FOR Relatedattr IN (ROLLID, KST, SEGMENT, KONTO)) pvt
)
SELECT    SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
         ,vd.SysModifiedUTC
         ,vd.SysDatetimeDeletedUTC
         ,vd.SysSrcGenerationDateTime
         ,FinanceVendor_bkey          = CAST(vd.DimValue + '#' + vd.Client AS NVARCHAR(100))
         ,FinanceVendorCode           = vd.DimValue
         ,FinanceVendorName           = vd.DimDescription
         ,LegalEntity_bkey     = vd.Client
         ,vd.Status
         ,UpdatedBy            = vd.Userid                     
         ,CostCenter_bkey = CAST(ISNULL(dr.KST, '-1') AS NVARCHAR(100))
         ,FinanceSegment_bkey = CAST(ISNULL(dr.SEGMENT, '-1') AS NVARCHAR(100))
         
FROM      Agresso_RawTyped.vrt_Dimension_01 vd
LEFT JOIN (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY Attvalue, Client ORDER BY SysModifiedUTC DESC) FROM DimRelationer dr) dr ON dr.Attvalue = vd.DimValue AND dr.Client = vd.Client AND dr._isFirst = 1
WHERE     Attributeid = 'A5'