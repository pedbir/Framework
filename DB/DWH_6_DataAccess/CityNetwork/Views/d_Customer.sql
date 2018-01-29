CREATE VIEW CityNetwork.d_Customer
AS

SELECT	dc.Customer_key
		, Age				= ISNULL(dc.Age, 0)
		, Gender			= ISNULL(dc.Gender, 'N/A') 
FROM	[$(DWH_3_Fact)].Fact.d_Customer dc