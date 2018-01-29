







CREATE VIEW [Sugar].[Affarsmojlighet]
AS
SELECT  SysValidFromDateTime		= CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime	= CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC		= CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC			= CAST(GETUTCDATE() AS DATETIME2(0))
        , Affarsmojlighet_bkey		= CONVERT(NVARCHAR(100), Id)
        , Name						= CONVERT(NVARCHAR(255), name)
        , Deleted					= CONVERT(INT, deleted)
        , OrdernummerCavaC			= CONVERT(NVARCHAR(255), ordernummer_cava_c)
		, AffarstypC				= CONVERT(NVARCHAR(50), affarstyp_c)
--select *
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	o.id
	, o.name
    , o.date_entered
    , o.date_modified
    , o.deleted
	, oc.affarstyp_c
	, oc.ordernummer_cava_c
FROM opportunities o
LEFT JOIN opportunities_cstm oc on o.id = oc.id_c
'   ) AS oq;