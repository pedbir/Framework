CREATE VIEW Sugar_RawTyped.vr_Affarsmojlighet AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Affarsmojlighet_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Affarsmojlighet)
							SELECT  t1.Affarsmojlighet_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Affarsmojlighet_bkey, t2.Name, t2.Deleted, t2.OrdernummerCavaC, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Affarsmojlighet_bkey = t1.Affarsmojlighet_bkey AND t2._isLast = 1