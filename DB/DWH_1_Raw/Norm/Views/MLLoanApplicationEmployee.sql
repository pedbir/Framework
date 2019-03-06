
CREATE VIEW Norm.MLLoanApplicationEmployee
AS
SELECT  rau.SysDatetimeDeletedUTC
       ,rau.SysModifiedUTC
       ,rau.SysValidFromDateTime
       ,rau.SysSrcGenerationDateTime
       ,MLLoanApplicationEmployee_bkey = CAST(rau.ApplicationUser_bkey + '#NO' AS NVARCHAR(100))
       ,MLLoanApplication_bkey         = CAST(rau.ApplicationId + '#NO' AS NVARCHAR(100))
       ,CustomerSupportEmployee_bkey   = CAST(rau.EmployeeID + '#NO' AS NVARCHAR(100))
       ,EmployeeRoleID                 = rau.OwnerRoleID
       ,EmployeeRole                   = rau.OwnerRole
FROM    (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY rau1.ApplicationUser_bkey ORDER BY rau1.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_ApplicationUser rau1) rau
OUTER APPLY (SELECT TOP 1 rla.PaidOutDate, rla.SysSrcGenerationDateTime FROM BamsNo_RawTyped.r_LoanApplication rla WHERE rla.LoanApplication_bkey = rau.ApplicationId ORDER BY rla.SysValidFromDateTime DESC) rla
WHERE rau._isFirst = 1 AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31' 
UNION ALL
SELECT  rau.SysDatetimeDeletedUTC
       ,rau.SysModifiedUTC
       ,rau.SysValidFromDateTime
       ,rau.SysSrcGenerationDateTime
       ,MLLoanApplicationEmployee_bkey = CAST(rau.ApplicationUser_bkey + '#SE'AS NVARCHAR(100))
       ,MLLoanApplication_bkey         = CAST(rau.ApplicationId + '#SE' AS NVARCHAR(100))
       ,CustomerSupportEmployee_bkey   = CAST(rau.EmployeeID + '#SE' AS NVARCHAR(100))
       ,EmployeeRoleID                 = rau.OwnerRoleID
       ,EmployeeRole                   = rau.OwnerRole
FROM    (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY rau1.ApplicationUser_bkey ORDER BY rau1.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_ApplicationUser rau1) rau
OUTER APPLY (SELECT TOP 1 rla.PaidOutDate, rla.SysSrcGenerationDateTime FROM BamsSe_RawTyped.r_LoanApplication rla WHERE rla.LoanApplication_bkey = rau.ApplicationId ORDER BY rla.SysValidFromDateTime DESC) rla
WHERE rau._isFirst = 1 AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31'