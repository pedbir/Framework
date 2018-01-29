
CREATE VIEW [CityNetwork].[f_Penetration]
AS
SELECT		Date						= CAST(CAST(fp.Calendar_key AS NVARCHAR(8)) AS DATE)
			, fp.Opportunity_key
			, CustomerCategory_key		= ISNULL(do.CustomerCategory_key, -1)
			, fp.Area_key
			, fp.Project_key
			, fp.SalesOrder_key
			, fp.Customer_key
			, fp.Access_key
			, fp.Address_key
			, fp.Geography_key
			, fp.Employee_SalesResponsible_key
			, fp.NoOfHP
			, fp.NoOfHC
			, fp.NoOfInstalled
			, fp.NoOfBacklog
			, Scenario_bkey				= LEFT(CAST(fp.Calendar_key AS NVARCHAR(8)), 4) + 'A'
			, PlanningAmount			=	0
			, Phase_bkey				= 'N/A'
FROM		[$(DWH_3_Fact)].Fact.f_Penetration	fp
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_Opportunity	do
			ON do.Opportunity_key	= fp.Opportunity_key
WHERE		fp.SysDatetimeDeletedUTC IS NULL
UNION ALL
SELECT	Date							= CAST(CAST(fp.Calendar_key AS NVARCHAR(8)) AS DATE)
		, Opportunity_key				= -1
		, fp.CustomerCategory_key
		, Area_key						= -1
		, Project_key					= -1
		, SalesOrder_key				= -1
		, Customer_key					= -1
		, Access_key					= -1
		, Address_key					= -1
		, Geography_key					= -1
		, Employee_SalesResponsible_key = -1
		, NoOfHP						= 0
		, NoOfHC						= 0
		, NoOfInstalled					= 0
		, NoOfBacklog					= 0
		, fp.Scenario_bkey
		, PlanningAmount				= fp.Amount
		, fp.Phase_bkey
FROM	[$(DWH_3_Fact)].Fact.f_Planning fp