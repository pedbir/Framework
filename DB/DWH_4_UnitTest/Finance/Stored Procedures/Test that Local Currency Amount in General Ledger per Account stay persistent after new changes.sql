


CREATE  PROCEDURE [Finance].[Test that Local Currency Amount in General Ledger per Account stay persistent after new changes]
AS
BEGIN


------Execution
		
        
		SELECT 	Account		= a.AccountCode,
				Period      = CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY	= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
		INTO #actual
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Account a ON gl.GLAccount_key = a.GLAccount_key 
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY a.AccountCode,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)
		

------Assertion
        
		
		
		SELECT *
		INTO #expected
		FROM    OPENQUERY (DWH_PROD, '
		SELECT 	Account		= a.AccountCode,
				Period      = CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY	= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Account a ON gl.GLAccount_key = a.GLAccount_key 
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY a.AccountCode,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)

		' ) oq

			
		
		
		EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;