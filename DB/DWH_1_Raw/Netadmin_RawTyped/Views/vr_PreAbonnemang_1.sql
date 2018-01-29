CREATE VIEW Netadmin_RawTyped.vr_PreAbonnemang AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY PreAbonnemang_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_PreAbonnemang)
							SELECT  t1.PreAbonnemang_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.PreAbonnemang_bkey, t2.Preinkopldat, t2.Preurkopldat, t2.Preadrid, t2.Pretmpid, t2.Preartnr, t2.Prestartartnr, t2.aboisp, t2.abostartdat, t2.aboansvarig, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.PreAbonnemang_bkey = t1.PreAbonnemang_bkey AND t2._isLast = 1