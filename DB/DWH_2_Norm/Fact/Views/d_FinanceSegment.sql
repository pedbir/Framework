CREATE VIEW Fact.d_FinanceSegment
AS
SELECT      nfs.FinanceSegment_key
           ,nfs.SysDatetimeDeletedUTC
           ,nfs2.SysModifiedUTC
           ,nfs.SysIsInferred
           ,nfs.SysValidFromDateTime
           ,nfs.SysSrcGenerationDateTime
           ,nfs.FinanceSegment_bkey
           ,nfs2.FinanceSegmentGoldenCode
           ,nfs2.FinanceSegmentGoldenName
           ,nfs2.FinanceSegmentGoldenID
           ,nfs2.FinanceSegmentGoldenCategoryCode
           ,nfs2.FinanceSegmentGoldenCategoryName
FROM        Norm.n_FinanceSegment nfs
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceSegment nfs2 WHERE nfs2.FinanceSegment_bkey = nfs.FinanceSegment_bkey ORDER BY nfs2.SysValidFromDateTime DESC) nfs2