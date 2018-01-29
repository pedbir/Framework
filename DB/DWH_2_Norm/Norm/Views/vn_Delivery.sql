CREATE VIEW Norm.vn_Delivery AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Delivery_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Delivery)
							SELECT  t1.Delivery_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Delivery_bkey, t2.Agreement_bkey, t2.Geography_bkey, t2.Project_bkey, t2.DeliveryName, t2.SugarEnum_BusinessType_bkey, t2.Employee_ConstructionManager_bkey, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Delivery_bkey = t1.Delivery_bkey AND t2._isLast = 1