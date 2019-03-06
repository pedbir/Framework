CREATE VIEW Norm.LegalEntity
AS

SELECT 	SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
		,SysModifiedUTC
		,SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime	
		,LegalEntity_bkey = CAST(DimValue AS NVARCHAR(100))		
		,LegalEntityName = DimDescription				
		,Status
		,UpdatedBy = Userid		
FROM (SELECT *, _isFirst = LAG(0,1,1)  OVER (PARTITION BY Attributeid, DimValue ORDER BY Client, SysSrcGenerationDateTime DESC) FROM Agresso_RawTyped.rt_Dimension_01  WHERE Attributeid = 'A3') t
WHERE t._isFirst = 1