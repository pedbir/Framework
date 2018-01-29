CREATE VIEW Sugar_RawTyped.vr_Mojlighet AS
							SELECT * 
							FROM (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Mojlighet_bkey ORDER BY SysValidFromDateTime) FROM   Sugar_RawTyped.r_Mojlighet) t 
							WHERE t._isLast = 1