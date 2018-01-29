

CREATE VIEW [CityNetwork].[d_SalesOrder]
AS
SELECT		dso.SalesOrder_key
			, dso.SalesOrder_bkey
FROM		[$(DWH_3_Fact)].Fact.d_SalesOrder dso