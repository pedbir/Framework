CREATE VIEW Fact.d_Currency
AS

SELECT nc.Currency_key      
      ,nc.SysDatetimeDeletedUTC      
      ,nc2.SysModifiedUTC
      ,nc.SysIsInferred
      ,nc.SysValidFromDateTime
      ,nc.SysSrcGenerationDateTime
      ,nc2.Currency_bkey
      ,nc2.CurrencyName
FROM Norm.n_Currency nc 
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Currency nc2 WHERE nc2.Currency_bkey = nc.Currency_bkey ORDER BY nc2.SysValidFromDateTime DESC) nc2