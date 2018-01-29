CREATE VIEW [Cava].[Service]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , Service_bkey = CONVERT(INT, ServiceID)
	  , Name = CONVERT(NVARCHAR(50), Name)
	  , ServiceSwe = CONVERT(NVARCHAR(50), Service_swe)
	  , ServiceEng = CONVERT(NVARCHAR(50), Service_eng)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	ServiceID
	, Name
	, Service_swe
	, Service_eng
FROM [NDB].[dbo].[Service]
') oq;