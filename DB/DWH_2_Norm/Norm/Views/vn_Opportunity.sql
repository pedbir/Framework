CREATE VIEW Norm.vn_Opportunity AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Opportunity_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Opportunity)
							SELECT  t1.Opportunity_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Opportunity_bkey, t2.Area_bkey, t2.Access_bkey, t2.Address_bkey, t2.Employee_SalesResponsible_bkey, t2.OpportunityName, t2.SugarEnum_BusinessType_bkey, t2.CustomerType, t2.Fastighetsbeteckningc, t2.AcquiredAccess, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Opportunity_bkey = t1.Opportunity_bkey AND t2._isLast = 1