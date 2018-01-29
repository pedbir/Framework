CREATE VIEW Netadmin_RawTyped.vr_Adress AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Adress_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_Adress)
							SELECT  t1.Adress_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Adress_bkey, t2.adrkomid, t2.adrgatid, t2.adrnrid, t2.adrupgid, t2.adrpostid, t2.adrortid, t2.ipo_installed_date, t2.adrkodid1, t2.adrkodid2, t2.adrkodid3, t2.adrkodid4, t2.adrkodid5, t2.adridentitet, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Adress_bkey = t1.Adress_bkey AND t2._isLast = 1