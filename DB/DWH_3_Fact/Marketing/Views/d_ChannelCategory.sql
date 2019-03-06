




CREATE VIEW [Marketing].[d_ChannelCategory]
AS

SELECT	ChannelCategory_key     = ga.GLAccount_key
	   ,ChannelCategoryCode		= GLAccountCode
       ,ChannelCategory			= IIF(ga.GLAccount_key = -1, ga.GLAccountCode , LTRIM(REPLACE(GLAccountName,'Marknadsföring','')))
 FROM Fact.d_GLAccount ga
INNER JOIN  (SELECT DISTINCT ChannelCategory_key  FROM Marketing.f_FinanceMarketMetrics ) fmm  ON ga.GLAccount_key = fmm.ChannelCategory_key