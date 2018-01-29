CREATE VIEW Norm.vn_Geography AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Geography_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Geography)
							SELECT  t1.Geography_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Geography_bkey, t2.GeographyName, t2.SugarEnum_Municipality_bkey, t2.SugarEnum_State_bkey, t2.SugarEnum_Region_bkey, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Geography_bkey = t1.Geography_bkey AND t2._isLast = 1