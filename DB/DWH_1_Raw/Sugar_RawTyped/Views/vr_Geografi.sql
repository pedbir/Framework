CREATE VIEW Sugar_RawTyped.vr_Geografi AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Geografi_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Geografi)
							SELECT  t1.Geografi_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Geografi_bkey, t2.Name, t2.Deleted, t2.Kommunc, t2.Lanc, t2.Regionc, t2.Stadc, t2.Stadsnatc, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Geografi_bkey = t1.Geografi_bkey AND t2._isLast = 1