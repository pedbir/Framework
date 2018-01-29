CREATE VIEW Norm_d.DeliveryPoint
AS
SELECT	SysValidFromDateTime		= lp.SysValidFromDateTime
		, SysSrcGenerationDateTime = lp.SysSrcGenerationDateTime
		, SysDatetimeDeletedUTC = CASE WHEN lp.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
		, SysModifiedUTC		= lp.SysModifiedUTC
		, DeliveryPoint_bkey	= lp.Leveranspunkt_bkey
		, Delivery_bkey			= ISNULL(lp.Ipleveransobjektipleveranspunkteripleveransobjektida, '-1')
		, Access_bkey			= CAST(ISNULL(lp.Netadminaddressidc, -1) AS INT)
		, Address_bkey			= ISNULL(NULLIF(CONVERT(NVARCHAR(100), lp.Adressmasteridc), '-1'), lp.Leveranspunkt_bkey)
		, DeliveryPointName		= lp.Name
		, CustomerType			= CAST(UPPER(LTRIM(RTRIM(lp.Tjanstetypc))) AS NVARCHAR(150))
--select *
FROM	Sugar_RawTyped.r_Leveranspunkt lp
WHERE	lp.Leveranspunkt_bkey <> '-1'