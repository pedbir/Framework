CREATE VIEW Finance.d_Analysis
AS
SELECT FinanceAnalysis_key      
      ,AnalysisCode = FinanceAnalysisCode
      ,Analysis = FinanceAnalysisName      
FROM [Fact].[d_FinanceAnalysis]