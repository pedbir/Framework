CREATE VIEW Finance.d_ReportStructure
AS
SELECT drs.ReportStructure_key
      ,drs.ReportStructure_bkey
      ,drs.ReportStructureLvl1Code
      ,drs.ReportStructureLvl1Name
      ,drs.ReportStructureLvl2Code
      ,drs.ReportStructureLvl2Name
      ,drs.ReportStructureLvl3Code
      ,drs.ReportStructureLvl3Name 
FROM Fact.d_ReportStructure drs