







CREATE VIEW [Netadmin].[Adress]
AS

SELECT  SysValidFromDateTime = CAST(adrandrad AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , Adress_bkey = CONVERT(INT, adrid)
	  , adrkomid = CONVERT(INT, adrkomid)
	  , adrgatid = CONVERT(INT, adrgatid)
	  , adrnrid = CONVERT(INT, adrnrid)
	  , adrupgid = CONVERT(INT, adrupgid)
	  , adrpostid = CONVERT(INT, adrpostid)
	  , adrortid = CONVERT(INT, adrortid)
	  , ipo_installed_date = CONVERT(DATE, ipo_installed_date)
	  , adrkodid1 = CONVERT(INT, adrkodid1)
	  , adrkodid2 = CONVERT(INT, adrkodid2)
	  , adrkodid3 = CONVERT(INT, adrkodid3)
	  , adrkodid4 = CONVERT(INT, adrkodid4)
	  , adrkodid5 = CONVERT(INT, adrkodid5)
	  , adridentitet = CONVERT(NVARCHAR(100), adridentitet)
--select *
FROM    OPENQUERY(NETADMIN, '
SELECT 
	adrid
	, adrandrad
	, adrkomid
	, adrgatid
	, adrnrid
	, adrupgid
	, adrpostid
	, adrortid
	, ipo_installed_date
	, adrkodid1
	, adrkodid2
	, adrkodid3
	, adrkodid4
	, adrkodid5
	, adridentitet
FROM adress.adress
') oq;