CREATE VIEW Norm_f.Access
AS

SELECT ra.SysDatetimeDeletedUTC
     , ra.SysModifiedUTC     
     , ra.SysValidFromDateTime
     , ra.SysSrcGenerationDateTime    
	 , Access_bkey = ra.Adress_bkey     
     , Calenar_Installed_bkey = ra.ipo_installed_date
     , AccessCategory_Lvl1_bkey = ISNULL(NULLIF(ra.adrkodid1, 0), -1)
     , AccessCategory_Lvl2_bkey = ISNULL(NULLIF(ra.adrkodid2, 0), -1)
     , AccessCategory_Lvl3_bkey = ISNULL(NULLIF(ra.adrkodid3, 0), -1)
     , AccessCategory_Lvl4_bkey = ISNULL(NULLIF(ra.adrkodid4, 0), -1)
     , AccessCategory_Lvl5_bkey = ISNULL(NULLIF(ra.adrkodid5, 0), -1)
FROM Netadmin_RawTyped.r_Adress ra
WHERE ra.Adress_bkey <> -1