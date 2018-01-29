CREATE VIEW Netadmin_RawTyped.vr_Abonnemang AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Abonnemang_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_Abonnemang)
							SELECT  t1.Abonnemang_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Abonnemang_bkey, t2.abostartdat, t2.aboinkopldat, t2.aboadressdbid, t2.abotmpid, t2.aboartnr, t2.abostartartnr, t2.aboisp, t2.aboansvarig, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Abonnemang_bkey = t1.Abonnemang_bkey AND t2._isLast = 1