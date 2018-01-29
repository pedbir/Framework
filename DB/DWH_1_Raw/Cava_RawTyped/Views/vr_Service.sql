CREATE VIEW Cava_RawTyped.vr_Service AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Service_bkey ORDER BY SysValidFromDateTime) FROM   Cava_RawTyped.r_Service)
							SELECT  t1.Service_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Service_bkey, t2.Name, t2.ServiceSwe, t2.ServiceEng, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Service_bkey = t1.Service_bkey AND t2._isLast = 1