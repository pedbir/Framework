CREATE PROC [SalesML].[test that historical PayoutAmount stay persistent both in SE and NO]
AS
BEGIN

------Execution
		SELECT      dfs.FinanceSegmentGoldenCategoryCode
				   ,Period       = CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112)
				   ,PayoutAmount = SUM(flam.PayoutAmount)
		INTO #Actual
		FROM        DWH_3_Fact.Fact.f_MLLoanApplicationMetrics flam		
		INNER JOIN  DWH_3_Fact.Fact.d_FinanceSegment         dfs ON flam.FinanceSegment_key = dfs.FinanceSegment_key
		WHERE       CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112) BETWEEN '201803' AND '201808'
		GROUP BY    dfs.FinanceSegmentGoldenCategoryCode
				   ,CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112)
		ORDER BY    dfs.FinanceSegmentGoldenCategoryCode, Period

------Assertion
	CREATE TABLE #expected ( FinanceSegmentGoldenCategoryCode NVARCHAR(250), [Period] NVARCHAR(6), [PayoutAmount] INT )
	INSERT INTO #expected
	VALUES
		( N'NO_ML', N'201803', 173553784.0000 ), 
		( N'NO_ML', N'201804', 149796000.0000 ), 
		( N'NO_ML', N'201805', 118846500.0000 ), 
		( N'NO_ML', N'201806', 170539000.0000 ), 
		( N'NO_ML', N'201807', 142818250.0000 ), 
		( N'NO_ML', N'201808', 171574114.0000 ), 
		( N'SE_ML', N'201803', 234923501.0000 ), 
		( N'SE_ML', N'201804', 116731002.0000 ), 
		( N'SE_ML', N'201805', 167138000.0000 ), 
		( N'SE_ML', N'201806', 161055004.0000 ), 
		( N'SE_ML', N'201807', 141710003.0000 ), 
		( N'SE_ML', N'201808', 127332001.0000 )


	EXEC tSQLt.AssertEqualsTable '#expected', '#Actual';
END