
CREATE VIEW [Norm_d].[Access]
AS

SELECT ra.SysDatetimeDeletedUTC
     , ra.SysModifiedUTC     
     , ra.SysValidFromDateTime
     , ra.SysSrcGenerationDateTime    
	 , Access_bkey = ra.Adress_bkey     
     , Calendar_Installed_bkey		= CAST(ra.ipo_installed_date AS DATETIME)	 
     , AccessCategory_Lvl1_bkey		= ISNULL(NULLIF(ra.adrkodid1, 0), -1)
     , AccessCategory_Lvl2_bkey		= ISNULL(NULLIF(ra.adrkodid2, 0), -1)
     , AccessCategory_Lvl3_bkey		= ISNULL(NULLIF(ra.adrkodid3, 0), -1)
     , AccessCategory_Lvl4_bkey		= ISNULL(NULLIF(ra.adrkodid4, 0), -1)
     , AccessCategory_Lvl5_bkey		= ISNULL(NULLIF(ra.adrkodid5, 0), -1)
FROM Netadmin_RawTyped.r_Adress ra
WHERE ra.Adress_bkey <> -1