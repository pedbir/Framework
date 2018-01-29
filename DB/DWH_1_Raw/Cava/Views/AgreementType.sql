CREATE VIEW [Cava].[AgreementType]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(null AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , AgreementType_bkey = CONVERT(INT, TypeID)
	  , AgreementType = CONVERT(NVARCHAR(50), AgreementType)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	TypeID
	, AgreementType
FROM [NDB].[dbo].[Agreement_Type]
') oq;