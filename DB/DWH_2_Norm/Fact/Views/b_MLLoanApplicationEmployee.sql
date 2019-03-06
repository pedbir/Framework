CREATE VIEW Fact.b_MLLoanApplicationEmployee
AS
SELECT nmlae.SysDatetimeDeletedUTC
      ,nmlae.SysModifiedUTC
      ,nmlae.SysValidFromDateTime
      ,nmlae.SysSrcGenerationDateTime
      ,MLLoanApplicationEmployee_key = nmlae.MLLoanApplicationEmployee_bkey	  
      ,nmlae.MLLoanApplication_bkey	  
      ,nmlae.CustomerSupportEmployee_bkey
      ,nmlae.EmployeeRoleID
	  ,nmla.MLLoanApplication_key
	  ,ncse.CustomerSupportEmployee_key
      ,nmlae.EmployeeRole 
FROM (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmlae.MLLoanApplicationEmployee_bkey ORDER BY nmlae.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplicationEmployee nmlae) nmlae
LEFT JOIN (SELECT ncse.CustomerSupportEmployee_key, ncse.CustomerSupportEmployee_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY ncse.CustomerSupportEmployee_bkey ORDER BY ncse.SysValidFromDateTime DESC) FROM Norm.n_CustomerSupportEmployee ncse) ncse ON ncse.CustomerSupportEmployee_bkey = nmlae.CustomerSupportEmployee_bkey AND ncse._isFirst = 1
LEFT JOIN (SELECT nmla.MLLoanApplication_key, nmla.MLLoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmla.MLLoanApplication_bkey ORDER BY nmla.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplication nmla) nmla ON nmlae.MLLoanApplication_bkey = nmla.MLLoanApplication_bkey AND nmla._isFirst = 1
WHERE nmlae._isFirst = 1