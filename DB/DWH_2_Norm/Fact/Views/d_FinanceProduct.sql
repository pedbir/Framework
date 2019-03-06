

CREATE VIEW Fact.d_FinanceProduct
AS
SELECT nfp.FinanceProduct_key
      ,nfp.SysDatetimeDeletedUTC
      ,nfp2.SysModifiedUTC
      ,nfp.SysIsInferred
      ,nfp.SysValidFromDateTime
      ,nfp.SysSrcGenerationDateTime
      ,nfp.FinanceProduct_bkey
      ,nfp2.FinanceProductCode
      ,nfp2.FinanceProductName      
      ,nfp2.Status
      ,nfp2.UpdatedBy
FROM Norm.n_FinanceProduct nfp
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceProduct nfp2 WHERE nfp2.FinanceProduct_bkey = nfp.FinanceProduct_bkey ORDER BY nfp2.SysValidFromDateTime DESC) nfp2