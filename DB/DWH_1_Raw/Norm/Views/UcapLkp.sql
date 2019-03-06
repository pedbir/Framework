CREATE VIEW Norm.UcapLkp
AS

SELECT rul.SysDatetimeDeletedUTC
      ,rul.SysModifiedUTC
      ,rul.SysValidFromDateTime
      ,rul.SysSrcGenerationDateTime
      ,rul.UcapLkp_bkey
      ,rul.UcapLkpId
      ,rul.UcapLkpDomain
      ,rul.UcapLkpValue 
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY rul.UcapLkp_bkey ORDER BY rul.SysValidFromDateTime DESC) FROM UCAP_RawTyped.r_UcapLkp rul) rul
WHERE rul._isFirst = 1