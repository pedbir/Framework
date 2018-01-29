
CREATE VIEW [Netadmin].[Abonnemang]
AS

SELECT  SysValidFromDateTime = CAST(abochanged AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(NULL AS DATETIME2(0))
      , SysModifiedUTC = CAST(abochanged AS DATETIME2(0))
      , Abonnemang_bkey = CONVERT(INT, aboid)
	  , abostartdat = CONVERT(DATE, CONVERT(VARCHAR(8), CONVERT(INT, abostartdat)))
	  , aboinkopldat = CONVERT(DATE, CONVERT(VARCHAR(8), CONVERT(INT, NULLIF(aboinkopldat, 0))))
	  , aboadressdbid = CONVERT(INT, aboadressdbid)
	  , abotmpid = CONVERT(INT, abotmpid)
	  , aboartnr = CONVERT(NVARCHAR(50), aboartnr)
	  , abostartartnr = CONVERT(NVARCHAR(50), abostartartnr)
	  , aboisp = CONVERT(INT, aboisp)
	  , aboansvarig = CONVERT(NVARCHAR(50), aboansvarig)
--select *
FROM    OPENQUERY(NETADMIN, '
SELECT 
	aboid
	, abochanged
	, abostartdat
	, aboinkopldat
	, aboadressdbid
	, abotmpid
	, aboartnr
	, abostartartnr
	, aboisp
	, aboansvarig
FROM netadmin.abonnemang
WHERE abotmpid <> 2585
') oq;