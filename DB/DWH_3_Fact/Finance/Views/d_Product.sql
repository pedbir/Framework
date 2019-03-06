CREATE VIEW Finance.d_Product
AS
SELECT FinanceProduct_key
      ,ProductCode = FinanceProductCode
      ,Product = IIF(FinanceProduct_key = -1, FinanceProductCode, FinanceProductCode  + ' ' +  FinanceProductName )
FROM [Fact].[d_FinanceProduct]