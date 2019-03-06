CREATE PROC [SalesML].[test that all applications has a Customer]
AS
BEGIN
/*
Description: 
This test verifies that every morgage loan application contains a valid customer record
*/

/*
It's is a fact that there are applications in BAMS/OPOC that doesnt have customers (customers are deleted afterwards in BAMS or there are applications/Contacts
being imported to OPOC that misses customer details).
Hence, the idea here is to look into a historic period and assume that the number of applications lacking customers are "constant and never changing" and take that number
as the expected amount.

The period that has been looked into is stated in execution and this period should generate 497 applications without any customers
*/


------Execution
		DECLARE @_actual INT, @_expected INT
		
		SELECT @_actual = COUNT(*) 
		FROM DWH_3_Fact.Fact.b_MLLoanApplicationCustomer bmlac
		LEFT JOIN DWH_3_Fact.Fact.d_MLLoanApplication dmla ON dmla.MLLoanApplication_key = bmlac.MLLoanApplication_key
		LEFT JOIN DWH_3_Fact.Fact.d_MLLoanCustomer dmlc ON dmlc.MLLoanCustomer_key = bmlac.MLLoanCustomer_key
		WHERE dmla.MLLoanApplication_key IS NULL OR  dmlc.MLLoanCustomer_key IS null

------Expected
		SET @_expected = 0
		
------Assertion		
	EXEC tSQLt.AssertEquals @Expected = @_expected  -- sql_variant
	                        ,@Actual = @_actual    -- sql_variant
	                       
	 
END