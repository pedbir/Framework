
CREATE VIEW Fact.d_FinanceCustomer
AS

SELECT nfc.FinanceCustomer_key
      ,nfc.SysDatetimeDeletedUTC
      ,nfc2.SysModifiedUTC
      ,nfc.SysIsInferred
      ,nfc.SysValidFromDateTime
      ,nfc.SysSrcGenerationDateTime
      ,nfc.FinanceCustomer_bkey
      ,nfc2.FinanceCustomerCode
      ,nfc2.FinanceCustomerName      
      ,nfc2.Status
      ,nfc2.UpdatedBy
FROM Norm.n_FinanceCustomer nfc
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceCustomer nfc2 WHERE nfc2.FinanceCustomer_bkey = nfc.FinanceCustomer_bkey ORDER BY nfc2.SysValidFromDateTime DESC) nfc2