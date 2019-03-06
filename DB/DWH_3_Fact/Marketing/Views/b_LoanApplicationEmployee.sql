CREATE VIEW Marketing.[b_LoanApplicationEmployee]
AS
SELECT bmlae.MLLoanApplicationEmployee_key
      ,bmlae.MLLoanApplication_key
      ,bmlae.CustomerSupportEmployee_key
      ,bmlae.EmployeeRole 
FROM Fact.b_MLLoanApplicationEmployee bmlae