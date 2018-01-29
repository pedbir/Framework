CREATE VIEW Norm.vn_Access AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Access_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Access)
							SELECT  t1.Access_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Access_bkey, t2.Calendar_Installed_bkey, t2.AccessCategory_Lvl1_bkey, t2.AccessCategory_Lvl2_bkey, t2.AccessCategory_Lvl3_bkey, t2.AccessCategory_Lvl4_bkey, t2.AccessCategory_Lvl5_bkey, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Access_bkey = t1.Access_bkey AND t2._isLast = 1