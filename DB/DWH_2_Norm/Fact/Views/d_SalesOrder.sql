CREATE VIEW Fact.d_SalesOrder
AS

SELECT  nso.SalesOrder_key
        , nso.SysDatetimeDeletedUTC
        , nso.SysModifiedUTC
        , nso.SysIsInferred
        , nso.SysValidFromDateTime
        , nso.SysSrcGenerationDateTime
        , nso.SalesOrder_bkey
        , no.Opportunity_key
        , SugarEnum_DeliveryStatus_key = SugarEnum_DeliveryStatus_bkey.SugarEnum_key
        , SugarEnum_OrderType_key      = SugarEnum_OrderType_bkey.SugarEnum_key
        , SugarEnum_ConnectionType_key = SugarEnum_ConnectionType_bkey.SugarEnum_key
        , SugarEnum_OrderSource_key    = SugarEnum_OrderSource_bkey.SugarEnum_key
        , nso.PlannedInstallationDate
        , nso.ProductBundleYN
        , nso.ProductBundleName
        , nso.Campaign6MonthInternet
        , nso.ConnectionFeeSEK
        , nso.RotDeductionSEK
        , nso.RutDeductionSEK
        , nso.DiscountSEK
        , nso.ExtraFeeSEK
        , nso.ProductBundlePriceAdjustmentSEK
        , nso.TotalRevenueSEK
FROM    Norm.n_SalesOrder nso
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_Opportunity no WHERE no.Opportunity_bkey = nso.Opportunity_bkey ORDER BY no.SysValidFromDateTime DESC) no
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = SugarEnum_DeliveryStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_DeliveryStatus_bkey
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = SugarEnum_OrderType_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_OrderType_bkey
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = SugarEnum_ConnectionType_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_ConnectionType_bkey
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = SugarEnum_OrderSource_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_OrderSource_bkey