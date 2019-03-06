CREATE VIEW Norm.FinanceCustomer
AS

SELECT SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
			 ,SysModifiedUTC
			 ,SysDatetimeDeletedUTC
			 ,SysSrcGenerationDateTime
			 ,FinanceCustomer_bkey = CAST(DimValue + '#' + Client AS NVARCHAR(100))
			 ,FinanceCustomerCode = DimValue
			 ,FinanceCustomerName = DimDescription
			 ,LegalEntity_bkey = Client
			 ,Status
			 ,UpdatedBy = Userid
FROM Agresso_RawTyped.vrt_Dimension_01 rd
WHERE rd.Attributeid = 'A4'