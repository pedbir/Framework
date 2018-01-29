

CREATE VIEW Sugar.Bestallning
AS
SELECT  SysValidFromDateTime                         = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime                   = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC                      = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC                             = CAST(date_modified AS DATETIME2(0))
        , Bestallning_bkey                           = CONVERT(NVARCHAR(100), Id)
        , Name                                       = CONVERT(NVARCHAR(255), Name)
        , Deleted                                    = CONVERT(INT, deleted)
        , BillingAddressStreet                       = CONVERT(NVARCHAR(150), billing_address_street)
        , BllingAddressPostalcode                    = CONVERT(NVARCHAR(20), billing_address_postalcode)
        , BillingAddressCity                         = CONVERT(NVARCHAR(100), billing_address_city)
        , StatusLeveransC                            = CONVERT(NVARCHAR(100), status_leverans_c)
        , Statusfaktureringc                         = CONVERT(NVARCHAR(100), status_fakturering_c)
        , Bestallningstypc                           = CONVERT(NVARCHAR(100), bestallningstyp_c)
        , Anslutningstypc                            = CONVERT(NVARCHAR(100), anslutningstyp_c)
        , Kallabestallningc                          = CONVERT(NVARCHAR(100), kalla_bestallning_c)
        , Anslutningsavgiftc                         = CONVERT(MONEY, anslutningsavgift_c)
        , Rotavdragc                                 = CONVERT(MONEY, rotavdrag_c)
        , Rutavdragc                                 = CONVERT(MONEY, rutavdrag_c)
        , Kompensationc                              = CONVERT(MONEY, kompensation_c)
        , Extrakostnadc                              = CONVERT(MONEY, extrakostnad_c)
        , Planeradkundinstallationc                  = CONVERT(DATETIME2, planerad_kundinstallation_c)
        , Bokadkundinstallationc                     = CONVERT(DATETIME2, bokad_kundinstallation_c)
        , Tomtschaktutforddatumc                     = CONVERT(DATE, tomtschakt_utford_datum_c)
        , Installationc                              = CONVERT(DATE, installation_c)
        , Tjanstebundlingc                           = CONVERT(NVARCHAR(100), tjanstebundling_c)
        , Prisjusteringbundlingc                     = CONVERT(MONEY, prisjustering_bundling_c)
        , Tjanstebundlingnamnc                       = CONVERT(NVARCHAR(255), tjanstebundling_namn_c)
        , Netadmintjanstskapaddatumc                 = CONVERT(DATE, netadmin_tjanst_skapad_datum_c)
        , Installationsdatumnetadminc                = CONVERT(DATE, installationsdatumnetadmin_c)
        , Kampanj6maninternetc                       = CONVERT(NVARCHAR(20), kampanj_6_man_internet_c)
        , Fornamnc                                   = CONVERT(NVARCHAR(255), fornamn_c)
        , Efternamnc                                 = CONVERT(NVARCHAR(255), efternamn_c)
        , Epostadressc                               = CONVERT(NVARCHAR(255), epostadress_c)
        , Mobiltelc                                  = CONVERT(NVARCHAR(255), mobiltel_c)
        , Hemtelc                                    = CONVERT(NVARCHAR(255), hemtel_c)
        , Personnummerc                              = CONVERT(NVARCHAR(255), personnummer_c)
        , Orgnummerc                                 = CONVERT(NVARCHAR(255), orgnummer_c)
        , Ipmojligheteripbestallningipmojligheterida = CONVERT(NVARCHAR(100), ip_mojligheter_ip_bestallningip_mojligheter_ida)
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	b.id
	, b.name
    , b.date_entered
    , b.date_modified
    , b.deleted
	, b.billing_address_street
	, b.billing_address_postalcode
	, b.billing_address_city
	, bc.status_leverans_c
	, bc.status_fakturering_c
	, bc.bestallningstyp_c
	, bc.anslutningstyp_c
	, bc.kalla_bestallning_c
	, bc.anslutningsavgift_c
	, bc.rotavdrag_c
	, bc.rutavdrag_c
	, bc.kompensation_c
	, bc.extrakostnad_c
	, bc.planerad_kundinstallation_c
	, bc.bokad_kundinstallation_c
	, bc.tomtschakt_utford_datum_c
	, bc.installation_c
	, bc.tjanstebundling_c
	, bc.prisjustering_bundling_c
	, bc.tjanstebundling_namn_c
	, bc.netadmin_tjanst_skapad_datum_c
	, bc.installationsdatumnetadmin_c
	, bc.kampanj_6_man_internet_c
	, bc.fornamn_c
	, bc.efternamn_c
	, bc.epostadress_c
	, bc.mobiltel_c
	, bc.hemtel_c
	, bc.personnummer_c
	, bc.orgnummer_c
    , mb.ip_mojligheter_ip_bestallningip_mojligheter_ida
FROM ip_bestallning b
LEFT JOIN ip_bestallning_cstm bc on b.id = bc.id_c
LEFT JOIN ip_mojligheter_ip_bestallning_c mb ON mb.ip_mojligheter_ip_bestallningip_bestallning_idb = b.id and mb.deleted = 0
'   ) oq;