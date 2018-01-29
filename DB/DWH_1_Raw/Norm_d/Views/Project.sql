
CREATE VIEW [Norm_d].[Project]
AS
SELECT  SysValidFromDateTime					= CAST(SysValidFromDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime				= CAST('1900-01-01' AS DATETIME2(0))
        , SysDatetimeDeletedUTC					= CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC						= CAST(GETUTCDATE() AS DATETIME2(0))
        , Project_bkey							= Project_bkey
		, ProjectName							= Name
		, ProgramID								= ProgramID
		, Category1ID							= Category1ID
		, Category2ID							= Category2ID
		, PlanFinish							= PlanFinish
		, CloseDate								= CloseDate
		, NumOfHP								= NumOfHP
		, NumOfHC								= NumOfHC
		, NumOfHCAM								= NumOfHCAM
		, NumOfMDU								= NumOfMDU
		, NumOfCORP								= NumOfCORP
FROM    IFS_RawTyped.r_Project