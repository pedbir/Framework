CREATE VIEW CityNetwork.d_Project
AS

SELECT	dp.Project_key
		, ProjectNo			= ISNULL(dp.Project_bkey, 'N/A')   
		, ProjectName		= ISNULL(dp.ProjectName, 'N/A')
FROM	[$(DWH_3_Fact)].Fact.d_Project dp