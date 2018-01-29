CREATE VIEW Cava_RawTyped.vr_AgreementType AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY AgreementType_bkey ORDER BY SysValidFromDateTime) FROM   Cava_RawTyped.r_AgreementType)
							SELECT  t1.AgreementType_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.AgreementType_bkey, t2.AgreementType, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.AgreementType_bkey = t1.AgreementType_bkey AND t2._isLast = 1