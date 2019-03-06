

CREATE VIEW Fact.d_ReportStructure
AS
SELECT nrs.ReportStructure_key
      ,nrs2.SysDatetimeDeletedUTC
      ,nrs2.SysModifiedUTC
      ,nrs.SysIsInferred
      ,nrs.SysSrcGenerationDateTime
      ,nrs.SysValidFromDateTime
      ,nrs.ReportStructure_bkey
      ,nrs2.ReportStructureLvl1Code
      ,nrs2.ReportStructureLvl1Name
      ,nrs2.ReportStructureLvl2Code
      ,nrs2.ReportStructureLvl2Name
      ,nrs2.ReportStructureLvl3Code
      ,nrs2.ReportStructureLvl3Name 
FROM Norm.n_ReportStructure nrs
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_ReportStructure nrs2 WHERE nrs2.ReportStructure_bkey = nrs.ReportStructure_bkey ORDER BY nrs2.SysValidFromDateTime DESC) nrs2