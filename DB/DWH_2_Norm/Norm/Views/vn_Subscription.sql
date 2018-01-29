CREATE VIEW Norm.vn_Subscription AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Subscription_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Subscription)
							SELECT  t1.Subscription_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Subscription_bkey, t2.SubscriptionProduct_bkey, t2.ServiceProvider_bkey, t2.Access_bkey, t2.Calendar_Subscription_bkey, t2.Calendar_Purchase_bkey, t2.ResoposibleSalesEntity, t2.IsClosed, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Subscription_bkey = t1.Subscription_bkey AND t2._isLast = 1