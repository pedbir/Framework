CREATE VIEW IFS_RawTyped.vr_Project AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Project_bkey ORDER BY SysValidFromDateTime) FROM   IFS_RawTyped.r_Project)
							SELECT  t1.Project_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Project_bkey, t2.Name, t2.ProgramID, t2.Category1ID, t2.Category2ID, t2.ObjState, t2.PlanFinish, t2.CloseDate, t2.NumOfHP, t2.NumOfHC, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Project_bkey = t1.Project_bkey AND t2._isLast = 1