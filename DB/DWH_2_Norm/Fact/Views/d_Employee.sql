CREATE VIEW Fact.d_Employee
AS

SELECT	ne.Employee_key
		, ne.SysDatetimeDeletedUTC
		, ne.SysModifiedUTC
		, ne.SysValidFromDateTime
		, ne.SysSrcGenerationDateTime
		, ne.Employee_bkey
		, EmployeeName = ISNULL(NULLIF(ne.EmployeeName, ''), 'Unknown')
		, Title = ISNULL(NULLIF(ne.Title, ''), 'Unknown')
		, Department = ISNULL(NULLIF(ne.Department, ''), 'Unknown')
		, EmployeeStatus = ISNULL(NULLIF(ne.EmployeeStatus, ''), 'Unknown')
		, EmployeeRoleCode = ISNULL(ne.EmployeeRoleCode, 'U')
		, EmployeeRoleName = ISNULL(ne.EmployeeRoleName, 'Unknown')
FROM	Norm.n_Employee ne