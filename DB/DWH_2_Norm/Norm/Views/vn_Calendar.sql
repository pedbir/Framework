CREATE VIEW Norm.vn_Calendar AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Calendar_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Calendar)
							SELECT  t1.Calendar_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Calendar_bkey, t2.CalendarDate, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Calendar_bkey = t1.Calendar_bkey AND t2._isLast = 1