


 
CREATE PROCEDURE [Finance].[Test that FTE numbers have been booked last month]
AS
BEGIN
   

------Execution
		
		
        SELECT AmountLCY	= CASE WHEN CONVERT(INT,(SUM(AmountLCY))) > 0 THEN 1 ELSE 0 END 
		INTO #actual
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Account a ON gl.GLAccount_key = a.GLAccount_key 
		WHERE  CONVERT(NVARCHAR(10),GL.Period_key, 112) >=  CONVERT(NVARCHAR(10),DATEADD(DD,-43,GETDATE()), 112)
		AND   a.AccountCode = '9001' 
		
		
------Assertion
        
		CREATE TABLE #expected (AmountLCY  INT)
		INSERT INTO #expected
		VALUES
		(1)
	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;