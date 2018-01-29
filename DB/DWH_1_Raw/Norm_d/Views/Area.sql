
CREATE VIEW [Norm_d].[Area]
AS
SELECT  SysValidFromDateTime                       = o.SysValidFromDateTime
        , SysSrcGenerationDateTime                 = o.SysSrcGenerationDateTime
        , SysDatetimeDeletedUTC                    = CAST(CASE WHEN o.Deleted = 1 THEN o.SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
        , SysModifiedUTC                           = o.SysModifiedUTC
        , Area_bkey                                = o.Omrade_bkey
        , AreaName                                 = o.Name
        , Geography_bkey                           = CAST(ISNULL(NULLIF(o.Ipgeografiipomrade1ipgeografiida, ''), '-1') AS NVARCHAR(100))
        , Project_bkey                             = CAST(ISNULL(NULLIF(o.Projektnummerifsc, ''), '-1') AS NVARCHAR(100))
        , Employee_MetroNetworkManager_bkey        = CAST(ISNULL(NULLIF(o.Useridc, ''), '-1') AS NVARCHAR(100))
        , Employee_RegionConstructionManager_bkey  = CAST(ISNULL(NULLIF(o.Userid2c, ''), '-1') AS NVARCHAR(100))
        , Employee_DeliveryStreamLeader_bkey       = CAST(ISNULL(NULLIF(o.Userid3c, ''), '-1') AS NVARCHAR(100))
        , Employee_ConstructionManager_bkey        = CAST(ISNULL(NULLIF(o.UsersIpOmrade1UsersIda, ''), '-1') AS NVARCHAR(100))
        , SugarEnum_ConstructionStatus_bkey        = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#byggnationsstatus_c#' + NULLIF(o.Byggnationsstatusc, ''), '-1'))))
        , SugarEnum_SalesStatus_bkey               = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#forsaljningsstatus_c#' + NULLIF(o.Forsaljningsstatusc, ''), '-1'))))
        , SugarEnum_SourcingStatus_bkey            = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#status_upphandling_c#' + NULLIF(o.Statusupphandlingc, ''), '-1'))))
        , SugarEnum_IikStatus_bkey                 = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#iikbeslut_c#' + NULLIF(o.Iikbeslutc, ''), '-1'))))
        , SugarEnum_AreaType_bkey                  = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#typ_av_ort_c#' + NULLIF(o.Typavortc, ''), '-1'))))
        , SugarEnum_Contractor_bkey                = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#entreprenor_dd_c#' + NULLIF(o.Entreprenorddc, ''), '-1'))))
        , SugarEnum_SalesOrganisation_bkey         = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#ansvarig_saljorganisation_c#' + NULLIF(o.Ansvarigsaljorganisationc, ''), '-1'))))
        , SugarEnum_ConstructionOrganisation_bkey  = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#ansvarig_byggorganisation_c#' + NULLIF(o.Ansvarigbyggorganisationc, ''), '-1'))))
        , SugarEnum_SubsidyArea_bkey               = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#bidragsomrade_c#' + ISNULL(NULLIF(IIF(o.Bidragsomradec = 'Ja', 'JA_BEVILJAT', o.Bidragsomradec), ''), 'Nej'), '-1'))))
        , SugarEnum_ProjectDesign_bkey             = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#projektering_dd_c#' + NULLIF(o.Projekteringddc, ''), '-1'))))
        , SugarEnum_CountyAdvisoryBoardStatus_bkey = UPPER(LTRIM(RTRIM(ISNULL('IP_Omrade#tillstand_lansstyrelsen_c#' + NULLIF(o.Tillstandlansstyrelsenc, ''), '-1'))))
        , InitialSalesStart                        = o.Forsaljningpaborjadc
        , AfterMarketSalesStart                    = o.Efterkampanjpaborjadc
        , StrategicNetworkPlanningComplete         = o.Natdesignklarc
        , LeasedUplinkExpected                     = o.Planeratleveransnodlankc
        , LeasedUplinkDeployed                     = o.Nodlankdriftsattc
        , TRVPermissionNeeded                      = o.Trvbehovsc
        , SumOfTRVNeeded                           = o.Antaltrvbehovsc
        , SumOfTRVSubmitted                        = o.Antaltrvinskickadec
        , SumOfTRVApproved                         = o.Antaltrvklarac
        , ExpectedApprovalOfTRV                    = o.Planeratklardatumtrvc
        , AllTRVApplicationsSubmitted              = o.Allatillstandtrvinskickadec
        , AllTRVApplicationsApproved               = o.Tillstandtrvklarac
        , CommentOnTRV                             = o.Tillstandtrvklaratextc
        , MunicipalLandPermit                      = o.Kommunavtalklarac
        , BuildingPermitApproved                   = o.Bygglovklarc
        , AllBuildingPermitsSubmitted              = o.Allabygglovinskickadec
        , CommentOnBuildingPermit                  = o.Bygglovklartextc
        , PlannedInstallationStart                 = o.Planeradinstallationstartc
        , PlannedInstallationComplete              = o.Planeratavslutkundinstallc
        , PlannedConstructionStart                 = o.Planeradbyggstartc
        , FinalDocumentationComplete               = o.Slutdokumentationklarc
		, CustomerCommunicationCount			   = o.KkKundkommunikationCountC
FROM    Sugar_RawTyped.r_Omrade o
WHERE   o.Omrade_bkey <> '-1'