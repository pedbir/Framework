CREATE VIEW Norm_d.Address
AS

SELECT	SysValidFromDateTime			
		, SysSrcGenerationDateTime		
		, SysDatetimeDeletedUTC			
		, SysModifiedUTC				 
		, Address_bkey					= CONVERT(NVARCHAR(100), LM90A_bkey)
		, SysSource						= UPPER('AddressMaster')
		, StreetName					= [AdrOmrade]
		, StreetNumber					= [AdrPlats]
		, PostalCode					= [PostNr]
		, PostalCity					= [PostOrt]
		, CountryCode					= [LandsKod] 
		, Latitude						= [Latitud]
		, Longitude						= [Longitud]
		, Estate_bkey					= [FNR]
FROM	AddressMaster_RawTyped.r_LM90A
WHERE	LM90A_bkey <> -1

UNION ALL

SELECT	SysValidFromDateTime			= rm.SysValidFromDateTime
		, SysSrcGenerationDateTime		= rm.SysSrcGenerationDateTime
		, SysDatetimeDeletedUTC			= CASE WHEN rm.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
		, SysModifiedUTC				= rm.SysModifiedUTC
		, Address_bkey					= rm.Mojlighet_bkey
		, SysSource						= UPPER('Sugar')
		, StreetName					= rm.Shippingaddressstreetnamec
		, StreetNumber					= rm.Shippingaddressstreetnoc
		, PostalCode					= rm.Shippingaddresspostalcode
		, PostalCity					= rm.Shippingaddresscityc
		, CountryCode					= rm.Shippingaddresscountryc
		, Latitude						= rm.Latitudec
		, Longitude						= rm.Longitudec
		, Estate_bkey					= -1
FROM	Sugar_RawTyped.r_Mojlighet rm
WHERE	rm.Mojlighet_bkey <> '-1'
AND		ISNULL(Adressmasteridc, '-1') = '-1'
AND rm.Mojlighet_bkey = '1002ff96-18b4-c058-ceff-59c4ee57e0c5'

UNION ALL

SELECT	SysValidFromDateTime			= lp.SysValidFromDateTime
		, SysSrcGenerationDateTime		= lp.SysSrcGenerationDateTime
		, SysDatetimeDeletedUTC			= CASE WHEN lp.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
		, SysModifiedUTC				= lp.SysModifiedUTC
		, Address_bkey					= lp.Leveranspunkt_bkey
		, SysSource						= UPPER('Sugar')
		, StreetName					= lp.Shippingaddressstreetnamec
		, StreetNumber					= lp.Shippingaddressstreetnoc
		, PostalCode					= lp.Shippingaddresspostalcodec
		, PostalCity					= lp.Shippingaddresscityc
		, CountryCode					= lp.Shippingaddresscountryc
		, Latitude						= lp.Latitudec
		, Longitude						= lp.Longitudec
		, Estate_bkey					= -1
FROM	Sugar_RawTyped.r_Leveranspunkt lp
WHERE	lp.Leveranspunkt_bkey <> '-1'
AND		ISNULL(Adressmasteridc, '-1') = '-1'
AND lp.Leveranspunkt_bkey = '1002ff96-18b4-c058-ceff-59c4ee57e0c5'