



CREATE VIEW [Marketing].[d_FinanceProduct]
AS

SELECT   fp.FinanceProduct_key
		,FinanceProductCode		= FinanceProductCode
        ,FinanceProduct			= IIF(fp.FinanceProduct_key = -1, FinanceProductCode, FinanceProductName )
FROM Fact.d_FinanceProduct fp
INNER JOIN  (SELECT DISTINCT FinanceProduct_key FROM Marketing.f_FinanceMarketMetrics ) fmm ON fp.FinanceProduct_key = fmm.FinanceProduct_key