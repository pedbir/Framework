CREATE VIEW Sugar_RawTyped.vr_Bestallning AS
							SELECT * 
							FROM (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Bestallning_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Bestallning) t 
							WHERE t._isLast = 1