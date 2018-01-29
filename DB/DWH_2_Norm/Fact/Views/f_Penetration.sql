
CREATE VIEW [Fact].[f_Penetration]
AS

-- When the transaction is deleted the values is set to zero
-- Suger doesn't produce a salesorder when a oppertunity is accuired even though the transactions is a activated customer.

SELECT  no.SysSrcGenerationDateTime
        , no.SysValidFromDateTime
        , no.SysModifiedUTC
        , no.SysDatetimeDeletedUTC
        , Calendar_key						= CAST(CONVERT(NVARCHAR(8), no.SysSrcGenerationDateTime, 112) AS INT)
        , Penetration_key					= CAST('Opp#' + no.Opportunity_bkey AS NVARCHAR(250))
        , no.Opportunity_key
        , Area_key							= ISNULL(na.Area_key, -1)
        , Project_key						= ISNULL(np.Project_key, -1)
		, Geography_key						= ISNULL(ng.Geography_key, -1)
		, Address_key						= ISNULL(na3.Address_key, -1)
        , SalesOrder_key					= -1
        , Customer_key						= -1
		, Employee_SalesResponsible_key		= ISNULL(ne.Employee_key, -1)
        , Access_key						= ISNULL(na2.Access_key, -1)
        , NoOfHP							= 1 * IIF(no.SysDatetimeDeletedUTC IS NULL, 1, 0)
        , NoOfHC							= 0 		
        , NoOfInstalled						= 0
		, NoOfBacklog						= 0
		, Delivery_key						= -1
		, Service_key						= -1
FROM    Norm.vn_Opportunity no
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Area na WHERE na.Area_bkey = no.Area_bkey ORDER BY na.SysValidFromDateTime DESC) na
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np WHERE np.Project_bkey = na.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Access na2 WHERE na2.Access_bkey = no.Access_bkey ORDER BY na2.SysValidFromDateTime DESC) na2
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = no.Employee_SalesResponsible_bkey ORDER BY ne.SysValidFromDateTime DESC) ne
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Geography ng WHERE ng.Geography_bkey = na.Geography_bkey ORDER BY ng.SysValidFromDateTime DESC) ng
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Address na3 WHERE na3.Address_bkey = no.Address_bkey ORDER BY na3.SysValidFromDateTime DESC) na3
WHERE	no._isLast = 1 AND no.Opportunity_key <> -1
UNION ALL
SELECT  nso.SysSrcGenerationDateTime
        , nso.SysValidFromDateTime
        , nso.SysModifiedUTC
        , nso.SysDatetimeDeletedUTC
        , Calendar_key						= CAST(CONVERT(NVARCHAR(8), nso.SysSrcGenerationDateTime, 112) AS INT)
        , Penetration_key					= CAST('SO#' + nso.SalesOrder_bkey AS NVARCHAR(250))
        , Opportunity_key					= ISNULL(no.Opportunity_key, -1)
        , Area_key							= ISNULL(na.Area_key, -1)
        , Project_key						= ISNULL(np.Project_key, -1)
		, Geography_key						= ISNULL(ng.Geography_key, -1)
		, Address_key						= ISNULL(na3.Address_key, -1)
        , nso.SalesOrder_key
        , Customer_key						= nso.SalesOrder_key
		, Employee_SalesResponsible_key		= ISNULL(ne.Employee_key, -1)
        , Access_key						= ISNULL(na2.Access_key, -1)
        , NoOfHP							= -1 * IIF(nso.SysDatetimeDeletedUTC IS NULL, 1, 0) * IIF(nso.SugarEnum_DeliveryStatus_bkey IN ('IP_BESTALLNING#STATUS_LEVERANS_C#ANGRAT', 'IP_BESTALLNING#STATUS_LEVERANS_C#ANNULLERAD', 'IP_BESTALLNING#STATUS_LEVERANS_C#EJVALIDERAD'), 0, 1)
        , NoOfHC							= IIF(nso.SysDatetimeDeletedUTC IS NULL, 1, 0) * IIF(nso.SugarEnum_DeliveryStatus_bkey IN ('IP_BESTALLNING#STATUS_LEVERANS_C#ANGRAT', 'IP_BESTALLNING#STATUS_LEVERANS_C#ANNULLERAD', 'IP_BESTALLNING#STATUS_LEVERANS_C#EJVALIDERAD'), 0, 1)
        , NoOfInstalled						= 0
		, NoOfBacklog						= IIF(nso.SysDatetimeDeletedUTC IS NULL, 1, 0) * IIF(nso.SugarEnum_DeliveryStatus_bkey IN ('IP_BESTALLNING#STATUS_LEVERANS_C#ANGRAT', 'IP_BESTALLNING#STATUS_LEVERANS_C#ANNULLERAD', 'IP_BESTALLNING#STATUS_LEVERANS_C#EJVALIDERAD'), 0, 1)
		, Delivery_key						= -1
		, Service_key						= -1
FROM    Norm.vn_SalesOrder nso
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Opportunity no WHERE no.Opportunity_bkey = nso.Opportunity_bkey ORDER BY no.SysValidFromDateTime DESC) no
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Area na WHERE na.Area_bkey = no.Area_bkey ORDER BY na.SysValidFromDateTime DESC) na
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np WHERE np.Project_bkey = na.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Access na2 WHERE na2.Access_bkey = no.Access_bkey ORDER BY na2.SysValidFromDateTime DESC) na2
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = no.Employee_SalesResponsible_bkey ORDER BY ne.SysValidFromDateTime DESC) ne
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Geography ng WHERE ng.Geography_bkey = na.Geography_bkey ORDER BY ng.SysValidFromDateTime DESC) ng
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Address na3 WHERE na3.Address_bkey = no.Address_bkey ORDER BY na3.SysValidFromDateTime DESC) na3
WHERE    nso._isLast = 1 AND nso.SalesOrder_key <> -1
UNION ALL
SELECT  na2.SysSrcGenerationDateTime
        , na2.SysValidFromDateTime
        , na2.SysModifiedUTC
        , na2.SysDatetimeDeletedUTC
        , Calendar_key						= CAST(CONVERT(NVARCHAR(8), na2.Calendar_Installed_bkey, 112) AS INT)		
        , Penetration_key					= CAST('Acc#' + CAST(na2.Access_bkey AS NVARCHAR(100)) AS NVARCHAR(250))
        , Opportunity_key					= ISNULL(no.Opportunity_key, -1)
        , Area_key							= ISNULL(na.Area_key, -1)
        , Project_key						= ISNULL(np.Project_key, -1)
		, Geography_key						= ISNULL(ng.Geography_key, -1)
		, Address_key						= ISNULL(na3.Address_key, -1)
        , SalesOrder_key					= ISNULL(nso.SalesOrder_key, -1)
		, Customer_key						= ISNULL(nso.SalesOrder_key, -1)
		, Employee_SalesResponsible_key		= ISNULL(ne.Employee_key, -1)
        , na2.Access_key
        , NoOfHP							= 0
        , NoOfHC							= 0
        , NoOfInstalled						= IIF(na2.SysDatetimeDeletedUTC IS NULL, 1, 0)
		, NoOfBacklog						= -1 * IIF(nso.SalesOrder_key <> -1, 1, 0) * IIF(nso.SysDatetimeDeletedUTC IS NULL, 1, 0) * IIF(nso.SugarEnum_DeliveryStatus_bkey IN ('IP_BESTALLNING#STATUS_LEVERANS_C#ANGRAT', 'IP_BESTALLNING#STATUS_LEVERANS_C#ANNULLERAD', 'IP_BESTALLNING#STATUS_LEVERANS_C#EJVALIDERAD'), 0, 1)
		, Delivery_key						= -1
		, Service_key						= -1
FROM    Norm.vn_Access na2
OUTER APPLY (SELECT TOP 1 Opportunity_Key, Employee_SalesResponsible_bkey, Area_bkey, Address_bkey, Opportunity_bkey FROM Norm.n_Opportunity no WHERE no.Access_bkey = na2.Access_bkey ORDER BY no.SysValidFromDateTime DESC) no
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Area na WHERE na.Area_bkey = no.Area_bkey ORDER BY na.SysValidFromDateTime DESC) na
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np WHERE np.Project_bkey = na.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = no.Employee_SalesResponsible_bkey ORDER BY ne.SysValidFromDateTime DESC) ne
OUTER APPLY (SELECT TOP 1 SalesOrder_Key, SysDatetimeDeletedUTC, SugarEnum_DeliveryStatus_bkey FROM Norm.n_SalesOrder nso WHERE nso.Opportunity_bkey = no.Opportunity_bkey ORDER BY nso.SysValidFromDateTime DESC) nso
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Geography ng WHERE ng.Geography_bkey = na.Geography_bkey ORDER BY ng.SysValidFromDateTime DESC) ng
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Address na3 WHERE na3.Address_bkey = no.Address_bkey ORDER BY na3.SysValidFromDateTime DESC) na3
WHERE	na2._isLast = 1 AND na2.Access_key <> -1 AND na2.Calendar_Installed_bkey > '1990-01-01'
UNION ALL
SELECT		nd.SysSrcGenerationDateTime
			, nd.SysValidFromDateTime
			, SysModifiedUTC			= (SELECT MAX(LastUpdateDate) FROM (VALUES (nd.SysModifiedUTC), (s.SysModifiedUTCAgreementService), (s.SysModifiedUTCService)) as  UpdateDate(LastUpdateDate)) 
			, nd.SysDatetimeDeletedUTC
			, Calendar_key				= CAST(CONVERT(NVARCHAR(8), nd.SysSrcGenerationDateTime, 112) AS INT)
			, Penetration_key			= CAST('D#' + nd.Delivery_bkey AS NVARCHAR(250))
			, Opportunity_key			= -1
			, Area_key					= -1
			, Project_key				= ISNULL(np2.Project_key, -1)
			, Geography_key				= ISNULL(ng.Geography_key, -1)
			, Address_key				= -1
			, SalesOrder_key			= -1
			, Customer_key				= nc.Customer_key
			, Employee_SalesResponsible_key = ISNULL(ne2.Employee_key, -1)
			, Access_key				= -1
			, NoOfHP					= 0
			, NoOfHC					= IIF(nd.SysDatetimeDeletedUTC IS NULL, 1, 0) * s.Quantity
			, NoOfInstalled				= 0
			, NoOfBacklog				= IIF(nd.SysDatetimeDeletedUTC IS NULL, 1, 0) * s.Quantity
			, nd.Delivery_key
			, s.Service_key
FROM		Norm.vn_Delivery								nd
OUTER APPLY (	SELECT		TOP 1 np2.Project_key
				FROM		Norm.n_Project np2
				WHERE		np2.Project_bkey = nd.Project_bkey
				ORDER BY	np2.SysValidFromDateTime DESC) np2
OUTER APPLY (	SELECT		TOP 1 ng.Geography_key
				FROM		Norm.n_Geography ng
				WHERE		ng.Geography_bkey = nd.Geography_bkey
				ORDER BY	ng.SysValidFromDateTime DESC) ng
OUTER APPLY (	SELECT		TOP 1 na2.Agreement_key
							, na2.Employee_SalesPerson_bkey
							, na2.Customer_bkey
				FROM		Norm.n_Agreement na2
				WHERE		na2.Agreement_bkey = nd.Agreement_bkey
				ORDER BY	na2.SysValidFromDateTime DESC) na2
OUTER APPLY (	SELECT		TOP 1 ne2.Employee_key
				FROM		Norm.n_Employee ne2
				WHERE		na2.Employee_SalesPerson_bkey = ne2.Employee_bkey
				ORDER BY	ne2.SysValidFromDateTime DESC) ne2
OUTER APPLY (	SELECT		TOP 1 nc.Customer_key
				FROM		Norm.n_Customer nc
				WHERE		nc.Customer_bkey = na2.Customer_bkey
				ORDER BY	nc.SysValidFromDateTime DESC) nc
LEFT JOIN	(	SELECT		nas.Agreement_bkey
							, ns.Service_key
							, Quantity						= SUM(nas.Quantity)
							, SysModifiedUTCService			= MAX(nas.SysModifiedUTC)
							, SysModifiedUTCAgreementService =	MAX(ns.SysModifiedUTC)
				FROM		Norm.vn_AgreementService					nas
				CROSS APPLY (	SELECT		TOP 1 *
								FROM		Norm.n_Service ns
								WHERE		ns.Service_bkey = nas.Service_bkey
								ORDER BY	ns.SysValidFromDateTime DESC) ns
				WHERE		nas._isLast = 1
				GROUP BY	nas.Agreement_bkey
							, ns.Service_key)	s
			ON s.Agreement_bkey = nd.Agreement_bkey
WHERE		nd.Delivery_bkey <> '-1' AND nd._isLast = 1