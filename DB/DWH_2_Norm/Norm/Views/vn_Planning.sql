CREATE VIEW Norm.vn_Planning AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Planning_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Planning)
							SELECT  t1.Planning_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Planning_bkey, t2.Scenario_bkey, t2.Phase_bkey, t2.CustomerCategory_bkey, t2.P01, t2.P02, t2.P03, t2.P04, t2.P05, t2.P06, t2.P07, t2.P08, t2.P09, t2.P10, t2.P11, t2.P12, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Planning_bkey = t1.Planning_bkey AND t2._isLast = 1