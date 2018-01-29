


CREATE VIEW [AddressMaster].[LM90A]
AS

SELECT  SysValidFromDateTime			= CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime		= CAST(GETUTCDATE() AS DATETIME2(0))
      , SysDatetimeDeletedUTC			= CAST(NULL AS DATETIME2(0))
      , SysModifiedUTC					= CAST(GETUTCDATE() AS DATETIME2(0))
      , LM90A_bkey						= CONVERT(INT, ID)
	  , AdrOmrade						= CONVERT(NVARCHAR(50), ADROMRADE)
	  , AdrPlats						= CONVERT(NVARCHAR(50), ADRPLATS)
	  , PostNr							= CONVERT(NVARCHAR(20), POSTNR)
	  , PostOrt							= CONVERT(NVARCHAR(50), POSTORT)
	  , LandsKod						= CONVERT(NVARCHAR(50), LANDSKOD)
	  , Latitud							= CONVERT(DECIMAL(11,6), LATITUD)
	  , Longitud						= CONVERT(DECIMAL(11,6), LONGITUD)
	  , FNR								= CONVERT(NVARCHAR(9), FNR)
--select *
FROM    OPENQUERY(Cava, '
SELECT ADRPLATS
      ,ADROMRADE
      ,POSTNR
      ,POSTORT
	  ,LANDSKOD
      ,LATITUD
      ,LONGITUD
      ,FNR
      ,ID
  FROM [AddressMaster].[dbo].[LM_90A]
') oq;