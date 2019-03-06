CREATE VIEW Norm.MLLoanApplicationStatus
AS


SELECT 	SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysDatetimeDeletedUTC = CAST(NULL AS DATETIME2(0))
		,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))	
		,MLLoanApplicationStatus_bkey = CAST(rlas.StatusID + '#SE' AS NVARCHAR(100))
		,MLLoanApplicationStatus = rlas.StatusName
FROM (SELECT rlas.StatusID, rlas.StatusName, _isFirst = LAG(0,1,1) OVER (PARTITION BY rlas.StatusID ORDER BY rlas.SysValidFromDateTime DESC)  FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas) rlas
WHERE rlas._isFirst = 1 AND rlas.StatusID <> 'N/A'
UNION ALL
SELECT 	SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))
		,SysDatetimeDeletedUTC = CAST(NULL AS DATETIME2(0))
		,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))	
		,MLLoanApplicationStatus_bkey = CAST(rlas.StatusID + '#NO' AS NVARCHAR(100))
		,MLLoanApplicationStatus = rlas.StatusName
FROM (SELECT rlas.StatusID, rlas.StatusName, _isFirst = LAG(0,1,1) OVER (PARTITION BY rlas.StatusID ORDER BY rlas.SysValidFromDateTime DESC)  FROM BamsNo_RawTyped.r_LoanApplicationStatus rlas) rlas
WHERE rlas._isFirst = 1 AND rlas.StatusID <> 'N/A'