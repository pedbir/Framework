
CREATE VIEW Fact.d_FinanceCounterparty
AS

SELECT nfc.FinanceCounterparty_key
      ,nfc.SysDatetimeDeletedUTC
      ,nfc2.SysModifiedUTC
      ,nfc.SysIsInferred
      ,nfc.SysValidFromDateTime
      ,nfc.SysSrcGenerationDateTime
      ,nfc.FinanceCounterparty_bkey
      ,nfc2.FinanceCounterpartyCode
      ,nfc2.FinanceCounterpartyName      
      ,nfc2.Status
      ,nfc2.UpdatedBy 
FROM Norm.n_FinanceCounterparty nfc
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceCounterparty nfc2 WHERE nfc2.FinanceCounterparty_bkey = nfc.FinanceCounterparty_bkey ORDER BY nfc2.SysValidFromDateTime DESC) nfc2