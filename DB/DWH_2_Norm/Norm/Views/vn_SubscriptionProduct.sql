CREATE VIEW Norm.vn_SubscriptionProduct AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY SubscriptionProduct_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_SubscriptionProduct)
							SELECT  t1.SubscriptionProduct_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.SubscriptionProduct_bkey, t2.SubscriptionProduct, t2.SubscriptionProductType, t2.MonthlyPrice, t2.StartPrice, t2.Billable, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.SubscriptionProduct_bkey = t1.SubscriptionProduct_bkey AND t2._isLast = 1