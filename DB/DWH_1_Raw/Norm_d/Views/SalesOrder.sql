
CREATE VIEW [Norm_d].[SalesOrder]
AS
SELECT  SysValidFromDateTime              = CAST(rb.SysValidFromDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime        = CAST(rb.SysSrcGenerationDateTime AS DATETIME2(0))
        , SysDatetimeDeletedUTC           = CAST(CASE WHEN rb.Deleted = 1 THEN rb.SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
        , SysModifiedUTC                  = CAST(rb.SysModifiedUTC AS DATETIME2(0))
        , SalesOrder_bkey                 = rb.Bestallning_bkey
        , SugarEnum_DeliveryStatus_bkey   = UPPER(LTRIM(RTRIM(ISNULL('IP_Bestallning#status_leverans_c#' + NULLIF(rb.StatusLeveransC, ''), '-1'))))
        , SugarEnum_OrderType_bkey        = UPPER(LTRIM(RTRIM(ISNULL('IP_Bestallning#bestallningstyp_c#' + NULLIF(rb.Bestallningstypc, ''), '-1'))))
        , SugarEnum_ConnectionType_bkey   = UPPER(LTRIM(RTRIM(ISNULL('IP_Bestallning#anslutningstyp_c#' + NULLIF(rb.Anslutningstypc, ''), '-1'))))
        , SugarEnum_OrderSource_bkey      = UPPER(LTRIM(RTRIM(ISNULL('IP_Bestallning#kalla_bestallning_c#' + NULLIF(rb.Kallabestallningc, ''), '-1'))))
        , Opportunity_bkey                = CAST(ISNULL(rb.Ipmojligheteripbestallningipmojligheterida, '-1') AS NVARCHAR(100))
        , PlannedInstallationDate         = COALESCE(rb.Bokadkundinstallationc, rb.Planeradkundinstallationc, NULL)
        , ProductBundleYN                 = rb.Tjanstebundlingc
        , ProductBundleName               = ISNULL(rb.Tjanstebundlingnamnc, '')
        , Campaign6MonthInternet          = rb.Kampanj6maninternetc
        , ConnectionFeeSEK                = ISNULL(rb.Anslutningsavgiftc, 0)
        , RotDeductionSEK                 = ISNULL(rb.Rotavdragc, 0)
        , RutDeductionSEK                 = ISNULL(rb.Rutavdragc, 0)
        , DiscountSEK                     = ISNULL(rb.Kompensationc, 0)
        , ExtraFeeSEK                     = ISNULL(rb.Extrakostnadc, 0)
        , ProductBundlePriceAdjustmentSEK = rb.Prisjusteringbundlingc
        , TotalRevenueSEK                 = CAST(ISNULL(rb.Anslutningsavgiftc, 0) + ISNULL(rb.Rotavdragc, 0) + ISNULL(rb.Rutavdragc, 0) - ABS(ISNULL(rb.Kompensationc, 0)) + ISNULL(rb.Extrakostnadc, 0)
                                                 + ISNULL(rb.Prisjusteringbundlingc * 0.600000, 0) AS MONEY)
        , FirstName                       = rb.Fornamnc
        , Surname                         = rb.Efternamnc
        , Email                           = rb.Epostadressc
        , MobilePhoneNo                   = rb.Mobiltelc
        , PersonalIdentityNumber          = rb.Personnummerc
        , OrganizationNumber              = ISNULL(rb.Orgnummerc, '')
        , Age                             = DATEDIFF(YEAR
                                                     , TRY_CAST(LEFT(CASE WHEN LEN(rb.Personnummerc) = 0 THEN NULL
                                                                          WHEN LEFT(rb.Personnummerc, 2) = '19'
                                                                               OR   LEFT(rb.Personnummerc, 2) = '20' THEN rb.Personnummerc ELSE '19' + rb.Personnummerc END, 8) AS DATE)
                                                     , GETDATE())
        , Gender                          = CASE WHEN LEN(LTRIM(RTRIM(ISNULL(rb.Orgnummerc, '')))) > 0 THEN 'Unknown'
                                                 WHEN LEN(rb.Personnummerc) = 0 THEN NULL
                                                 WHEN LEFT(RIGHT(rb.Personnummerc, 2), 1) IN ( '1', '3', '5', '7', '9' ) THEN 'Male' ELSE 'Female' END
FROM    Sugar_RawTyped.r_Bestallning rb
WHERE	rb.Bestallning_bkey <> '-1'