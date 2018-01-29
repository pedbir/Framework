CREATE VIEW CityNetwork.d_CustomerCategory
AS

SELECT	dcc.CustomerCategory_key	
		, CustomerCategory			= ISNULL(dcc.CustomerCategory, 'N/A')
		, CustomerCategoryGroup		= ISNULL(dcc.CustomerCategory, 'N/A')
FROM	[$(DWH_3_Fact)].Fact.d_CustomerCategory dcc