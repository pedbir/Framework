



CREATE VIEW [IFS].[Project]
AS
SELECT  SysValidFromDateTime       = CAST(DATE_MODIFIED AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(DATE_CREATED AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , Project_bkey             = CONVERT(NVARCHAR(100), PROJECT_ID)
        , Name			           = CONVERT(NVARCHAR(250), NAME)
		, ProgramID	               = CONVERT(NVARCHAR(100), PROGRAM_ID)
		, Category1ID              = CONVERT(NVARCHAR(100), CATEGORY1_ID)
		, Category2ID              = CONVERT(NVARCHAR(100), CATEGORY2_ID)
		, ObjState	               = CONVERT(NVARCHAR(100), OBJSTATE)
		, PlanFinish               = CONVERT(DATETIME, PLAN_FINISH)
		, CloseDate	               = CONVERT(DATETIME, CLOSE_DATE)
		, NumOfHP	               = CONVERT(INT, CF$_NUM_OF_HP)
		, NumOfHC	               = CONVERT(INT, CF$_NUM_OF_HC)
		, NumOfHCAM	               = CONVERT(INT, CF$_NUM_OF_HC_AM)
		, NumOfMDU	               = CONVERT(INT, CF$_NUM_OF_MDU)
		, NumOfCORP	               = CONVERT(INT, CF$_NUM_OF_CORP)
FROM    OPENQUERY (IFSPROD, '
SELECT 	PROJECT_ID
	, DATE_CREATED
    , DATE_MODIFIED
    , NAME
	, PROGRAM_ID
	, CATEGORY1_ID
    , CATEGORY2_ID
    , OBJSTATE
    , PLAN_FINISH
	, CLOSE_DATE
	, COMPANY
	, CF$_NUM_OF_HP
	, CF$_NUM_OF_HC
	, CF$_NUM_OF_HC_AM
	, CF$_NUM_OF_MDU
	, CF$_NUM_OF_CORP 
FROM IFSAPP.PROJECT_CFV
'   ) AS oq;