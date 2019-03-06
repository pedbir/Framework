CREATE VIEW Fact.d_LegalEntity
AS
SELECT nle.LegalEntity_key
      ,nle.SysDatetimeDeletedUTC
      ,nle2.SysModifiedUTC
      ,nle.SysIsInferred
      ,nle.SysValidFromDateTime
      ,nle.SysSrcGenerationDateTime
      ,nle.LegalEntity_bkey
      ,nle2.LegalEntityName
      ,nle2.Status
      ,nle2.UpdatedBy
FROM Norm.n_LegalEntity nle
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_LegalEntity nle2 WHERE nle2.LegalEntity_bkey = nle.LegalEntity_bkey ORDER BY nle2.SysValidFromDateTime DESC) nle2