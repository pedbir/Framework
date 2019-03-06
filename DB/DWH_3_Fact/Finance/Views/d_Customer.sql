
CREATE VIEW Finance.d_Customer
AS
SELECT FinanceCustomer_key
      ,CustomerCode = FinanceCustomerCode
      ,Customer = IIF(FinanceCustomer_key = -1, FinanceCustomerCode, FinanceCustomerCode +' '+ FinanceCustomerName      )
FROM [Fact].[d_FinanceCustomer]