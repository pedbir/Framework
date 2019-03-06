CREATE VIEW Finance.d_Vendor
AS
SELECT FinanceVendor_key
      ,VendorCode = FinanceVendorCode
      ,Vendor = IIF(FinanceVendor_key = -1, FinanceVendorCode , FinanceVendorCode  + ' ' + FinanceVendorName      )
FROM [Fact].[d_FinanceVendor]