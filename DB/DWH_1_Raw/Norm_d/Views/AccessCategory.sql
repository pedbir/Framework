CREATE VIEW Norm_d.AccessCategory
AS
SELECT  SysValidFromDateTime					= CAST(SysValidFromDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime				= CAST('1900-01-01' AS DATETIME2(0))
        , SysDatetimeDeletedUTC					= CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC						= CAST(GETUTCDATE() AS DATETIME2(0))
        , AccessCategory_bkey						= AdressKod_bkey
		, AccessCategory							= kodnamn
FROM    Netadmin_RawTyped.r_AdressKod
WHERE AdressKod_bkey <> -1