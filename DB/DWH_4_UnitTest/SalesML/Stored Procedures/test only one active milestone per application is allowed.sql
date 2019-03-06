CREATE PROC [SalesML].[test only one active milestone per application is allowed]
AS
BEGIN
/*
Description: 
Milestones is a description on how far an application has been processed in the sales funnel. 
Multiple milestones for a given period is not allowed for a single application. 
The test verifies that no such scenario exists. 
*/


------Execution
		SELECT  t.MLLoanApplication_bkey, t.TestResult, t.TestCase
		INTO #actual
		FROM    ( 
				SELECT dmla.MLLoanApplication_bkey, TestResult = COUNT(*), TestCase = flam.MilestoneStatusName
				FROM DWH_3_Fact.Fact.f_MLLoanApplicationMetrics flam
				INNER JOIN DWH_3_Fact.Fact.d_MLLoanApplication dmla ON dmla.MLLoanApplication_key = flam.MLLoanApplication_key
				INNER JOIN DWH_3_Fact.Fact.d_Calendar dc ON dc.Calendar_key BETWEEN flam.Calendar_MilestoneStart_key AND flam.Calendar_MilestoneEnd_key
				GROUP BY dmla.MLLoanApplication_bkey, flam.MilestoneStatusName, dc.Calendar_key
				HAVING COUNT(*) > 1 
				) t		


------Assertion		
		SELECT * 
		INTO #expected
		FROM #actual a
		WHERE 1=0
		

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;
GO
