CREATE VIEW Norm.FinanceAnalysis
AS
SELECT 	SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
		,SysModifiedUTC
		,SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime	
		,FinanceAnalysis_bkey = CAST(DimValue + '#' + Client AS NVARCHAR(100))
		,FinanceAnalysisCode = DimValue
		,FinanceAnalysisName = DimDescription
		,LegalEntity_bkey = Client					
		,Status
		,UpdatedBy = Userid		
FROM Agresso_RawTyped.vrt_Dimension_01
WHERE Attributeid = 'F0'