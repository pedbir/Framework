CREATE VIEW Netadmin_RawTyped.vr_Abonnemang AS
							SELECT * 
							FROM (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Abonnemang_bkey ORDER BY SysValidFromDateTime) FROM   Netadmin_RawTyped.r_Abonnemang) t 
							WHERE t._isLast = 1