﻿CREATE PROC SalesML.[test payout has not been double counted per application]
AS
BEGIN
/*
Description: 
An application or PreAppLoan can only be payed/given once. Check that we don't double count 
*/


------Execution
		SELECT    flam.LoanApplication_bkey
				 ,TestResult = SUM(flam.NoOfPayout)
				 ,TestCase   = IIF(SUM(flam.NoOfPayout) > 1, 'NoOfPayout', ' ')  
	    INTO #actual
		FROM      DWH_3_Fact.Sales.f_LoanApplicationMetrics flam
		GROUP BY  flam.LoanApplication_bkey
		HAVING    SUM(flam.NoOfPayout) > 1


------Assertion		
		SELECT * 
		INTO #expected
		FROM #actual a
		WHERE 1=0
		

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;