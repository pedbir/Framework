CREATE VIEW Finance.f_BridgeReportStructure
AS
SELECT fbrs.BridgeReportStructure_key      
      ,fbrs.GLAccountLegalEntity_key
      ,fbrs.ReportStructure_key 
FROM Fact.f_BridgeReportStructure fbrs