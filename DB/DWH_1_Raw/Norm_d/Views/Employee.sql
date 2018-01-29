CREATE VIEW Norm_d.Employee
AS
WITH temp AS
(
	SELECT	t.SysDatetimeDeletedUTC
			, t.SysModifiedUTC
			, t.SysValidFromDateTime
			, t.SysSrcGenerationDateTime
			, t.Employee_bkey
			, EmployeeName	= ISNULL(NULLIF(t.EmployeeName, ''), 'N/A')
			, Title			= ISNULL(NULLIF(t.Title, ''), 'N/A')
			, Department	= ISNULL(NULLIF(t.Department, ''), 'N/A')
			, EmployeeStatus =	ISNULL(NULLIF(t.EmployeeStatus, ''), 'N/A')
			, t.Username
	FROM	(	SELECT	SysDatetimeDeletedUTC	= CAST(CASE WHEN vu.Deleted = 1 THEN vu.SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
						, vu.SysModifiedUTC
						, vu.SysValidFromDateTime
						, vu.SysSrcGenerationDateTime
						, Employee_bkey		= CAST(vu.User_bkey AS NVARCHAR(100))
						, EmployeeName		= CAST(vu.FirstName + ' ' + vu.LastName AS NVARCHAR(150))
						, Title				= CAST(vu.Title AS NVARCHAR(50))
						, Department		= CAST(vu.Department AS NVARCHAR(50))
						, EmployeeStatus	= CAST(vu.EmployeeStatus AS NVARCHAR(100))
						, Username			= UPPER(CAST(vu.Username AS NVARCHAR(100)))
				FROM	Sugar_RawTyped.vr_User vu
				WHERE	vu._isLast		= 1
						AND vu.User_key <> -1
				UNION ALL
				SELECT		SysDatetimeDeletedUTC	= CAST(CASE WHEN rc.deleted = 1 THEN rc.SysValidFromDateTime ELSE NULL END AS DATETIME2(0))
							, rc.SysModifiedUTC
							, rc.SysValidFromDateTime
							, rc.SysSrcGenerationDateTime
							, Employee_bkey		= CAST(rc.Contact_bkey AS NVARCHAR(100))
							, EmployeeName		= CAST(rc.FirstName + ' ' + rc.LastName AS NVARCHAR(150))
							, Title				= CAST(rc.Title AS NVARCHAR(50))
							, Department		= CAST(ISNULL(vu.Department, rc.ContactDescription) AS NVARCHAR(50))
							, EmployeeStatus	= CAST(ISNULL(vu.EmployeeStatus, 'NotEmployed') AS NVARCHAR(100))
							, Username			= CAST(NULL AS NVARCHAR(100))
				FROM		Sugar_RawTyped.vr_Contact					rc
				OUTER APPLY (	SELECT		TOP 1 *
								FROM		Sugar_RawTyped.vr_User vu
								WHERE		vu.User_bkey = rc.AssignedUserId
								ORDER BY	vu.SysValidFromDateTime DESC) vu
				WHERE		rc._isLast			= 1
							AND rc.Contact_bkey <> '-1') t
	UNION ALL
	SELECT	rnu.SysDatetimeDeletedUTC
			, rnu.SysModifiedUTC
			, rnu.SysValidFromDateTime
			, rnu.SysSrcGenerationDateTime
			, Employee_bkey = UPPER(rnu.NDBUser_bkey)
			, EmployeeName	= CAST(ISNULL(rnu.FirstName, '') + ' ' + ISNULL(rnu.LastName, '') AS NVARCHAR(150))
			, Title			= CAST(ISNULL(rnu.Title, 'N/A') AS NVARCHAR(50))
			, Department	= CAST(ISNULL(rnu.Department, 'N/A') AS NVARCHAR(50))
			, EmployeeStatus =	CAST(IIF(rnu.Active = 1, 'Active', 'Terminated') AS NVARCHAR(100))
			, Username		= UPPER(CAST(rnu.NDBUser_bkey AS NVARCHAR(100)))
	FROM	Cava_RawTyped.r_NDBUser rnu
)
SELECT		t.SysDatetimeDeletedUTC
			, t.SysModifiedUTC
			, t.SysValidFromDateTime
			, t.SysSrcGenerationDateTime
			, t.Employee_bkey
			, t.EmployeeName
			, t.Title
			, t.Department
			, t.EmployeeStatus
			, t.Username
			, EmployeeRoleName = COALESCE(o2.EmployeeRoleName, o3.EmployeeRoleName, o1.EmployeeRoleName, o4.EmployeeRoleName, o5.EmployeeRoleName, o6.EmployeeRoleName, 'Other')
			, EmployeeRoleCode = COALESCE(o2.EmployeeRoleCode, o3.EmployeeRoleCode, o1.EmployeeRoleCode, o4.EmployeeRoleCode, o5.EmployeeRoleCode, o6.EmployeeRoleCode, 'O')
FROM		temp										t
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Construction Manager'
							, EmployeeRoleCode	= 'CM'
				FROM		Sugar_RawTyped.r_Omrade o
				WHERE		o.UsersIpOmrade1UsersIda = t.Employee_bkey
				ORDER BY	o.SysValidFromDateTime DESC) o1
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Delivery Stream Leader'
							, EmployeeRoleCode	= 'DSL'
				FROM		Sugar_RawTyped.r_Omrade o
				WHERE		o.Userid3c = t.Employee_bkey
				ORDER BY	o.SysValidFromDateTime DESC) o2
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Regional Construction Manager'
							, EmployeeRoleCode	= 'RCM'
				FROM		Sugar_RawTyped.r_Omrade o
				WHERE		o.Userid2c = t.Employee_bkey
				ORDER BY	o.SysValidFromDateTime DESC) o3
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Sales Rep'
							, EmployeeRoleCode	= 'SR'
				FROM		Sugar_RawTyped.r_Mojlighet rm
				WHERE		rm.ContactsIpMojligheter1ContactsIda = t.Employee_bkey
				ORDER BY	rm.SysValidFromDateTime DESC) o4
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Sales Rep'
							, EmployeeRoleCode	= 'SR'
				FROM		Cava_RawTyped.r_Order o
				WHERE		o.Salesuser = Employee_bkey
				ORDER BY	o.SysValidFromDateTime DESC) o5
OUTER APPLY (	SELECT		TOP 1 EmployeeRoleName = 'Construction Manager'
							, EmployeeRoleCode	= 'CM'
				FROM		Sugar_RawTyped.r_Leveransobjekt rl
				WHERE		rl.Contactsipleveransobjekt2contactsida = Employee_bkey
				ORDER BY	rl.SysValidFromDateTime DESC) o6
WHERE		t.Employee_bkey <> '-1'