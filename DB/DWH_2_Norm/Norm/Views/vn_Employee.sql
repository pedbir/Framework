CREATE VIEW Norm.vn_Employee AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Employee_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Employee)
							SELECT  t1.Employee_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Employee_bkey, t2.EmployeeName, t2.Title, t2.Department, t2.EmployeeStatus, t2.Username, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Employee_bkey = t1.Employee_bkey AND t2._isLast = 1