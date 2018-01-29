


CREATE VIEW [Fact].[d_Address]
AS

SELECT	Address_key
		, SysSrcGenerationDateTime
        , SysValidFromDateTime
        , SysModifiedUTC
        , SysDatetimeDeletedUTC
        , Address_bkey
		, StreetName
		, StreetNumber
		, PostalCode
		, PostalCity
		, CountryCode
		, Latitude
		, Longitude
		, Estate_bkey
FROM    Norm.n_Address