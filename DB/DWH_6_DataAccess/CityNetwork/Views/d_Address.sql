

CREATE VIEW [CityNetwork].[d_Address]
AS

SELECT  da.Address_key
		, da.Address_bkey
		, StreetName			= ISNULL(da.StreetName, 'N/A')
		, StreetNumber			= ISNULL(da.StreetNumber, 'N/A')
		, PostalCode			= ISNULL(da.PostalCode, 'N/A')
		, PostalCity			= ISNULL(da.PostalCity, 'N/A')
		, CountryCode			= ISNULL(da.CountryCode, 'N/A')
		, Latitude				= ISNULL(da.Latitude, 0)
		, Longitude				= ISNULL(da.Longitude, 0)
FROM	[$(DWH_3_Fact)].Fact.d_Address da