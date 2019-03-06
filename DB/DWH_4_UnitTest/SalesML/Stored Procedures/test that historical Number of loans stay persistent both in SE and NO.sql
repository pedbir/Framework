
CREATE PROC [SalesML].[test that historical Number of loans stay persistent both in SE and NO]
AS
BEGIN
------Execution
		SELECT      dfs.FinanceSegmentGoldenCategoryCode
					,Period       = CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112)
				   ,PayoutAmount = SUM(flam.NoOfPayout)
		INTO #actual
		FROM        DWH_3_Fact.Fact.f_MLLoanApplicationMetrics flam
		INNER JOIN  DWH_3_Fact.Fact.d_FinanceSegment         dfs ON flam.FinanceSegment_key = dfs.FinanceSegment_key
		WHERE       CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112) BETWEEN '201803' AND '201808'
		GROUP BY    dfs.FinanceSegmentGoldenCategoryCode
				   ,CONVERT(NVARCHAR(6), flam.Calendar_MilestoneStart_key, 112)
		ORDER BY dfs.FinanceSegmentGoldenCategoryCode, Period

------Assertion
		CREATE TABLE #expected ( FinanceSegmentGoldenCategoryCode NVARCHAR(250), [Period] NVARCHAR(6), [PayoutAmount] INT )
		INSERT INTO #expected
		VALUES
			( N'NO_ML', N'201803', 125 ), 
			( N'NO_ML', N'201804', 108 ), 
			( N'NO_ML', N'201805', 81 ), 
			( N'NO_ML', N'201806', 108 ), 
			( N'NO_ML', N'201807', 88 ), 
			( N'NO_ML', N'201808', 105 ), 
			( N'SE_ML', N'201803', 244 ), 
			( N'SE_ML', N'201804', 149 ), 
			( N'SE_ML', N'201805', 171 ), 
			( N'SE_ML', N'201806', 204 ), 
			( N'SE_ML', N'201807', 179 ), 
			( N'SE_ML', N'201808', 151 )


	EXEC tSQLt.AssertEqualsTable '#expected', '#actual'
END 