CREATE VIEW Fact.d_Access
AS

SELECT na.Access_key
		 , na.SysDatetimeDeletedUTC
		 , na.SysModifiedUTC
		 , na.SysIsInferred
		 , na.SysValidFromDateTime
		 , na.Access_bkey
		 , na.Calendar_Installed_bkey
		 , na.AccessCategory_Lvl1_bkey
		 , na.AccessCategory_Lvl2_bkey
		 , na.AccessCategory_Lvl3_bkey
		 , na.AccessCategory_Lvl4_bkey
		 , na.AccessCategory_Lvl5_bkey 
FROM Norm.n_Access na