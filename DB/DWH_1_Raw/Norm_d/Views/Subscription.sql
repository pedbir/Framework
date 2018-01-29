CREATE VIEW Norm_d.Subscription
AS
SELECT  ra.SysDatetimeDeletedUTC
        , ra.SysModifiedUTC
        , ra.SysValidFromDateTime
        , ra.SysSrcGenerationDateTime
        , Subscription_bkey          = ra.Abonnemang_bkey
        , SubscriptionProduct_bkey   = ISNULL(ra.aboartnr, '-1')
        , ServiceProvider_bkey       = ISNULL(ra.aboisp, '-1')
        , Access_bkey                = ra.aboadressdbid
        , Calendar_Subscription_bkey = CAST(ra.aboinkopldat AS DATETIME)
        , Calendar_Purchase_bkey     = CAST(ra.abostartdat AS DATETIME)
        , ResoposibleSalesEntity     = ra.aboansvarig
        , IsClosed                   = CAST(0 AS BIT)
FROM    Netadmin_RawTyped.r_Abonnemang ra
WHERE   ra.Abonnemang_bkey <> -1
UNION ALL
SELECT  ra.SysDatetimeDeletedUTC
        , ra.SysModifiedUTC
        , ra.SysValidFromDateTime
        , ra.SysSrcGenerationDateTime
        , Subscription_bkey          = ISNULL(ra.PreAbonnemang_bkey, '-1')
        , SubscriptionProduct_bkey   = ISNULL(ra.Preartnr, '-1')
        , ServiceProvider_bkey       = ra.aboisp
        , Access_bkey                = ra.Preadrid
        , Calendar_Subscription_bkey = ra.Preinkopldat
        , Calendar_Purchase_bkey     = ra.abostartdat
        , ResoposibleSalesEntity     = ra.aboansvarig
        , IsClosed                   = CAST(0 AS BIT)
FROM    Netadmin_RawTyped.r_PreAbonnemang ra
WHERE   ra.PreAbonnemang_bkey <> -1
        AND ra.PreAbonnemang_bkey NOT IN ( SELECT   ra.Abonnemang_bkey FROM Netadmin_RawTyped.r_Abonnemang ra )
UNION ALL
SELECT  ra.SysDatetimeDeletedUTC
        , ra.SysModifiedUTC
        , SysValidFromDateTime       = CAST(GETUTCDATE() AS DATETIME2(0))
        , ra.SysSrcGenerationDateTime
        , Subscription_bkey          = ra.PreAbonnemang_bkey
        , SubscriptionProduct_bkey   = ISNULL(ra.Preartnr, '-1')
        , ServiceProvider_bkey       = ISNULL(ra.aboisp, '-1')
        , Access_bkey                = ra.Preadrid
        , Calendar_Subscription_bkey = ra.Preurkopldat
        , Calendar_Purchase_bkey     = ra.abostartdat
        , ResoposibleSalesEntity     = ra.aboansvarig
        , IsClosed                   = CAST(1 AS BIT)
FROM    Netadmin_RawTyped.r_PreAbonnemang ra
WHERE   ra.PreAbonnemang_bkey <> -1