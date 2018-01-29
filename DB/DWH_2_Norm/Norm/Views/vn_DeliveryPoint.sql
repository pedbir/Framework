CREATE VIEW Norm.vn_DeliveryPoint AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY DeliveryPoint_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_DeliveryPoint)
							SELECT  t1.DeliveryPoint_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.DeliveryPoint_bkey, t2.Delivery_bkey, t2.Access_bkey, t2.Address_bkey, t2.DeliveryPointName, t2.CustomerType, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.DeliveryPoint_bkey = t1.DeliveryPoint_bkey AND t2._isLast = 1