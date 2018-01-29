



CREATE VIEW [Norm_d].[Service]
AS
SELECT  SysValidFromDateTime         
        , SysSrcGenerationDateTime		
        , SysDatetimeDeletedUTC					
        , SysModifiedUTC					
		, Service_bkey							= Service_bkey
		, ServiceNameShort						= Name
		, ServiceName							= ServiceEng
FROM    Cava_RawTyped.r_Service o
WHERE   Service_key <> '-1'