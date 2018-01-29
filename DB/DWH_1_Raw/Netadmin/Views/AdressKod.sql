









CREATE VIEW [Netadmin].[AdressKod]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , AdressKod_bkey = CONVERT(INT, kodid)
	  , kodnamn = CONVERT(NVARCHAR(100), kodnamn)
--select *
FROM    OPENQUERY(NETADMIN, '
SELECT 
	kodid
	, kodnamn
FROM adress.adrkod
') oq;