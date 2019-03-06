

CREATE VIEW Fact.f_BridgeReportStructure
AS

SELECT  nbrs.SysDatetimeDeletedUTC
       ,nbrs.SysModifiedUTC
       ,nbrs.SysSrcGenerationDateTime
       ,nbrs.SysValidFromDateTime
       ,BridgeReportStructure_key = nbrs.BridgeReportStructure_bkey
       ,nbrs.GLAccountLegalEntity_bkey
       ,nbrs.ReportStructure_bkey
       ,ngale.GLAccountLegalEntity_key
       ,nrs.ReportStructure_key
FROM    (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY nbrs.BridgeReportStructure_bkey ORDER BY nbrs.SysValidFromDateTime DESC) FROM Norm.n_BridgeReportStructure nbrs) nbrs
OUTER APPLY (SELECT TOP 1 ngale.GLAccountLegalEntity_key FROM Norm.n_GLAccountLegalEntity ngale WHERE ngale.GLAccountLegalEntity_bkey = nbrs.GLAccountLegalEntity_bkey ORDER BY ngale.SysValidFromDateTime DESC) ngale
OUTER APPLY (SELECT TOP 1 nrs.ReportStructure_key FROM Norm.n_ReportStructure nrs WHERE nrs.ReportStructure_bkey = nbrs.ReportStructure_bkey ORDER BY nrs.SysValidFromDateTime DESC) nrs
WHERE nbrs._isFirst = 1 AND nbrs.BridgeReportStructure_bkey <> '-1'