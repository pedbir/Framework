

CREATE VIEW [Marketing].[d_Vendor]
AS
SELECT Vendor_key = fv.FinanceVendor_key
      ,VendorCode = fv.FinanceVendorCode
      ,Vendor = IIF(fv.FinanceVendor_key = -1, fv.FinanceVendorCode , fv.FinanceVendorName)
FROM [Fact].[d_FinanceVendor] fv
INNER JOIN  (SELECT DISTINCT FinanceVendor_key FROM Marketing.f_FinanceMarketMetrics ) fmm ON fv.FinanceVendor_key = fmm.FinanceVendor_key