
CREATE VIEW Finance.d_Segment
AS
SELECT  FinanceSegment_key
       ,SegmentDetailCode = FinanceSegmentGoldenCode
       ,SegmentDetail     = FinanceSegmentGoldenName
       ,SegmentCode       = FinanceSegmentGoldenCategoryCode
       ,Segment           = FinanceSegmentGoldenCategoryName
FROM    Fact.d_FinanceSegment