CREATE VIEW [Cava].[OrderService]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(Created AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , OrderService_bkey = CONVERT(INT, OrderServiceID)
	  , OrderID = CONVERT(INT, OrderID)
	  , ServiceID = CONVERT(INT, ServiceID)
	  , Currency = CONVERT(NVARCHAR(3), Currency)
	  , NRCC = CONVERT(MONEY, NRCC)
	  , MRCC = CONVERT(MONEY, MRCC)
	  , InstallationReady = CONVERT(DATETIME, [Installation ready])
	  , FirstInvoiceDate = CONVERT(DATETIME, [1st invoice date])
	  , LastInvoiceDate = CONVERT(DATETIME, [Last Invoice date])
	  , TerminationNoticeDate = CONVERT(DATETIME, TerminationNoticeDate)
	  , ReplaceNoticeDate = CONVERT(DATETIME, ReplaceNoticeDate)
	  , EndOfService = CONVERT(DATETIME, EndOfService)
	  , ServicestatusID = CONVERT(INT, Servicestatus_ID)
	  , SLA = CONVERT(NVARCHAR(50), SLA)
	  , Cap = CONVERT(INT, Cap)
	  , UnitID = CONVERT(INT, UnitID)
	  , ConnectionID = CONVERT(NVARCHAR(50), ConnectionID)
	  , IsReneg = CONVERT(BIT, isReneg)
	  , SiteID = CONVERT(INT, SiteID)
	  , CustomerServiceName = CONVERT(NVARCHAR(100), CustomerServiceName)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	OrderServiceID
	, Created
	, OrderID
	, ServiceID
	, Currency
	, NRCC
	, MRCC
	, [Installation ready]
	, [1st invoice date]
	, [Last Invoice date]
	, TerminationNoticeDate
	, ReplaceNoticeDate
	, EndOfService
	, Servicestatus_ID
	, SLA
	, Cap
	, UnitID
	, ConnectionID
	, isReneg
	, SiteID
	, CustomerServiceName
FROM [NDB].[dbo].[OrderService]
') oq;