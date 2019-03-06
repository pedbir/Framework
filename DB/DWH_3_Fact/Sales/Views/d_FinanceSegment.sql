CREATE VIEW Sales.d_FinanceSegment
AS

SELECT  dfs.FinanceSegment_key
       ,FinanceSegmentCode       = dfs.FinanceSegmentGoldenCategoryCode
       ,FinanceSegment           = dfs.FinanceSegmentGoldenCategoryName
       ,FinanceSegmentDetailCode = dfs.FinanceSegmentGoldenCode
       ,FinanceSegmentDetail     = dfs.FinanceSegmentGoldenName
FROM    Fact.d_FinanceSegment dfs
GO
