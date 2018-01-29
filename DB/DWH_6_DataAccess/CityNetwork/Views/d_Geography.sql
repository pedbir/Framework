
CREATE VIEW [CityNetwork].[d_Geography]
AS
SELECT	dg.Geography_key
		, dg.Geography_bkey      
		, GeographyName				= ISNULL(dg.GeographyName, 'N/A')
		, Municipality				= ISNULL(SugarEnum_Municipality_key.FieldValue, 'N/A')
		, State						= ISNULL(SugarEnum_State_key.FieldValue, 'N/A')
		, Region					= ISNULL(SugarEnum_Region_key.FieldValue, 'N/A')
FROM	[$(DWH_3_Fact)].Fact.d_Geography dg
INNER JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_Municipality_key
			ON SugarEnum_Municipality_key.SugarEnum_key					= dg.SugarEnum_Municipality_key
INNER JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_State_key
			ON SugarEnum_State_key.SugarEnum_key						= dg.SugarEnum_State_key
INNER JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_Region_key
			ON SugarEnum_Region_key.SugarEnum_key						= dg.SugarEnum_Region_key