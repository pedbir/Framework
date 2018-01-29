CREATE VIEW Norm.vn_Agreement AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Agreement_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Agreement)
							SELECT  t1.Agreement_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Agreement_bkey, t2.Customer_bkey, t2.Employee_SalesPerson_bkey, t2.AgreementType_bkey, t2.OrderNumber, t2.AgreementDate, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Agreement_bkey = t1.Agreement_bkey AND t2._isLast = 1