

CREATE VIEW [CityNetwork].[d_Opportunity]
AS
SELECT		do.Opportunity_key
			, do.Opportunity_bkey
			, OpportunityName		= ISNULL(do.OpportunityName, 'N/A')
			, BusinessType			= ISNULL(SugarEnum_BusinessType_key.FieldValue, 'N/A')
FROM		[$(DWH_3_Fact)].Fact.d_Opportunity do
INNER JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_BusinessType_key
			ON do.SugarEnum_BusinessType_key	= SugarEnum_BusinessType_key.SugarEnum_key