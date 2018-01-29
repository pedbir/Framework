


CREATE VIEW [Sugar].[Enum]
AS
SELECT  SysValidFromDateTime       = CAST(GETUTCDATE() AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(NULL AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , Enum_bkey                = CONVERT(NVARCHAR(100), Id)
        , ModuleName               = CONVERT(NVARCHAR(250), moduleName)
		, ModuleField              = CONVERT(NVARCHAR(250), moduleField)
		, FieldKey		           = CONVERT(NVARCHAR(250), fieldKey)
		, FieldValue               = CONVERT(NVARCHAR(250), fieldValue)
		, Deleted	               = CONVERT(INT, deleted)
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	id
	, moduleName
    , moduleField
    , fieldKey
    , fieldValue
	, deleted
FROM enum;
'   ) AS oq;