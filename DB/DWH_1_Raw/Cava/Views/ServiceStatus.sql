CREATE VIEW [Cava].[ServiceStatus]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , ServiceStatus_bkey = CONVERT(INT, Servicestatus_ID)
	  , Servicestatus = CONVERT(NVARCHAR(50), Servicestatus)
	  , RegardAsActive = CONVERT(BIT, RegardAsActive)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	Servicestatus_ID
	, Servicestatus
	, RegardAsActive
FROM [NDB].[dbo].[Servicestatus]
') oq;