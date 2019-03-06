CREATE VIEW Norm.FinanceProduct
AS
SELECT 	SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
		,SysModifiedUTC
		,SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime	
		,FinanceProduct_bkey = CAST(DimValue + '#' + Client AS NVARCHAR(100))
		,FinanceProductCode = DimValue
		,FinanceProductName = DimDescription
		,LegalEntity_bkey = Client					
		,Status
		,UpdatedBy = Userid					
FROM Agresso_RawTyped.vrt_Dimension_01
WHERE Attributeid = 'ZZPR'