

CREATE VIEW Sugar.Leveranspunkt
AS
SELECT  SysValidFromDateTime                                   = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime                             = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC                                = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC                                       = CAST(GETUTCDATE() AS DATETIME2(0))
        , Leveranspunkt_bkey                                   = CONVERT(NVARCHAR(100), Id)
        , Name                                                 = CONVERT(NVARCHAR(255), name)
        , Deleted                                              = CONVERT(INT, deleted)
        , Netadminaddressidc                                   = CONVERT(NVARCHAR(255), netadminaddressid_c)
        , Relevansc                                            = CONVERT(NVARCHAR(100), relevans_c)
        , Migreradc                                            = CONVERT(NVARCHAR(100), migrerad_c)
        , Tjanstetypc                                          = CONVERT(NVARCHAR(100), tjanstetyp_c)
        , Installationsdatumnetadminc                          = CONVERT(DATE, installationsdatumnetadmin_c)
        , Latitudec                                            = CONVERT(DECIMAL(10, 6), latitude_c)
        , Longitudec                                           = CONVERT(DECIMAL(10, 6), longitude_c)
        , Adressmasteridc                                      = CONVERT(INT, adressmaster_id_c)
        , Kampanj6maninternetc                                 = CONVERT(NVARCHAR(100), kampanj_6_man_internet_c)
        , Sexmangratiskampanjtillc                             = CONVERT(DATE, sex_man_gratis_kampanj_till_c)
        , Bostadsnatfinnsc                                     = CONVERT(NVARCHAR(100), bostadsnat_finns_c)
        , Shippingaddressstreetc                               = CONVERT(NVARCHAR(255), shipping_address_street_c)
        , Shippingaddresspostalcodec                           = CONVERT(NVARCHAR(20), shipping_address_postalcode_c)
        , Shippingaddressstreetnamec                           = CONVERT(NVARCHAR(255), shipping_address_streetname_c)
        , Shippingaddressstreetnoc                             = CONVERT(NVARCHAR(20), shipping_address_streetno_c)
        , Shippingaddressentrancec                             = CONVERT(NVARCHAR(20), shipping_address_entrance_c)
        , Shippingaddressapartnumberc                          = CONVERT(NVARCHAR(20), shipping_address_apartnumber_c)
        , Shippingaddressaltapartnoc                           = CONVERT(NVARCHAR(20), shipping_address_alt_apartno_c)
        , Shippingaddresscityc                                 = CONVERT(NVARCHAR(100), shipping_address_city_c)
        , Shippingaddresscountryc                              = CONVERT(NVARCHAR(100), shipping_address_country_c)
        , Fastighetsbeteckningc                                = CONVERT(NVARCHAR(255), fastighetsbeteckning_c)
        , Aktivtjanstc                                         = CONVERT(NVARCHAR(100), aktiv_tjanst_c)
        , Gruppanslutningc                                     = CONVERT(NVARCHAR(255), gruppanslutning_c)
        , Ipleveransobjektipleveranspunkteripleveransobjektida = CONVERT(NVARCHAR(100), ip_leveransobjekt_ip_leveranspunkterip_leveransobjekt_ida)
--select *
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	l.id
	, l.name
    , l.date_entered
    , l.date_modified
    , l.deleted
	, lc.netadminaddressid_c
	, lc.relevans_c
	, lc.migrerad_c
	, lc.tjanstetyp_c
	, lc.installationsdatumnetadmin_c
	, lc.latitude_c
	, lc.longitude_c
	, lc.adressmaster_id_c
	, lc.kampanj_6_man_internet_c
	, lc.sex_man_gratis_kampanj_till_c
	, lc.bostadsnat_finns_c
	, lc.shipping_address_street_c
	, lc.shipping_address_postalcode_c
	, lc.shipping_address_streetname_c
	, lc.shipping_address_streetno_c
	, lc.shipping_address_entrance_c
	, lc.shipping_address_apartnumber_c
	, lc.shipping_address_alt_apartno_c
	, lc.shipping_address_city_c
	, lc.shipping_address_country_c
	, lc.fastighetsbeteckning_c
	, lc.aktiv_tjanst_c
	, lc.gruppanslutning_c
    , ll.ip_leveransobjekt_ip_leveranspunkterip_leveransobjekt_ida
FROM ip_leveranspunkter l
LEFT JOIN ip_leveranspunkter_cstm lc on l.id = lc.id_c
LEFT JOIN ip_leveransobjekt_ip_leveranspunkter_c ll on ll.ip_leveransobjekt_ip_leveranspunkterip_leveranspunkter_idb = l.id and ll.deleted = 0
'   ) AS oq;