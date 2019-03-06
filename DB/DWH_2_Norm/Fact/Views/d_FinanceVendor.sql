CREATE VIEW Fact.d_FinanceVendor
AS
SELECT nfv.FinanceVendor_key
      ,nfv.SysDatetimeDeletedUTC
      ,nfv2.SysModifiedUTC
      ,nfv.SysIsInferred
      ,nfv.SysValidFromDateTime
      ,nfv.SysSrcGenerationDateTime
      ,nfv.FinanceVendor_bkey
      ,nfv2.FinanceVendorCode
      ,nfv2.FinanceVendorName      
      ,nfv2.Status
      ,nfv2.UpdatedBy      
FROM Norm.n_FinanceVendor nfv
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceVendor nfv2 WHERE nfv2.FinanceVendor_bkey = nfv.FinanceVendor_bkey ORDER BY nfv2.SysValidFromDateTime DESC) nfv2