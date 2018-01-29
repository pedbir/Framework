CREATE VIEW Norm.vn_Address AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Address_bkey ORDER BY SysValidFromDateTime) FROM   Norm.n_Address)
							SELECT  t1.Address_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysDatetimeReprocessedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Address_bkey, t2.SysSource, t2.StreetName, t2.StreetNumber, t2.PostalCode, t2.PostalCity, t2.CountryCode, t2.Latitude, t2.Longitude, t2.Estate_bkey, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Address_bkey = t1.Address_bkey AND t2._isLast = 1