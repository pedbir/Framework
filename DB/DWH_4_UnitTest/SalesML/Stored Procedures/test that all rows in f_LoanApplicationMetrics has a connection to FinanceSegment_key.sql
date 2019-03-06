
CREATE PROC [SalesML].[test that all rows in f_LoanApplicationMetrics has a connection to FinanceSegment_key]
AS
BEGIN

------Execution
		SELECT FinanceSegment_key = ISNULL(flam.FinanceSegment_key, -1), dfs.FinanceSegment_bkey
		INTO #actual
		FROM DWH_3_Fact.Fact.f_MLLoanApplicationMetrics flam
		INNER JOIN DWH_3_Fact.Fact.d_FinanceSegment dfs ON flam.FinanceSegment_key = dfs.FinanceSegment_key
		WHERE ISNULL(flam.FinanceSegment_key, -1) = -1 

------Assertion		
		SELECT * 
		INTO #expected
		FROM #actual a
		WHERE 1=0
		

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;