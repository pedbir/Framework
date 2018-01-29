CREATE VIEW Netadmin_RawTyped.vr_Isp AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Isp_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_Isp)
							SELECT  t1.Isp_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Isp_bkey, t2.ispnamn, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Isp_bkey = t1.Isp_bkey AND t2._isLast = 1