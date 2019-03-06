CREATE PROC [SalesML].[test if budget numbers are missing for SalesTicket]
AS
BEGIN
------Execution				
		SELECT fps.FinanceSegment_bkey, fps.PlanningMetricCode
		INTO #actual
		FROM DWH_3_Fact.Fact.f_PlanningSales fps
		WHERE EOMONTH(fps.Calendar_Period_key) > GETDATE()
		GROUP BY fps.FinanceSegment_bkey, fps.PlanningMetricCode
		ORDER BY fps.FinanceSegment_bkey, fps.PlanningMetricCode

------Assertion
		CREATE TABLE #expected ( [FinanceSegment_bkey] nvarchar(250), [PlanningMetricCode] nvarchar(250) )
		INSERT INTO #expected VALUES
			( N'NO_ML', N'NrPayoutLoans' ), 
			( N'NO_ML', N'PayoutAmount' ), 
			( N'SE_ML', N'NrPayoutLoans' ), 
			( N'SE_ML', N'PayoutAmount' ), 
			( N'SE_PL', N'NrPayoutLoans' ), 
			( N'SE_PL', N'PayoutAmount' )

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;