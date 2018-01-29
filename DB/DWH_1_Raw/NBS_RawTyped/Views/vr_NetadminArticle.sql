CREATE VIEW NBS_RawTyped.vr_NetadminArticle AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY NetadminArticle_bkey ORDER BY SysValidFromDateTime) FROM   NBS_RawTyped.r_NetadminArticle)
							SELECT  t1.NetadminArticle_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.NetadminArticle_bkey, t2.Service, t2.ServiceType, t2.MonthlyPrice, t2.StartPrice, t2.NoBill, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.NetadminArticle_bkey = t1.NetadminArticle_bkey AND t2._isLast = 1