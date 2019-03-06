




CREATE VIEW [Fact].[d_MLLoanCustomer]
AS

SELECT mlc.MLLoanCustomer_key
      ,mlc0.SysDatetimeDeletedUTC
      ,mlc0.SysModifiedUTC
      ,mlc.SysIsInferred
      ,mlc.SysValidFromDateTime
      ,mlc.SysSrcGenerationDateTime
      ,mlc.MLLoanCustomer_bkey
      ,mlc0.BirthYear
      ,mlc0.Gender
      ,mlc0.City
      ,mlc0.Zip
      ,mlc0.MaritalStatusCode
      ,mlc0.MaritalStatusText
      ,mlc0.PriceLevelCode
      ,mlc0.PriceLevelText
      ,mlc0.RiskgroupCode
      ,mlc0.RiskgroupText
      ,mlc0.DebtKFM
      ,mlc0.AccomodationTypeCode
      ,mlc0.AccomodationTypeText
      ,mlc0.TotalNumberOfRemarks
      ,mlc0.NumberOfRemarks
      ,mlc0.TotalSumOfRemarks
      ,mlc0.SumOfRemarks
      ,mlc0.PrenupDateString
      ,mlc0.WarningCode
      ,mlc0.WarningText
	  ,mlc0.IsPep
      ,mlc0.AssessmentYear
      ,mlc0.AssessedIncome
      ,mlc0.IsBankrupt
      ,mlc0.LastRemarkDate
      ,mlc0.LastBankruptDate
      ,mlc0.TotalNumberOfMortgageRemarks
      ,mlc0.NumberOfMortgageRemarks
      ,mlc0.SumOfMortgageRemarks 
FROM Norm.n_MLLoanCustomer mlc
OUTER APPLY (SELECT TOP 1 mlc0.* FROM Norm.n_MLLoanCustomer mlc0 WHERE mlc0.MLLoanCustomer_bkey = mlc.MLLoanCustomer_bkey ORDER BY mlc0.SysValidFromDateTime DESC) mlc0