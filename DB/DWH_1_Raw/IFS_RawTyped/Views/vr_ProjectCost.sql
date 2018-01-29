CREATE VIEW IFS_RawTyped.vr_ProjectCost AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY ProjectCost_bkey ORDER BY SysValidFromDateTime) FROM   IFS_RawTyped.r_ProjectCost)
							SELECT  t1.ProjectCost_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.ProjectCost_bkey, t2.ProjectID, t2.ControlCategory, t2.Estimated, t2.Baseline, t2.Used, t2.Áctual, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.ProjectCost_bkey = t1.ProjectCost_bkey AND t2._isLast = 1