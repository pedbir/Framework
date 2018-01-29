

CREATE VIEW CityNetwork.f_Subscription
AS

WITH temp AS (
	SELECT	Subscription_key
		, Calendar_bkey = EOMONTH(MAX(dc.Calendar_bkey))
		, SubscriptionDuration = CAST(COUNT(*) AS FLOAT)/DAY(EOMONTH(MAX(dc.Calendar_bkey)))			
	FROM	[$(DWH_3_Fact)].Fact.f_Subscription fs
	INNER JOIN [$(DWH_3_Fact)].Fact.d_Calendar dc ON dc.Calendar_bkey BETWEEN fs.Calendar_FromSubscription_bkey AND ISNULL(fs.Calendar_ToSubscription_bkey, EOMONTH(GETDATE()))
	GROUP BY fs.Subscription_key, dc.YearMonth
)
SELECT fs.Subscription_bkey
		 , fs.SubscriptionProduct_bkey
		 , fs.ServiceProvider_bkey
		 , fs.Access_bkey
		 , fs.SubscriptionProduct_key
		 , fs.ServiceProvider_key
		 , fs.Access_key
		 , fs.Opportunity_key
		 , fs.Address_key
		 , fs.Area_key
		 , fs.Calendar_Purchase_bkey
		 , fs.ResoposibleSalesEntity
		 , SubscriptionFromDate = fs.Calendar_FromSubscription_bkey
		 , SubscriptionToDate = fs.Calendar_ToSubscription_bkey 
		 , t.Calendar_bkey
		 , SubscriptionDuration = t.SubscriptionDuration
FROM [$(DWH_3_Fact)].Fact.f_Subscription fs
INNER JOIN temp t ON t.Subscription_key = fs.Subscription_key