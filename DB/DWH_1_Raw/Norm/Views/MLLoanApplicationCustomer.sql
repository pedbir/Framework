CREATE VIEW Norm.MLLoanApplicationCustomer
AS

--BAMS NO
SELECT rac.SysDatetimeDeletedUTC
      ,rac.SysModifiedUTC
      ,rac.SysValidFromDateTime
      ,rac.SysSrcGenerationDateTime
	  ,MLLoanApplicationCustomer_bkey = CAST(rac.ApplicationCustomer_bkey + '#BAMS' AS NVARCHAR(100))
	  ,MLLoanCustomer_bkey = CAST(rac.CustomerId + '#BAMSNO' AS NVARCHAR(100))
	  ,MLLoanApplication_bkey = CAST(rac.ApplicationId + '#NO' AS NVARCHAR(100))
      ,rac.IsMainApplicant
	  ,CustomerSource = CAST('BAMSNO' AS NVARCHAR(50))
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY rac.ApplicationCustomer_bkey ORDER BY rac.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_ApplicationCustomer rac) rac
OUTER APPLY (SELECT TOP 1 rla.PaidOutDate, rla.SysSrcGenerationDateTime FROM BamsNo_RawTyped.r_LoanApplication rla WHERE rla.LoanApplication_bkey = rac.ApplicationId ORDER BY rla.SysValidFromDateTime DESC) rla
WHERE rac._isFirst = 1 AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31' 
UNION ALL
--BAMS SE
SELECT rac.SysDatetimeDeletedUTC
      ,rac.SysModifiedUTC
      ,rac.SysValidFromDateTime
      ,rac.SysSrcGenerationDateTime
	  ,MLLoanApplicationCustomer_bkey = CAST(rac.ApplicationCustomer_bkey + '#BAMS' AS NVARCHAR(100))
	  ,MLLoanCustomer_bkey = CAST(rac.CustomerId + '#BAMSSE' AS NVARCHAR(100))
	  ,MLLoanApplication_bkey = CAST(rac.ApplicationId + '#SE' AS NVARCHAR(100))
      ,rac.IsMainApplicant
	  ,CustomerSource = CAST('BAMSSE' AS NVARCHAR(50))
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY rac.ApplicationCustomer_bkey ORDER BY rac.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_ApplicationCustomer rac) rac
OUTER APPLY (SELECT TOP 1 rla.PaidOutDate, rla.SysSrcGenerationDateTime FROM BamsSe_RawTyped.r_LoanApplication rla WHERE rla.LoanApplication_bkey = rac.ApplicationId ORDER BY rla.SysValidFromDateTime DESC) rla
WHERE rac._isFirst = 1 AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31' 
UNION ALL
--OPOC NO
SELECT roc.SysDatetimeDeletedUTC
      ,roc.SysModifiedUTC
      ,roc.SysValidFromDateTime
      ,roc.SysSrcGenerationDateTime
	  ,MLLoanApplicationCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOC' AS NVARCHAR(100))
	  ,MLLoanCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOCNO' AS NVARCHAR(100))
	  ,MLLoanApplication_bkey = CAST(roc.ApplicationId + '#NO' AS NVARCHAR(100))
      ,roc.IsMainApplicant
	  ,CustomerSource = CAST('OPOCNO' AS NVARCHAR(50))
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY roc.OpocCustomer_bkey ORDER BY roc.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_OpocCustomer roc) roc
OUTER APPLY (SELECT TOP 1 rola.SysSrcGenerationDateTime, rola.OPOCProduct, rola.OpocLoanApplication_bkey FROM BamsNo_RawTyped.r_OpocLoanApplication rola WHERE rola.OpocLoanApplication_bkey = roc.ApplicationId ORDER BY rola.SysValidFromDateTime DESC) rola
WHERE roc._isFirst = 1 AND rola.SysSrcGenerationDateTime > '2016-12-31'
UNION ALL
--OPOC SE
SELECT roc.SysDatetimeDeletedUTC
      ,roc.SysModifiedUTC
      ,roc.SysValidFromDateTime
      ,roc.SysSrcGenerationDateTime
	  ,MLLoanApplicationCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOC' AS NVARCHAR(100))
	  ,MLLoanCustomer_bkey = CAST(roc.OpocCustomer_bkey + '#OPOCSE' AS NVARCHAR(100))
	  ,MLLoanApplication_bkey = CAST(roc.ApplicationId + '#SE' AS NVARCHAR(100))
      ,roc.IsMainApplicant
	  ,CustomerSource = CAST('OPOCSE' AS NVARCHAR(50))
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY roc.OpocCustomer_bkey ORDER BY roc.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocCustomer roc) roc
OUTER APPLY (SELECT TOP 1 rola.SysSrcGenerationDateTime, rola.OPOCProduct, rola.OpocLoanApplication_bkey FROM BamsSe_RawTyped.r_OpocLoanApplication rola WHERE rola.OpocLoanApplication_bkey = roc.ApplicationId ORDER BY rola.SysValidFromDateTime DESC) rola
WHERE roc._isFirst = 1 AND rola.SysSrcGenerationDateTime > '2016-12-31' AND rola.OPOCProduct IN ( 'Bostadslån' )