




CREATE VIEW Marketing.[d_LoanCustomer]
AS

SELECT dmlc.MLLoanCustomer_key
      ,dmlc.BirthYear
	  ,dmlc.Gender
	  ,dmlc.City
      ,dmlc.Zip
      ,MaritalStatus		= dmlc.MaritalStatusText
      ,PriceLevel			= dmlc.PriceLevelText
      ,Riskgroup			= dmlc.RiskgroupText
      ,dmlc.DebtKFM
      ,AccomodationType		= dmlc.AccomodationTypeText
      ,dmlc.TotalNumberOfRemarks
      ,dmlc.NumberOfRemarks
      ,dmlc.TotalSumOfRemarks
      ,dmlc.SumOfRemarks
      ,dmlc.PrenupDateString
      ,dmlc.WarningText
	  ,dmlc.IsPep
      ,dmlc.AssessmentYear
      ,dmlc.AssessedIncome
      ,dmlc.IsBankrupt
      ,dmlc.LastRemarkDate
      ,dmlc.LastBankruptDate
      ,dmlc.TotalNumberOfMortgageRemarks
      ,dmlc.NumberOfMortgageRemarks
      ,dmlc.SumOfMortgageRemarks 
	  ,CASE 
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 0 AND (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) <= 18  THEN CAST('1-18' AS NVARCHAR(20))
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 18 AND (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) <= 29 THEN CAST('19-29' AS NVARCHAR(20))
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 29 AND (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) <= 39 THEN CAST('30-39' AS NVARCHAR(20))
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 39 AND (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) <= 49 THEN CAST('40-49' AS NVARCHAR(20))
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 49 AND (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) <= 64 THEN CAST('50-64' AS NVARCHAR(20))
			WHEN (DATEPART(YEAR, GETDATE()) - dmlc.BirthYear) > 64 THEN CAST('65 or more' AS NVARCHAR(20))
			ELSE CAST('N/A' AS NVARCHAR(20))
	   END Age
	   ,CASE
			WHEN dmlc.NumberOfRemarks > 0 THEN CAST('Ja' AS NVARCHAR(10)) 
			WHEN dmlc.NumberOfRemarks = 0 THEN CAST('Nej' AS NVARCHAR(10)) 
			ELSE CAST('N/A' AS NVARCHAR(10))
		END HasRemarks
FROM Fact.d_MLLoanCustomer dmlc
INNER JOIN Fact.b_MLLoanApplicationCustomer bmlac ON bmlac.MLLoanCustomer_key = dmlc.MLLoanCustomer_key