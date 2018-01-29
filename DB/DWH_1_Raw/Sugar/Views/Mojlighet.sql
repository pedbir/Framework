
CREATE VIEW [Sugar].[Mojlighet]
AS
SELECT  SysValidFromDateTime               = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime         = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC            = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC                   = CAST(date_modified AS DATETIME2(0))
        , Mojlighet_bkey                   = CONVERT(NVARCHAR(100), Id)
        , Name                             = CONVERT(NVARCHAR(255), name)
        , Deleted                          = CONVERT(INT, deleted)
        , Shippingaddresspostalcode        = CONVERT(NVARCHAR(20), shipping_address_postalcode)
        , Kundtypc                         = CONVERT(NVARCHAR(100), kundtyp_c)
        , Netadminaddressidc               = CONVERT(INT, netadminaddressid_c)
        , Relevansc                        = CONVERT(NVARCHAR(100), relevans_c)
        , Migreradc                        = CONVERT(NVARCHAR(100), migrerad_c)
        , Tjanstetypc                      = CONVERT(NVARCHAR(100), tjanstetyp_c)
        , Installationsdatumnetadminc      = CONVERT(DATE, installationsdatumnetadmin_c)
        , Latitudec                        = CONVERT(DECIMAL(10, 6), latitude_c)
        , Longitudec                       = CONVERT(DECIMAL(10, 6), longitude_c)
        , Adressmasteridc                  = CONVERT(INT, adressmaster_id_c)
        , Kampanj6maninternetc             = CONVERT(NVARCHAR(100), kampanj_6_man_internet_c)
        , Sexmangratiskampanjtillc         = CONVERT(DATE, sex_man_gratis_kampanj_till_c)
        , Shippingaddressstreetc           = CONVERT(NVARCHAR(255), shipping_address_street_c)
        , Shippingaddressstreetnamec       = CONVERT(NVARCHAR(255), shipping_address_streetname_c)
        , Shippingaddressstreetnoc         = CONVERT(NVARCHAR(10), shipping_address_streetno_c)
        , Shippingaddressentrancec         = CONVERT(NVARCHAR(10), shipping_address_entrance_c)
        , Shippingaddressapartnumberc      = CONVERT(NVARCHAR(10), shipping_address_apartnumber_c)
        , Shippingaddressaltapartnoc       = CONVERT(NVARCHAR(20), shipping_address_alt_apartno_c)
        , Shippingaddresscityc             = CONVERT(NVARCHAR(255), shipping_address_city_c)
        , Shippingaddresscountryc          = CONVERT(NVARCHAR(100), shipping_address_country_c)
        , Fastighetsbeteckningc            = CONVERT(NVARCHAR(255), fastighetsbeteckning_c)
        , Aktivtjanstc                     = CONVERT(NVARCHAR(100), aktiv_tjanst_c)
        , Forvarvadhpc                     = CONVERT(NVARCHAR(100), forvarvad_hp_c)
        , Ipomradeipmojligheteripomradeida = CONVERT(NVARCHAR(100), ip_omrade_ip_mojligheterip_omrade_ida)
		, ContactsIpMojligheter1ContactsIda = CONVERT(NVARCHAR(100), contacts_ip_mojligheter_1contacts_ida)
--select *
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	m.id
	, m.name
    , m.date_entered
    , m.date_modified
    , m.deleted
	, m.shipping_address_postalcode
	, mc.kundtyp_c
	, mc.netadminaddressid_c
	, mc.relevans_c
	, mc.migrerad_c
	, mc.tjanstetyp_c
	, mc.installationsdatumnetadmin_c
	, mc.latitude_c
	, mc.longitude_c
	, mc.adressmaster_id_c
	, mc.kampanj_6_man_internet_c
	, mc.sex_man_gratis_kampanj_till_c
	, mc.shipping_address_street_c
	, mc.shipping_address_streetname_c
	, mc.shipping_address_streetno_c
	, mc.shipping_address_entrance_c
	, mc.shipping_address_apartnumber_c
	, mc.shipping_address_alt_apartno_c
	, mc.shipping_address_city_c
	, mc.shipping_address_country_c
	, mc.fastighetsbeteckning_c
	, mc.aktiv_tjanst_c
	, mc.forvarvad_hp_c
    , om.ip_omrade_ip_mojligheterip_omrade_ida
    , cm.contacts_ip_mojligheter_1contacts_ida
FROM ip_mojligheter m
LEFT JOIN ip_mojligheter_cstm mc on m.id = mc.id_c
LEFT JOIN ip_omrade_ip_mojligheter_c om ON om.ip_omrade_ip_mojligheterip_mojligheter_idb = m.id AND om.deleted = 0
LEFT JOIN contacts_ip_mojligheter_1_c cm ON cm.contacts_ip_mojligheter_1ip_mojligheter_idb = m.id AND cm.deleted = 0 
'   ) AS oq;