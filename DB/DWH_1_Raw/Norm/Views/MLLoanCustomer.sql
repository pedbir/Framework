

--BAMS NO
CREATE VIEW [Norm].[MLLoanCustomer]
AS
SELECT rc.SysDatetimeDeletedUTC
      ,rc.SysModifiedUTC
      ,rc.SysValidFromDateTime
      ,rc.SysSrcGenerationDateTime
      ,MLLoanCustomer_bkey = CAST(rc.Customer_bkey + '#BAMSNO' AS NVARCHAR(100))
      ,BirthYear  = CASE WHEN rc.BirthYear > DATEPART(YEAR, GETDATE()) THEN NULL ELSE rc.BirthYear END
	  ,rc.Gender
	  ,rc.City
      ,rc.Zip
      ,MaritalStatusCode = ISNULL(rc.MaritalStatusCode, '-1')
      ,MaritalStatusText = ISNULL(rc.MaritalStatusText, 'N/A')
      ,PriceLevelCode = ISNULL(rc.PriceLevelCODE, '-1')
      ,PriceLevelText = ISNULL(rc.PriceLevelText, 'N/A')
      ,RiskgroupCode = ISNULL(rc.RiskgroupCode, '-1')
      ,RiskgroupText = ISNULL (rc.RiskgroupText, 'N/A')
      ,DebtKFM = ISNULL(rc.DebtKFM, 0)
      ,AccomodationTypeCode = ISNULL(rc.AccomodationTypeCode, '-1')
	  ,AccomodationTypeText = ISNULL(rc.AccomodationTypeText, 'N/A')
      ,TotalNumberOfRemarks = ISNULL(rc.TotalNumberOfRemarks,0)
      ,NumberOfRemarks = ISNULL(rc.NumberOfRemarks, 0)
      ,TotalSumOfRemarks = ISNULL(rc.TotalSumOfRemarks,0)
      ,SumOfRemarks = ISNULL(rc.SumOfRemarks, 0)
      ,ISNULL(rc.PrenupDateString, 'N/A') PrenupDateString
      ,WarningCode = ISNULL(rc.WarningCode, '-1')
      ,WarningText = ISNULL(rc.WarningText,'N/A')
	  ,IsPep = ISNULL(rc.IsPep,0)
      ,rc.AssessmentYear
      ,rc.AssessedIncome
      ,IsBankrupt = ISNULL(rc.IsBankrupt,0)
      ,rc.LastRemarkDate
      ,rc.LastBankruptDate
      ,TotalNumberOfMortgageRemarks = ISNULL(rc.TotalNumberOfMortgageRemarks,0)
      ,NumberOfMortgageRemarks = ISNULL(rc.NumberOfMortgageRemarks,0)
      ,SumOfMortgageRemarks = ISNULL(rc.SumOfMortgageRemarks,0)
FROM BamsNo_RawTyped.r_Customer rc
WHERE rc.Customer_bkey <> '-1'
UNION ALL
--BAMS SE
SELECT rc.SysDatetimeDeletedUTC
      ,rc.SysModifiedUTC
      ,rc.SysValidFromDateTime
      ,rc.SysSrcGenerationDateTime
      ,MLLoanCustomer_bkey = CAST(rc.Customer_bkey + '#BAMSSE' AS NVARCHAR(100))
      ,BirthYear  = CASE WHEN rc.BirthYear > DATEPART(YEAR, GETDATE()) THEN NULL ELSE rc.BirthYear END
	  ,rc.Gender
	  ,rc.City
      ,rc.Zip
      ,MaritalStatusCode = ISNULL(rc.MaritalStatusCode, '-1')
      ,MaritalStatusText = ISNULL(rc.MaritalStatusText, 'N/A')
      ,PriceLevelCode = ISNULL(rc.PriceLevelCODE, '-1')
      ,PriceLevelText = ISNULL(rc.PriceLevelText, 'N/A')
      ,RiskgroupCode = ISNULL(rc.RiskgroupCode, '-1')
      ,RiskgroupText = ISNULL (rc.RiskgroupText, 'N/A')
      ,DebtKFM = ISNULL(rc.DebtKFM, 0)
      ,AccomodationTypeCode = ISNULL(rc.AccomodationTypeCode, '-1')
	  ,AccomodationTypeText = ISNULL(rc.AccomodationTypeText, 'N/A')
      ,TotalNumberOfRemarks = ISNULL(rc.TotalNumberOfRemarks,0)
      ,NumberOfRemarks = ISNULL(rc.NumberOfRemarks, 0)
      ,TotalSumOfRemarks = ISNULL(rc.TotalSumOfRemarks,0)
      ,SumOfRemarks = ISNULL(rc.SumOfRemarks, 0)
      ,ISNULL(rc.PrenupDateString, 'N/A') PrenupDateString
      ,WarningCode = ISNULL(rc.WarningCode, '-1')
      ,WarningText = ISNULL(rc.WarningText,'N/A')
	  ,IsPep = ISNULL(rc.IsPep,0)
      ,rc.AssessmentYear
      ,rc.AssessedIncome
      ,IsBankrupt = ISNULL(rc.IsBankrupt,0)
      ,rc.LastRemarkDate
      ,rc.LastBankruptDate
      ,TotalNumberOfMortgageRemarks = ISNULL(rc.TotalNumberOfMortgageRemarks,0)
      ,NumberOfMortgageRemarks = ISNULL(rc.NumberOfMortgageRemarks,0)
      ,SumOfMortgageRemarks = ISNULL(rc.SumOfMortgageRemarks,0)
FROM BamsSe_RawTyped.r_Customer rc
WHERE rc.Customer_bkey <> '-1'
UNION ALL
--OPOC NO
SELECT roc.SysDatetimeDeletedUTC
      ,roc.SysModifiedUTC
      ,roc.SysValidFromDateTime
      ,roc.SysSrcGenerationDateTime
      ,MLLoanCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOCNO' AS NVARCHAR(100))
      ,BirthYear  = CASE WHEN roc.BirthYear > DATEPART(YEAR, GETDATE()) THEN NULL ELSE roc.BirthYear END
	  ,roc.Gender
	  ,roc.City
      ,roc.Zip
      ,MaritalStatusCode = ISNULL(roc.MaritalStatusCode, '-1')
      ,MaritalStatusText = ISNULL(roc.MaritalStatusText, 'N/A')
      ,PriceLevelCode = ISNULL(roc.PriceLevelCODE, '-1')
      ,PriceLevelText = ISNULL(roc.PriceLevelText, 'N/A')
      ,RiskgroupCode = ISNULL(roc.RiskgroupCode, '-1')
      ,RiskgroupText = ISNULL (roc.RiskgroupText, 'N/A')
      ,DebtKFM = ISNULL(roc.DebtKFM, 0)
      ,AccomodationTypeCode = ISNULL(roc.AccomodationTypeCode, '-1')
	  ,AccomodationTypeText = ISNULL(roc.AccomodationTypeText, 'N/A')
      ,TotalNumberOfRemarks = ISNULL(roc.TotalNumberOfRemarks,0)
      ,NumberOfRemarks = ISNULL(roc.NumberOfRemarks, 0)
      ,TotalSumOfRemarks = ISNULL(roc.TotalSumOfRemarks,0)
      ,SumOfRemarks = ISNULL(roc.SumOfRemarks, 0)
      ,ISNULL(roc.PrenupDateString, 'N/A') PrenupDateString
      ,WarningCode = ISNULL(roc.WarningCode, '-1')
      ,WarningText = ISNULL(roc.WarningText,'N/A')
	  ,IsPep = ISNULL(roc.IsPep,0)
      ,roc.AssessmentYear
      ,roc.AssessedIncome
      ,IsBankrupt = ISNULL(roc.IsBankrupt,0)
      ,roc.LastRemarkDate
      ,roc.LastBankruptDate
      ,TotalNumberOfMortgageRemarks = ISNULL(roc.TotalNumberOfMortgageRemarks,0)
      ,NumberOfMortgageRemarks = ISNULL(roc.NumberOfMortgageRemarks,0)
      ,SumOfMortgageRemarks = ISNULL(roc.SumOfMortgageRemarks,0)
FROM BamsNo_RawTyped.r_OpocCustomer roc
WHERE roc.OpocCustomer_bkey <> '-1'
UNION ALL
--OPOC SE
SELECT roc.SysDatetimeDeletedUTC
      ,roc.SysModifiedUTC
      ,roc.SysValidFromDateTime
      ,roc.SysSrcGenerationDateTime
      ,MLLoanCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOCSE' AS NVARCHAR(100))
      ,BirthYear  = CASE WHEN roc.BirthYear > DATEPART(YEAR, GETDATE()) THEN NULL ELSE roc.BirthYear END
	  ,roc.Gender
	  ,roc.City
      ,roc.Zip
      ,MaritalStatusCode = ISNULL(roc.MaritalStatusCode, '-1')
      ,MaritalStatusText = ISNULL(roc.MaritalStatusText, 'N/A')
      ,PriceLevelCode = ISNULL(roc.PriceLevelCODE, '-1')
      ,PriceLevelText = ISNULL(roc.PriceLevelText, 'N/A')
      ,RiskgroupCode = ISNULL(roc.RiskgroupCode, '-1')
      ,RiskgroupText = ISNULL (roc.RiskgroupText, 'N/A')
      ,DebtKFM = ISNULL(roc.DebtKFM, 0)
      ,AccomodationTypeCode = ISNULL(roc.AccomodationTypeCode, '-1')
	  ,AccomodationTypeText = ISNULL(roc.AccomodationTypeText, 'N/A')
      ,TotalNumberOfRemarks = ISNULL(roc.TotalNumberOfRemarks,0)
      ,NumberOfRemarks = ISNULL(roc.NumberOfRemarks, 0)
      ,TotalSumOfRemarks = ISNULL(roc.TotalSumOfRemarks,0)
      ,SumOfRemarks = ISNULL(roc.SumOfRemarks, 0)
      ,ISNULL(roc.PrenupDateString, 'N/A') PrenupDateString
      ,WarningCode = ISNULL(roc.WarningCode, '-1')
      ,WarningText = ISNULL(roc.WarningText,'N/A')
	  ,IsPep = ISNULL(roc.IsPep,0)
      ,roc.AssessmentYear
      ,roc.AssessedIncome
      ,IsBankrupt = ISNULL(roc.IsBankrupt,0)
      ,roc.LastRemarkDate
      ,roc.LastBankruptDate
      ,TotalNumberOfMortgageRemarks = ISNULL(roc.TotalNumberOfMortgageRemarks,0)
      ,NumberOfMortgageRemarks = ISNULL(roc.NumberOfMortgageRemarks,0)
      ,SumOfMortgageRemarks = ISNULL(roc.SumOfMortgageRemarks,0)
FROM BamsSe_RawTyped.r_OpocCustomer roc
WHERE roc.OpocCustomer_bkey <> '-1'