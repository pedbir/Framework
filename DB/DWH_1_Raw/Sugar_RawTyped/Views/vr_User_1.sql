CREATE VIEW Sugar_RawTyped.vr_User AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY User_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_User)
							SELECT  t1.User_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.User_bkey, t2.Username, t2.Deleted, t2.FirstName, t2.LastName, t2.Title, t2.Department, t2.EmployeeStatus, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.User_bkey = t1.User_bkey AND t2._isLast = 1