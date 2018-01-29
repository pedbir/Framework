CREATE VIEW [Norm_d].[ServiceProvider]
AS
SELECT  SysValidFromDateTime					= CAST(SysValidFromDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime				= CAST('1900-01-01' AS DATETIME2(0))
        , SysDatetimeDeletedUTC					= CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC						= CAST(GETUTCDATE() AS DATETIME2(0))
        , ServiceProvider_bkey					= Isp_bkey
		, ServiceProvider						= ispnamn
FROM    Netadmin_RawTyped.r_Isp