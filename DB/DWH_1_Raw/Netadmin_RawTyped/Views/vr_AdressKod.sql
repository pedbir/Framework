CREATE VIEW Netadmin_RawTyped.vr_AdressKod AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY AdressKod_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_AdressKod)
							SELECT  t1.AdressKod_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.AdressKod_bkey, t2.kodnamn, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.AdressKod_bkey = t1.AdressKod_bkey AND t2._isLast = 1