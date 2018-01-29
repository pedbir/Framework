



CREATE VIEW [Norm_d].[ServiceStatus]
AS
SELECT  SysValidFromDateTime         
        , SysSrcGenerationDateTime		
        , SysDatetimeDeletedUTC					
        , SysModifiedUTC					
		, ServiceStatus_bkey					= ServiceStatus_bkey
		, ServiceStatus							= ServiceStatus
		, RegardAsActive						= RegardAsActive
FROM    Cava_RawTyped.r_ServiceStatus
WHERE   ServiceStatus_key <> '-1'