CREATE VIEW Sugar_RawTyped.vr_Contact AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Contact_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Contact)
							SELECT  t1.Contact_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Contact_bkey, t2.deleted, t2.FirstName, t2.LastName, t2.Title, t2.ContactDescription, t2.AssignedUserId, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Contact_bkey = t1.Contact_bkey AND t2._isLast = 1