CREATE VIEW Sugar_RawTyped.vr_Enum AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Enum_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Enum)
							SELECT  t1.Enum_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Enum_bkey, t2.ModuleName, t2.ModuleField, t2.FieldKey, t2.FieldValue, t2.Deleted, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Enum_bkey = t1.Enum_bkey AND t2._isLast = 1