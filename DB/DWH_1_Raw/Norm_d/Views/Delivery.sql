CREATE VIEW [Norm_d].[Delivery]
AS
SELECT	SysValidFromDateTime				= (SELECT MAX(LastUpdateDate) FROM (VALUES (lo.SysValidFromDateTime), (am.SysValidFromDateTime), (o.SysValidFromDateTime)) as  UpdateDate(LastUpdateDate))
		, SysSrcGenerationDateTime			= lo.SysSrcGenerationDateTime
		, SysDatetimeDeletedUTC				= CASE WHEN lo.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
		, SysModifiedUTC					= (SELECT MAX(LastUpdateDate) FROM (VALUES (lo.SysModifiedUTC), (am.SysModifiedUTC), (o.SysModifiedUTC)) as  UpdateDate(LastUpdateDate))
		, Delivery_bkey						= lo.Leveransobjekt_bkey
		, Agreement_bkey					= ISNULL(o.Order_bkey, '-1')
		, Geography_bkey                    = CAST(ISNULL(NULLIF(lo.Ipgeografiipleveransobjektipgeografiida, ''), '-1') AS NVARCHAR(100))
		, Project_bkey                      = CAST(ISNULL(NULLIF(lo.Projektidifsc, ''), '-1') AS NVARCHAR(100))
		, DeliveryName						= lo.Name
		, SugarEnum_BusinessType_bkey		= CAST(ISNULL(UPPER(LTRIM(RTRIM('Opportunities#affarstyp_c#' + NULLIF(am.AffarstypC, '')))), '-1') AS NVARCHAR(250))
		, Employee_ConstructionManager_bkey = CAST(ISNULL(NULLIF(lo.Contactsipleveransobjekt2contactsida, ''), '-1') AS NVARCHAR(100))
--select *
FROM		Sugar_RawTyped.r_Leveransobjekt lo
OUTER APPLY	(SELECT TOP 1 * FROM Sugar_RawTyped.r_Affarsmojlighet am WHERE am.Affarsmojlighet_bkey = lo.Opportunitiesipleveransobjekt1opportunitiesida ORDER BY am.SysValidFromDateTime DESC) am
OUTER APPLY	(SELECT TOP 1 * FROM Cava_RawTyped.r_Order o WHERE o.OrderNumber = am.OrdernummerCavaC ORDER BY o.SysValidFromDateTime DESC) o
WHERE		lo.Leveransobjekt_bkey <> '-1'