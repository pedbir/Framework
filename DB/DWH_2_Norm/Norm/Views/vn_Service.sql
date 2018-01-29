CREATE VIEW Norm.vn_Service AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Service_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Service)
							SELECT  t1.Service_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Service_bkey, t2.ServiceNameShort, t2.ServiceName, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Service_bkey = t1.Service_bkey AND t2._isLast = 1