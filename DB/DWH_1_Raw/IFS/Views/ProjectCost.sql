




CREATE VIEW [IFS].[ProjectCost]
AS
SELECT  SysValidFromDateTime       = CAST(GETUTCDATE() AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(NULL AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , ProjectCost_bkey         = CAST(CONVERT(NVARCHAR(100), PROJECT_ID) + '#' + CONVERT(NVARCHAR(100), CONTROL_CATEGORY) AS NVARCHAR(250))
        , ProjectID		           = CONVERT(NVARCHAR(100), PROJECT_ID)
		, ControlCategory          = CONVERT(NVARCHAR(100), CONTROL_CATEGORY)
		, Estimated		           = CONVERT(MONEY, ESTIMATED)
		, Baseline		           = CONVERT(MONEY, BASELINE)
		, Used			           = CONVERT(MONEY, USED)
		, Áctual		           = CONVERT(MONEY, ACTUAL)
FROM    OPENQUERY (IFSPROD, '
SELECT 	PROJECT_ID
	, CONTROL_CATEGORY
	, ESTIMATED
	, BASELINE
	, USED
	, ACTUAL
FROM IFSAPP.PROJ_CON_DET_SUM_COST_PROJECT
'   ) AS oq;