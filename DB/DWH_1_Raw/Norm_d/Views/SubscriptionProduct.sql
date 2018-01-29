CREATE VIEW Norm_d.SubscriptionProduct
AS
SELECT  SysDatetimeDeletedUTC
        , SysModifiedUTC
        , SysValidFromDateTime
        , SysSrcGenerationDateTime
        , SubscriptionProduct_bkey = NetadminArticle_bkey
        , SubscriptionProduct      = ISNULL(Service, 'Unknown')
        , SubscriptionProductType  = ISNULL(ServiceType, 'Unknown')
        , MonthlyPrice             = ISNULL(MonthlyPrice, 0)
        , StartPrice               = ISNULL(StartPrice, 0)
        , Billable                 = CAST(CASE WHEN NoBill = 0 THEN 'Y' ELSE 'N' END AS NVARCHAR(5))
FROM    NBS_RawTyped.r_NetadminArticle
WHERE   NetadminArticle_bkey <> '-1'