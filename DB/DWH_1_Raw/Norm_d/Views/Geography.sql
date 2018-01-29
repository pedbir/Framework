

CREATE VIEW [Norm_d].[Geography]
AS
SELECT  SysValidFromDateTime				= CAST(g.SysValidFromDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime
        , SysDatetimeDeletedUTC				= CAST(CASE WHEN g.Deleted = 1 THEN g.SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
        , SysModifiedUTC					
        , Geography_bkey					= g.Geografi_bkey
        , GeographyName						= g.Name
		, SugarEnum_Municipality_bkey		= UPPER(LTRIM(RTRIM(ISNULL('IP_Geografi#kommun_c#' + NULLIF(g.Kommunc, ''), '-1'))))
		, SugarEnum_State_bkey				= UPPER(LTRIM(RTRIM(ISNULL('IP_Geografi#lan_c#' + NULLIF(g.Lanc, ''), '-1'))))
		, SugarEnum_Region_bkey				= UPPER(LTRIM(RTRIM(ISNULL('IP_Geografi#region_c#' + NULLIF(g.Regionc, ''), '-1'))))
FROM    Sugar_RawTyped.r_Geografi g
WHERE	Geografi_bkey <> '-1'