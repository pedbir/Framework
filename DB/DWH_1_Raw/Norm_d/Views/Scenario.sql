CREATE VIEW Norm_d.Scenario
AS

SELECT	SysDatetimeDeletedUTC		= CAST(IIF(State = 'Deleted', LastChgDateTime, NULL) AS DATETIME2(0))
		, SysModifiedUTC		= CAST(LastChgDateTime AS DATETIME2(0))
		, SysValidFromDateTime	= CAST(LastChgDateTime AS DATETIME2(0))
		, SysSrcGenerationDateTime = CAST(EnterDateTime AS DATETIME2(0))
		, Scenario_bkey			= Code
		, ScenarioName			= Name
		, ScenarioCategoryCode	= ScenarioCategory_Code
		, ScenarioCategoryName	= ScenarioCategory_Name
		, ScenarioSubCategoryCode = SUBSTRING(code, 5, 100)
FROM	OPENQUERY (MDS, 'SELECT * FROM DWH_0_MDM.[mdm].[Scenario]') oq