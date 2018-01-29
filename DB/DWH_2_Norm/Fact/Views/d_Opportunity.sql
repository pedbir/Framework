CREATE VIEW Fact.d_Opportunity
AS
WITH temp AS
(
	SELECT	vse.SugarEnum_bkey
	FROM	Norm.vn_SugarEnum vse
	WHERE	vse.SugarEnum_bkey LIKE 'IP_BESTALLNING#BESTALLNINGSTYP_C#%'
)
	, temp2 AS
(
	SELECT		vcc.CustomerCategory_key
				, vcc.CustomerCategory_bkey
				, SugarEnum_BusinessType_bkey = ISNULL('IP_MOJLIGHETER#KUNDTYP_C#' + NULLIF(UPPER(LTRIM(RTRIM(ts1.SplitValue))), '%'), '%')
				, SugarEnum_AreaType_bkey	= ISNULL('IP_OMRADE#TYP_AV_ORT_C#' + NULLIF(UPPER(LTRIM(RTRIM(ts2.SplitValue))), '%'), '%')
				, SugarEnum_SubsidyArea_bkey =	ISNULL('IP_OMRADE#BIDRAGSOMRADE_C#' + NULLIF(UPPER(LTRIM(RTRIM(ts3.SplitValue))), '%'), '%')
				, SugarEnum_OrderType_bkey	= COALESCE(t.SugarEnum_bkey, t2.SugarEnum_bkey, '%')
				, vcc.OpportunityCustomerType
				, vcc._isLast
	FROM		Norm.vn_CustomerCategory											vcc
	OUTER APPLY (	SELECT	*
					FROM	dbo.tvf_split(vcc.SugarEnum_BusinessType_bkey, ',') ts ) ts1
	OUTER APPLY (SELECT * FROM	dbo.tvf_split(vcc.SugarEnum_AreaType_bkey, ',') ts ) ts2
	OUTER APPLY (	SELECT	*
					FROM	dbo.tvf_split(vcc.SugarEnum_SubsidyArea_bkey, ',') ts ) ts3
	LEFT JOIN	temp	t
				ON vcc.SugarEnum_OrderType_bkey LIKE '=%'
				AND t.SugarEnum_bkey LIKE '%' + REPLACE(vcc.SugarEnum_OrderType_bkey, '=', '')
	LEFT JOIN	temp	t2
				ON vcc.SugarEnum_OrderType_bkey LIKE '<>%'
				AND t2.SugarEnum_bkey NOT LIKE '%' + REPLACE(vcc.SugarEnum_OrderType_bkey, '<>', '')
	WHERE		vcc._isLast						= 1
				AND vcc.CustomerCategory_bkey	<> -1
)
SELECT		NO.Opportunity_key
			, NO.SysDatetimeDeletedUTC
			, NO.SysModifiedUTC
			, NO.SysIsInferred
			, NO.SysValidFromDateTime
			, NO.SysSrcGenerationDateTime
			, NO.Opportunity_bkey
			, NO.OpportunityName
			, Area_key					= ISNULL(na.Area_key, -1)
			, Access_key				= ISNULL(na3.Access_key, -1)
			, SalesOrder_key			= ISNULL(vso.SalesOrder_key, -1)
			, SugarEnum_BusinessType_key =	ISNULL(vse.SugarEnum_key, -1)
			, NO.Fastighetsbeteckningc
			, NO.AcquiredAccess
			, CustomerCategory_key		= ISNULL(t2.CustomerCategory_key, -1)
			, na2.Address_key
FROM		Norm.n_Opportunity						NO
LEFT JOIN	Norm.vn_Area							na
			ON na.Area_bkey = NO.Area_bkey
			AND na._isLast = 1
LEFT JOIN	Norm.vn_Access							na3
			ON na3.Access_bkey = NO.Access_bkey
			AND na3._isLast = 1
LEFT JOIN	Norm.vn_SugarEnum						vse
			ON vse.SugarEnum_bkey = NO.SugarEnum_BusinessType_bkey
			AND vse._isLast = 1
OUTER APPLY (	SELECT		TOP 1 *
				FROM		Norm.n_SalesOrder vso
				WHERE		vso.Opportunity_bkey = NO.Opportunity_bkey
				ORDER BY	vso.SysValidFromDateTime) vso
OUTER APPLY (	SELECT	TOP 1 *
				FROM	temp2 t2
				WHERE	NO.SugarEnum_BusinessType_bkey LIKE t2.SugarEnum_BusinessType_bkey
						AND na.SugarEnum_AreaType_bkey LIKE t2.SugarEnum_AreaType_bkey
						AND NO.CustomerType LIKE t2.OpportunityCustomerType
						AND na.SugarEnum_SubsidyArea_bkey LIKE t2.SugarEnum_SubsidyArea_bkey
						AND t2.CustomerCategory_bkey	<> -1
						AND ISNULL(vso.SugarEnum_OrderType_bkey, 'IP_BESTALLNING#BESTALLNINGSTYP_C#STANDARD') LIKE ISNULL(t2.SugarEnum_OrderType_bkey, '%'))	t2
OUTER APPLY (SELECT TOP 1 na2.Address_key FROM Norm.n_Address na2 WHERE no.Address_bkey = na2.Address_bkey ORDER BY na2.SysValidFromDateTime) na2
GO
