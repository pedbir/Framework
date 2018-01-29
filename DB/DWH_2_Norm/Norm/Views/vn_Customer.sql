CREATE VIEW Norm.vn_Customer AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Customer_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Customer)
							SELECT  t1.Customer_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Customer_bkey, t2.CustomerName, t2.PersonalIdentityNumber, t2.OrganizationNumber, t2.Age, t2.Gender, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Customer_bkey = t1.Customer_bkey AND t2._isLast = 1