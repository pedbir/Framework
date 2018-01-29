


CREATE VIEW [Sugar].[Omrade]
AS

SELECT  SysValidFromDateTime               = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime         = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC            = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC                   = CAST(GETUTCDATE() AS DATETIME2(0))
        , Omrade_bkey                      = CONVERT(NVARCHAR(100), Id)
        , Name                             = CONVERT(NVARCHAR(255), name)
        , Deleted                          = CONVERT(INT, deleted)
        , Byggnationsstatusc               = CONVERT(NVARCHAR(100), byggnationsstatus_c)
        , Forsaljningsstatusc              = CONVERT(NVARCHAR(100), forsaljningsstatus_c)
        , Statusupphandlingc               = CONVERT(NVARCHAR(100), status_upphandling_c)
        , Iikbeslutc                       = CONVERT(NVARCHAR(100), iikbeslut_c)
        , Omraderegionc                    = CONVERT(NVARCHAR(100), omrade_region_c)
        , Stadsnatddc                      = CONVERT(NVARCHAR(100), stadsnat_dd_c)
        , Kommunddc                        = CONVERT(NVARCHAR(100), kommun_dd_c)
        , Typavortc                        = CONVERT(NVARCHAR(100), typ_av_ort_c)
        , Forsaljningpaborjadc             = CONVERT(DATE, forsaljning_paborjad_c)
        , Efterkampanjpaborjadc            = CONVERT(DATE, efterkampanj_paborjad_c)
        , Saljstopputesaljc                = CONVERT(DATE, saljstopputesalj_c)
        , Planeradbyggstartc               = CONVERT(DATE, planerad_byggstart_c)
        , Planeratklardatumc               = CONVERT(DATE, planerat_klardatum_c)
        , Planeradinstallationstartc       = CONVERT(DATE, planerad_installationstart_c)
        , Planeratavslutkundinstallc       = CONVERT(DATE, planerat_avslut_kundinstall_c)
        , Dateoverlamnadtillbyggc          = CONVERT(DATE, date_overlamnad_till_bygg_c)
        , Projektnummerifsc                = CONVERT(NVARCHAR(255), projektnummer_ifs_c)
        , Entreprenorddc                   = CONVERT(NVARCHAR(100), entreprenor_dd_c)
        , Ansvarigsaljorganisationc        = CONVERT(NVARCHAR(100), ansvarig_saljorganisation_c)
        , Ansvarigbyggorganisationc        = CONVERT(NVARCHAR(100), ansvarig_byggorganisation_c)
        , Useridc                          = CONVERT(NVARCHAR(100), user_id_c)
        , Userid2c                         = CONVERT(NVARCHAR(100), user_id2_c)
        , Userid3c                         = CONVERT(NVARCHAR(100), user_id3_c)
        , Bidragsomradec                   = CONVERT(NVARCHAR(100), bidragsomrade_c)
        , Natdesignklarc                   = CONVERT(DATE, natdesign_klar_c)
        , Planeratleveransnodlankc         = CONVERT(DATE, planerat_leverans_nod_lank_c)
        , Nodlankdriftsattc                = CONVERT(DATE, nod_lank_driftsatt_c)
        , Projekteringddc                  = CONVERT(NVARCHAR(100), projektering_dd_c)
        , Kommunavtalklarac                = CONVERT(DATE, kommunavtal_klara_c)
        , Trvbehovsc                       = CONVERT(NVARCHAR(100), trv_behovs_c)
        , Planeratklardatumtrvc            = CONVERT(DATE, planerat_klardatum_trv_c)
        , Antaltrvbehovsc                  = CONVERT(INT, antal_trv_behovs_c)
        , Antaltrvklarac                   = CONVERT(INT, antal_trv_klara_c)
        , Tillstandtrvklarac               = CONVERT(DATE, tillstand_trv_klara_c)
        , Tillstandtrvklaratextc           = CONVERT(NVARCHAR(255), tillstand_trv_klara_text_c)
        , Allatillstandtrvinskickadec      = CONVERT(DATE, allatillstandtrvinskickade_c)
        , Antaltrvinskickadec              = CONVERT(INT, antal_trv_inskickade_c)
        , Tillstandlansstyrelsenc          = CONVERT(NVARCHAR(100), tillstand_lansstyrelsen_c)
        , Lansstyrelseninskickatc          = CONVERT(DATE, lansstyrelsen_inskickat_c)
        , Bygglovklarc                     = CONVERT(DATE, bygglov_klar_c)
        , Bygglovklartextc                 = CONVERT(NVARCHAR(255), bygglov_klar_text_c)
        , Allabygglovinskickadec           = CONVERT(DATE, allabygglovinskickade_c)
        , Slutdokumentationklarc           = CONVERT(DATE, slutdokumentation_klar_c)
        , Konkurrentc                      = CONVERT(NVARCHAR(255), konkurrent_c)
        , Iikgodkantdatumc                 = CONVERT(DATE, iik_godkant_datum_c)
        , Antalutfordaschaktmeterc         = CONVERT(INT, antalutfordaschaktmeter_c)
        , Antalplaneradeschaktmeterc       = CONVERT(INT, antalplaneradeschaktmeter_c)
        , Antalfibreradefosarc             = CONVERT(INT, antal_fibrerade_fosar_c)
        , Planeratantalfosarc              = CONVERT(INT, planerat_antal_fosar_c)
        , Antalmarkavtalbehovsc            = CONVERT(INT, antal_markavtal_behovs_c)
		, KkKundkommunikationCountC		   = CONVERT(INT, kk_kundkommunikation_count_c)
		, KrFas1C						   = CONVERT(NVARCHAR(50), kr_fas1_c)
		, KrFas2C						   = CONVERT(NVARCHAR(50), kr_fas2_c)
		, KrFas3C						   = CONVERT(NVARCHAR(50), kr_fas3_c)
		, KrFas4C						   = CONVERT(NVARCHAR(50), kr_fas4_c)
		, KrFas5C						   = CONVERT(NVARCHAR(50), kr_fas5_c)
		, KrFas6C						   = CONVERT(NVARCHAR(50), kr_fas6_c)
        , Ipgeografiipomrade1ipgeografiida = CONVERT(NVARCHAR(100), ip_geografi_ip_omrade_1ip_geografi_ida)
        , UsersIpOmrade1UsersIda           = CONVERT(NVARCHAR(100), users_ip_omrade_1users_ida)
--select *
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	o.id
	, o.name
    , o.date_entered
    , o.date_modified
    , o.deleted
    , oc.byggnationsstatus_c
    , oc.forsaljningsstatus_c
	, oc.status_upphandling_c
	, oc.iikbeslut_c
	, oc.omrade_region_c
	, oc.stadsnat_dd_c
	, oc.kommun_dd_c
	, oc.typ_av_ort_c
	, oc.forsaljning_paborjad_c
	, oc.efterkampanj_paborjad_c
	, oc.saljstopputesalj_c
	, oc.planerad_byggstart_c
	, oc.planerat_klardatum_c
	, oc.planerad_installationstart_c
	, oc.planerat_avslut_kundinstall_c
	, oc.date_overlamnad_till_bygg_c
	, oc.projektnummer_ifs_c
	, oc.entreprenor_dd_c
	, oc.ansvarig_saljorganisation_c
	, oc.ansvarig_byggorganisation_c
	, oc.user_id_c
	, oc.user_id2_c
	, oc.user_id3_c
	, oc.bidragsomrade_c
	, oc.natdesign_klar_c
	, oc.planerat_leverans_nod_lank_c
	, oc.nod_lank_driftsatt_c
	, oc.projektering_dd_c
	, oc.kommunavtal_klara_c
	, oc.trv_behovs_c
	, oc.planerat_klardatum_trv_c
	, oc.antal_trv_behovs_c
	, oc.antal_trv_klara_c
	, oc.tillstand_trv_klara_c
	, oc.tillstand_trv_klara_text_c
	, oc.allatillstandtrvinskickade_c
	, oc.antal_trv_inskickade_c
	, oc.tillstand_lansstyrelsen_c
	, oc.lansstyrelsen_inskickat_c
	, oc.bygglov_klar_c
	, oc.bygglov_klar_text_c
	, oc.allabygglovinskickade_c
	, oc.slutdokumentation_klar_c
	, oc.konkurrent_c
	, CAST(''1900-01-01'' as Datetime) as iik_godkant_datum_c 
	, oc.antalutfordaschaktmeter_c
	, oc.antalplaneradeschaktmeter_c
	, oc.antal_fibrerade_fosar_c
	, oc.planerat_antal_fosar_c
	, oc.antal_markavtal_behovs_c
	, oc.kk_kundkommunikation_count_c
	, oc.kr_fas1_c
	, oc.kr_fas2_c
	, oc.kr_fas3_c
	, oc.kr_fas4_c
	, oc.kr_fas5_c
	, oc.kr_fas6_c
    , go.ip_geografi_ip_omrade_1ip_geografi_ida
    , uo.users_ip_omrade_1users_ida
FROM ip_omrade o
LEFT JOIN ip_omrade_cstm oc on o.id = oc.id_c
LEFT JOIN ip_geografi_ip_omrade_1_c go on go.ip_geografi_ip_omrade_1ip_omrade_idb = o.id and go.deleted = 0
LEFT JOIN users_ip_omrade_1_c uo ON uo.users_ip_omrade_1ip_omrade_idb = o.id and uo.deleted = 0
'   ) AS oq;