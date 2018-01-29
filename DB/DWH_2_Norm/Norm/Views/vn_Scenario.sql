CREATE VIEW Norm.vn_Scenario AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Scenario_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Scenario)
							SELECT  t1.Scenario_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Scenario_bkey, t2.ScenarioName, t2.ScenarioCategoryCode, t2.ScenarioCategoryName, t2.ScenarioSubCategoryCode, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Scenario_bkey = t1.Scenario_bkey AND t2._isLast = 1