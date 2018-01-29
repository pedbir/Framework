
CREATE VIEW [Fact].[f_Subscription]
AS

WITH tempFromToDate AS (SELECT	Subscription_key
								, SysDatetimeDeletedUTC
								, SysModifiedUTC = MAX(SysModifiedUTC) OVER (PARTITION BY Subscription_bkey ORDER BY Calendar_Subscription_bkey)
								, SysValidFromDateTime
								, SysSrcGenerationDateTime
								, Subscription_bkey
								, SubscriptionProduct_bkey
								, ServiceProvider_bkey
								, Access_bkey
								, Calendar_Purchase_bkey
								, ResoposibleSalesEntity
								, IsClosed
								, Calendar_FromSubscription_bkey =	Calendar_Subscription_bkey
								, Calendar_ToSubscription_bkey	= LEAD(Calendar_Subscription_bkey, 1, NULL) OVER (PARTITION BY Subscription_bkey ORDER BY Calendar_Subscription_bkey)
						FROM	Norm.n_Subscription
						WHERE	Subscription_bkey <> -1)
	, AccessDim AS (SELECT		na.Access_key
								, no.Opportunity_key
								, na2.Address_key
								, na3.Area_key
								, na.Access_bkey
					FROM		Norm.vn_Access		na
					LEFT JOIN	Norm.vn_Opportunity no
								ON no.Access_bkey	= na.Access_bkey
								AND no._isLast	= 1
					LEFT JOIN	Norm.vn_Address		na2
								ON na2.Address_bkey = no.Address_bkey
								AND na2._isLast = 1
					LEFT JOIN	Norm.vn_Area		na3
								ON na3.Area_bkey	= no.Area_bkey
								AND na3._isLast = 1
					WHERE		na._isLast			= 1
								AND na.Access_key	<> -1)
SELECT		t.Subscription_key
			, t.SysDatetimeDeletedUTC
			, t.SysModifiedUTC
			, t.SysValidFromDateTime
			, t.SysSrcGenerationDateTime
			, t.Subscription_bkey
			, t.SubscriptionProduct_bkey
			, t.ServiceProvider_bkey
			, t.Access_bkey
			, SubscriptionProduct_key = ISNULL(nsp.SubscriptionProduct_key, -1)
			, ServiceProvider_key	= ISNULL(vsp.ServiceProvider_key, -1)
			, Access_key			= ISNULL(a.Access_key, -1)
			, Opportunity_key		= ISNULL(a.Opportunity_key, -1)
			, Address_key			= ISNULL(a.Address_key, -1)
			, Area_key				= ISNULL(a.Area_key, -1)
			, t.Calendar_Purchase_bkey
			, t.ResoposibleSalesEntity			
			, t.Calendar_FromSubscription_bkey
			, t.Calendar_ToSubscription_bkey
FROM		tempFromToDate				t
LEFT JOIN	Norm.vn_SubscriptionProduct nsp
			ON nsp.SubscriptionProduct_bkey = t.SubscriptionProduct_bkey
			AND nsp._isLast				= 1
LEFT JOIN	Norm.vn_ServiceProvider		vsp
			ON vsp.ServiceProvider_bkey		= t.ServiceProvider_bkey
			AND vsp._isLast				= 1
LEFT JOIN	AccessDim					a
			ON a.Access_bkey				= t.Access_bkey
WHERE		t.IsClosed																									= 0
			AND DATEDIFF(DAY, t.Calendar_FromSubscription_bkey, ISNULL(t.Calendar_ToSubscription_bkey, '2999-12-31'))	> 0