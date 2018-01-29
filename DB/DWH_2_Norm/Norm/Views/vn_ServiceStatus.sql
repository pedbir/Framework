CREATE VIEW Norm.vn_ServiceStatus AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY ServiceStatus_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_ServiceStatus)
							SELECT  t1.ServiceStatus_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.ServiceStatus_bkey, t2.ServiceStatus, t2.RegardAsActive, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.ServiceStatus_bkey = t1.ServiceStatus_bkey AND t2._isLast = 1