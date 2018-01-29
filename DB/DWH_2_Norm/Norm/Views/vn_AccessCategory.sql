CREATE VIEW Norm.vn_AccessCategory AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY AccessCategory_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_AccessCategory)
							SELECT  t1.AccessCategory_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.AccessCategory_bkey, t2.AccessCategory, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.AccessCategory_bkey = t1.AccessCategory_bkey AND t2._isLast = 1