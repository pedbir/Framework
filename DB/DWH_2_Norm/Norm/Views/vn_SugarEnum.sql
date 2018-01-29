CREATE VIEW Norm.vn_SugarEnum AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY SugarEnum_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_SugarEnum)
							SELECT  t1.SugarEnum_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.SugarEnum_bkey, t2.FieldValue, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.SugarEnum_bkey = t1.SugarEnum_bkey AND t2._isLast = 1