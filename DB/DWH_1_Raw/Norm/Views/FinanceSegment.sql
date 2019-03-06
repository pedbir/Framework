CREATE VIEW Norm.FinanceSegment
AS
SELECT  SysValidFromDateTime
       ,SysSrcGenerationDateTime
       ,SysDatetimeDeletedUTC
       ,SysModifiedUTC
       ,FinanceSegment_bkey              = CAST(Segment_bkey AS NVARCHAR(100))
       ,FinanceSegmentName               = CAST(SegmentName AS NVARCHAR(250))
       ,SourceSystemName                 = CAST(SourceSystemName AS NVARCHAR(250))
       ,SourceSystemID                   = CAST(SourceSystemID AS INT)
       ,FinanceSegmentGoldenCode         = CAST(SegmentGoldenCode AS NVARCHAR(100))
       ,FinanceSegmentGoldenName         = CAST(SegmentGoldenName AS NVARCHAR(250))
       ,FinanceSegmentGoldenID           = CAST(SegmentGoldenID AS INT)
       ,FinanceSegmentGoldenCategoryCode = CAST(ISNULL(SegmentGoldenCategoryCode, 'N/A') AS NVARCHAR(100))
       ,FinanceSegmentGoldenCategoryName = CAST(ISNULL(SegmentGoldenCategoryName, 'N/A') AS NVARCHAR(250))
FROM   OPENQUERY (MDS, '
SELECT    SysValidFromDateTime      = (SELECT MAX(v.LastChgDateTime) FROM (VALUES (sg.LastChgDateTime), (sl.LastChgDateTime )) v (LastChgDateTime) ) 
         ,SysSrcGenerationDateTime  = CAST(sl.EnterDateTime AS DATETIME2(0))
         ,SysDatetimeDeletedUTC     = CAST(IIF(sg.State = ''Deleted'', sl.LastChgDateTime, NULL) AS DATETIME2(0))
         ,SysModifiedUTC            = CAST(GETUTCDATE() AS DATETIME2(0))
         ,Segment_bkey              = sl.Code
         ,SegmentName               = sl.Name
         ,SourceSystemName          = sl.SourceSystem_Name
         ,SourceSystemID            = sl.SourceSystem_ID
         ,SegmentGoldenCode         = sl.SegmentGolden_Code
         ,SegmentGoldenName         = sl.SegmentGolden_Name
         ,SegmentGoldenID           = sl.SegmentGolden_ID
         ,SegmentGoldenCategoryCode = sg.CategoryCode
         ,SegmentGoldenCategoryname = sg.Category
FROM      MDS.mdm.SegmentLeaf   sl
LEFT JOIN MDS.mdm.SegmentGolden sg ON sl.SegmentGolden_ID = sg.ID
' ) oq
GO
