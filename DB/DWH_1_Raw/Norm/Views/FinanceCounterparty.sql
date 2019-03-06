CREATE VIEW Norm.FinanceCounterparty
AS
SELECT 	SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
		,SysModifiedUTC
		,SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime	
		,FinanceCounterparty_bkey = CAST(DimValue + '#' + Client AS NVARCHAR(100))
		,FinanceCounterpartyCode = DimValue
		,FinanceCounterpartyName = DimDescription
		,LegalEntity_bkey = Client					
		,Status
		,UpdatedBy = Userid				
FROM Agresso_RawTyped.vrt_Dimension_01
WHERE Attributeid = 'N6'