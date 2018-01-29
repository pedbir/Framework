
CREATE VIEW Sugar.Leveransobjekt
AS
SELECT  SysValidFromDateTime                             = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime                       = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC                          = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC                                 = CAST(GETUTCDATE() AS DATETIME2(0))
        , Leveransobjekt_bkey                            = CONVERT(NVARCHAR(100), Id)
        , Name                                           = CONVERT(NVARCHAR(255), name)
        , Deleted                                        = CONVERT(INT, deleted)
        , Fastighetsbeteckningc                          = CONVERT(NVARCHAR(255), fastighetsbeteckning_c)
        , Byggnationsstatusc                             = CONVERT(NVARCHAR(100), byggnationsstatus_c)
        , Iikbeslutc                                     = CONVERT(NVARCHAR(100), iikbeslut_c)
        , Stadsnatc                                      = CONVERT(NVARCHAR(100), stadsnat_c)
        , Kommunc                                        = CONVERT(NVARCHAR(100), kommun_c)
        , Regionc                                        = CONVERT(NVARCHAR(100), region_c)
        , Typavortc                                      = CONVERT(NVARCHAR(100), typ_av_ort_c)
        , Planeradbyggstartc                             = CONVERT(DATE, planerad_byggstart_c)
        , Planeradbyggavslutc                            = CONVERT(DATE, planerad_byggavslut_c)
        , Planeradstartkundinstallc                      = CONVERT(DATE, planerad_start_kundinstall_c)
        , Projektidifsc                                  = CONVERT(NVARCHAR(255), projekt_id_ifs_c)
        , Entreprenorddc                                 = CONVERT(NVARCHAR(100), entreprenor_dd_c)
        , Ansvarigsaljorganisationc                      = CONVERT(NVARCHAR(100), ansvarig_saljorganisation_c)
        , Ansvarigbyggorganisationc                      = CONVERT(NVARCHAR(100), ansvarig_byggorganisation_c)
        , Affarstypc                                     = CONVERT(NVARCHAR(255), affarstyp_c)
        , Klarrapporteradcavac                           = CONVERT(NVARCHAR(100), klarrapporterad_cava_c)
        , Ipgeografiipleveransobjektipgeografiida        = CONVERT(NVARCHAR(100), ip_geografi_ip_leveransobjektip_geografi_ida)
        , Opportunitiesipleveransobjekt1opportunitiesida = CONVERT(NVARCHAR(100), opportunities_ip_leveransobjekt_1opportunities_ida)
        , Contactsipleveransobjekt2contactsida           = CONVERT(NVARCHAR(100), contacts_ip_leveransobjekt_2contacts_ida)
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	l.id
	, l.name
    , l.date_entered
    , l.date_modified
    , l.deleted
	, lc.fastighetsbeteckning_c
	, lc.byggnationsstatus_c
	, lc.iikbeslut_c
	, lc.stadsnat_c
	, lc.kommun_c
	, lc.region_c
	, lc.typ_av_ort_c
	, lc.planerad_byggstart_c
	, lc.planerad_byggavslut_c
	, lc.planerad_start_kundinstall_c
	, lc.projekt_id_ifs_c
	, lc.entreprenor_dd_c
	, lc.ansvarig_saljorganisation_c
	, lc.ansvarig_byggorganisation_c
	, lc.affarstyp_c
	, lc.klarrapporterad_cava_c
    , gl.ip_geografi_ip_leveransobjektip_geografi_ida
    , ol.opportunities_ip_leveransobjekt_1opportunities_ida
    , cl.contacts_ip_leveransobjekt_2contacts_ida
FROM ip_leveransobjekt l
LEFT JOIN ip_leveransobjekt_cstm lc on l.id = lc.id_c
LEFT JOIN ip_geografi_ip_leveransobjekt_c gl on gl.ip_geografi_ip_leveransobjektip_leveransobjekt_idb = l.id and gl.deleted = 0
LEFT JOIN opportunities_ip_leveransobjekt_1_c ol on ol.opportunities_ip_leveransobjekt_1ip_leveransobjekt_idb = l.id and ol.deleted = 0
LEFT JOIN contacts_ip_leveransobjekt_2_c cl ON cl.contacts_ip_leveransobjekt_2ip_leveransobjekt_idb = l.id and cl.deleted = 0 
'   ) AS oq;