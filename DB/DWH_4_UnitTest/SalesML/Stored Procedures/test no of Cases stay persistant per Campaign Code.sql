CREATE PROC [SalesML].[test no of cases stay persistant per campaign code]
AS
BEGIN
/*
Description: 
Test that Campaign code stay persistant over time. 
This dimension doesn't exists for Norway.
*/

------Execution
		SELECT dmla.CampaignName, cnt = 1
		INTO #actual
		FROM DWH_3_Fact.Fact.d_MLLoanApplication dmla
		WHERE dmla.FinanceSegment_bkey = 'SE_ML' AND dmla.CampaignName <> 'N/A'
		AND dmla.SysSrcGenerationDateTime BETWEEN '2018-11-01' AND '2019-01-31'
		GROUP BY dmla.CampaignName
	    ORDER BY dmla.CampaignName
		

------Assertion		
		CREATE TABLE #expected ( [CampaignName] nvarchar(100), [cnt] int )
		INSERT INTO #expected
		VALUES
		( N'Ingen RSE', 1 ), 
		( N'Nearer Prime A', 1 )
		

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;
GO

                                          