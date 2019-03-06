


CREATE VIEW Fact.d_UcapLkp
AS
SELECT nul.UcapLkp_key
      ,nul1.SysDatetimeDeletedUTC
      ,nul1.SysModifiedUTC
      ,nul.SysValidFromDateTime
      ,nul.SysSrcGenerationDateTime
      ,nul.UcapLkp_bkey
      ,UcapLkpId = ISNULL(nul1.UcapLkpId, -1)
	  ,UcapLkpDomain = ISNULL(nul1.UcapLkpDomain, 'N/A')
      ,UcapLkpValue  = ISNULL(nul1.UcapLkpValue, 'N/A')
FROM Norm.n_UcapLkp nul
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_UcapLkp nul1 WHERE nul1.UcapLkp_bkey = nul.UcapLkp_bkey ORDER BY nul1.SysValidFromDateTime DESC) nul1