CREATE VIEW Cava_RawTyped.vr_Customer AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Customer_bkey ORDER BY SysValidFromDateTime) FROM   Cava_RawTyped.r_Customer)
							SELECT  t1.Customer_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Customer_bkey, t2.FullName, t2.OrgNo, t2.SuperOfficeUser, t2.SegmentID, t2.MasterSystemID, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Customer_bkey = t1.Customer_bkey AND t2._isLast = 1