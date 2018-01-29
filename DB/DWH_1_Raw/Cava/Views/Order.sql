CREATE VIEW [Cava].[Order]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(Created AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , Order_bkey = CONVERT(INT, OrderID)
	  , CustomerID = CONVERT(INT, CustomerID)
	  , CompanyID = CONVERT(INT, CompanyID)
	  , TypeID = CONVERT(INT, TypeID)
	  , OrderNumber = CONVERT(NVARCHAR(50), Order_number)
	  , NRCC = CONVERT(MONEY, NRCC)
	  , MRCC = CONVERT(MONEY, MRCC)
	  , Currency = CONVERT(NVARCHAR(3), Currency)
	  , InitialTerm = CONVERT(INT, [Initial Term])
	  , ArrivalDate = CONVERT(DATETIME, [Arrival date])
	  , InstallationReady = CONVERT(DATETIME, [Installation ready])
	  , OrderEstimatedMRC = CONVERT(MONEY, OrderEstimatedMRC)
	  , TotalMRCofReplacedOrder = CONVERT(MONEY, TotalMRCofReplacedOrder)
	  , Salesuser = CONVERT(NVARCHAR(255), Salesuser)
	  , OrderadminID = CONVERT(INT, OrderadminID)
	  , AdditionalRenegotiatedMonths = CONVERT(NVARCHAR(50), AdditionalRenegotiatedMonths)
	  , ReasonID = CONVERT(INT, ReasonID)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	OrderID
	, Created
	, CustomerID
	, CompanyID
	, TypeID
	, Order_number
	, NRCC
	, MRCC
	, Currency
	, [Initial Term]
	, [Arrival date]
	, [Installation ready]
	, OrderEstimatedMRC
	, TotalMRCofReplacedOrder
	, Salesuser
	, OrderadminID
	, AdditionalRenegotiatedMonths
	, ReasonID
FROM [NDB].[dbo].[OTABLE]
') oq;