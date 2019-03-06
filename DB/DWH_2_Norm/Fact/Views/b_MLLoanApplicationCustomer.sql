CREATE VIEW Fact.b_MLLoanApplicationCustomer
AS
SELECT nmlac.SysDatetimeDeletedUTC
      ,nmlac.SysModifiedUTC
      ,nmlac.SysValidFromDateTime
      ,nmlac.SysSrcGenerationDateTime
	  ,MLLoanApplicationCustomer_key = nmlac.MLLoanApplicationCustomer_bkey	
	  ,nmlac.MLLoanApplication_bkey
	  ,nmlac.MLLoanCustomer_bkey
      ,nmla.MLLoanApplication_key
	  ,nmlc.MLLoanCustomer_key
      ,nmlac.IsMainApplicant 
	  ,nmlac.CustomerSource
FROM (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmlac.MLLoanApplicationCustomer_bkey ORDER BY nmlac.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplicationCustomer nmlac) nmlac
LEFT JOIN (SELECT nmlc.MLLoanCustomer_key, nmlc.MLLoanCustomer_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmlc.MLLoanCustomer_bkey ORDER BY nmlc.SysValidFromDateTime DESC) FROM Norm.n_MLLoanCustomer nmlc) nmlc ON nmlc.MLLoanCustomer_bkey = nmlac.MLLoanCustomer_bkey AND nmlc._isFirst = 1
LEFT JOIN (SELECT nmla.MLLoanApplication_key, nmla.MLLoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmla.MLLoanApplication_bkey ORDER BY nmla.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplication nmla) nmla ON nmlac.MLLoanApplication_bkey = nmla.MLLoanApplication_bkey AND nmla._isFirst = 1
WHERE nmlac._isFirst = 1