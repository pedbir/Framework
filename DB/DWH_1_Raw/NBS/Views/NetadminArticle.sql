
CREATE VIEW [NBS].[NetadminArticle]
AS

SELECT  SysValidFromDateTime		= CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime	= CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC		= CAST(null AS DATETIME2(0))
      , SysModifiedUTC				= CAST(GETUTCDATE() AS DATETIME2(0))
      , NetadminArticle_bkey		= CONVERT(NVARCHAR(50), articlenumber)
	  , Service						= CONVERT(NVARCHAR(50), service)
	  , ServiceType					= CONVERT(NVARCHAR(50), type)
	  , MonthlyPrice				= CONVERT(MONEY, monthlyprice)
	  , StartPrice					= CONVERT(MONEY, startprice)
	  , NoBill						= CONVERT(INT, NoBill)
--select *
FROM    OPENQUERY(NBS, '
SELECT 
	articlenumber
	, service
	, type
	, monthlyprice
	, startprice
	, NoBill
FROM [dbCityNetworks].[dbo].[netadmin_service]
') oq;