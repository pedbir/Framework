
CREATE VIEW Norm_f.Subscription
AS
WITH temp AS (
             SELECT ra.SysDatetimeDeletedUTC
                    , ra.SysModifiedUTC
                    , ra.SysValidFromDateTime
                    , ra.SysSrcGenerationDateTime
                    , Subscription_bkey        = ra.Abonnemang_bkey
                    , SubscriptionProduct_bkey = ra.aboartnr
                    , ServiceProvider_bkey     = ra.aboisp
                    , Access_bkey              = ra.aboadressdbid
                    , Calendar_Start_bkey      = CAST(ra.aboinkopldat AS DATETIME2(0))
                    , Calendar_End_bkey        = CAST(NULL AS DATETIME2(0))
                    , Calendar_Purchase_bkey   = ra.abostartdat
                    , ResoposibleSalesEntity   = ra.aboansvarig
                    , IsClosed                 = CAST(0 AS BIT)
             FROM   Netadmin_RawTyped.r_Abonnemang ra
             WHERE  ra.aboinkopldat IS NOT NULL AND ra.Abonnemang_bkey <> -1
             UNION ALL
             SELECT ra.SysDatetimeDeletedUTC
                    , ra.SysModifiedUTC
                    , ra.SysValidFromDateTime
                    , ra.SysSrcGenerationDateTime
                    , Subscription_bkey        = ra.PreAbonnemang_bkey
                    , SubscriptionProduct_bkey = ra.Preartnr
                    , ServiceProvider_bkey     = ra.aboisp
                    , Access_bkey              = ra.Preadrid
                    , Calendar_Start_bkey      = ra.Preinkopldat
                    , Calendar_End_bkey        = ra.Preurkopldat
                    , Calendar_Purchase_bkey   = ra.abostartdat
                    , ResoposibleSalesEntity   = ra.aboansvarig
                    , IsClosed                 = CAST(1 AS BIT)
             FROM   Netadmin_RawTyped.vr_PreAbonnemang ra
			 WHERE ra.PreAbonnemang_bkey <> -1
			 )
SELECT  t.SysDatetimeDeletedUTC
        , t.SysModifiedUTC
        , t.SysValidFromDateTime
        , t.SysSrcGenerationDateTime
        , t.Subscription_bkey
        , t.SubscriptionProduct_bkey
        , t.ServiceProvider_bkey
        , t.Access_bkey
        , Calendar_Start_bkey = CAST(CAST(t.Calendar_Start_bkey AS DATE) AS DATETIME)
        , Calendar_End_bkey = CAST(CAST(t.Calendar_End_bkey AS DATE) AS DATETIME)
        , Calendar_Purchase_bkey = CAST(CAST(t.Calendar_Purchase_bkey AS DATE) AS DATETIME)
        , t.ResoposibleSalesEntity
FROM    (   SELECT  t.SysDatetimeDeletedUTC
                    , t.SysModifiedUTC
                    , t.SysValidFromDateTime
                    , t.SysSrcGenerationDateTime
                    , t.Subscription_bkey
                    , t.SubscriptionProduct_bkey
                    , t.ServiceProvider_bkey
                    , t.Access_bkey
                    , Calendar_Start_bkey = CASE WHEN LAG(0, 1, 1) OVER (PARTITION BY t.Subscription_bkey ORDER BY t.SysValidFromDateTime) = 0 THEN t.SysValidFromDateTime ELSE t.Calendar_Start_bkey END
                    , Calendar_End_bkey   = ISNULL(LEAD(DATEADD(DAY, -1, t.SysValidFromDateTime), 1, NULL) OVER (PARTITION BY t.Subscription_bkey ORDER BY t.SysValidFromDateTime), t.Calendar_End_bkey)
                    , t.Calendar_Purchase_bkey
                    , t.ResoposibleSalesEntity
                    , _rowNo              = ROW_NUMBER() OVER (PARTITION BY t.Subscription_bkey ORDER BY t.SysValidFromDateTime)
                    , t.IsClosed
            FROM    temp t) t
WHERE   NOT (   t._rowNo > 1
                AND t.IsClosed = 1)