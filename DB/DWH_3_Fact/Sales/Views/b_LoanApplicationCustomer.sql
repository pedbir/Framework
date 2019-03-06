


CREATE VIEW [Sales].[b_LoanApplicationCustomer]
AS

SELECT bmlac.MLLoanApplicationCustomer_key
      ,LoanApplication_key = CAST(CAST(bmlac.MLLoanApplication_key AS NVARCHAR(50)) + '#ML' AS NVARCHAR(100))
      ,bmlac.MLLoanCustomer_key
      ,bmlac.IsMainApplicant
	  ,bmlac.CustomerSource
FROM Fact.b_MLLoanApplicationCustomer bmlac