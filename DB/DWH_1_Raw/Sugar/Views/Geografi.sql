






CREATE VIEW Sugar.Geografi
AS
SELECT  SysValidFromDateTime       = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , Geografi_bkey            = CONVERT(NVARCHAR(100), Id)
        , Name                     = CONVERT(NVARCHAR(255), name)
        , Deleted                  = CONVERT(INT, deleted)
        , Kommunc                 = CONVERT(NVARCHAR(100), kommun_c)
        , Lanc                    = CONVERT(NVARCHAR(100), lan_c)
        , Regionc                 = CONVERT(NVARCHAR(100), region_c)
        , Stadc                   = CONVERT(NVARCHAR(255), stad_c)
        , Stadsnatc               = CONVERT(NVARCHAR(100), stadsnat_c)
--select *
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	g.id
	, g.name
    , g.date_entered
    , g.date_modified
    , g.deleted

	, gc.kommun_c
	, gc.lan_c
	, gc.region_c
	, gc.stad_c
	, gc.stadsnat_c
FROM ip_geografi g
LEFT JOIN ip_geografi_cstm gc on g.id = gc.id_c
'   ) AS oq;