CREATE VIEW Norm.Currency
AS

WITH Currency AS 
(
SELECT N'EUR' AS CurrencyISO, N'Euro'  AS CurrencyName
UNION ALL SELECT N'GBP', N'British Pound' 
UNION ALL SELECT N'NOK', N'Norwegian Krone'
UNION ALL SELECT N'SEK', N'Swedish Krona' 
UNION ALL SELECT N'USD', N'US Dollar' 
)
SELECT 	SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysDatetimeDeletedUTC = CAST(NULL AS DATETIME2(0))
		,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))	
		,Currency_bkey = c.CurrencyISO
		,c.CurrencyName 
FROM Currency c