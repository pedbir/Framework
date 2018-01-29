









CREATE VIEW [Netadmin].[Isp]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , Isp_bkey = CONVERT(INT, ispid)
	  , ispnamn = CONVERT(NVARCHAR(50), ispnamn)
--select *
FROM    OPENQUERY(NETADMIN, '
SELECT 
	ispid
	, ispnamn
FROM netadmin.isp
') oq;