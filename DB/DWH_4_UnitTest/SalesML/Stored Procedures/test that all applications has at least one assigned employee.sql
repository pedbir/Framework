

CREATE PROC [SalesML].[test that all applications has at least one assigned employee]
AS
BEGIN
/*
Description: 
This test verifies that every morgage loan application has atleast one assigned employee
*/

------Execution
		DECLARE @_actual INT, @_expected INT

		SELECT @_actual = COUNT(*) 
		FROM DWH_3_Fact.Fact.d_MLLoanApplication dmla 
		WHERE dmla.CustomerSupportEmployee_CS_key = -1 
		AND dmla.CustomerSupportEmployee_CSG_key = -1 
		AND dmla.CustomerSupportEmployee_Credit_key = -1
		AND dmla.MLLoanApplication_key <> -1

------Expected
		SET @_expected = 0
		
------Assertion		
	EXEC tSQLt.AssertEquals @Expected = @_expected  -- sql_variant
	                        ,@Actual = @_actual    -- sql_variant
	                       
	 
END