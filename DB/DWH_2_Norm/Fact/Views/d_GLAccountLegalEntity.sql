CREATE VIEW Fact.d_GLAccountLegalEntity
AS

SELECT ngale.GLAccountLegalEntity_key
      ,ngale.SysDatetimeDeletedUTC
      ,ngale.SysModifiedUTC
      ,ngale.SysIsInferred
      ,ngale.SysSrcGenerationDateTime
      ,ngale.SysValidFromDateTime
      ,ngale.GLAccountLegalEntity_bkey
      ,ngale.GLAccount_bkey
      ,ngale.LegalEntity_bkey 
FROM Norm.n_GLAccountLegalEntity ngale