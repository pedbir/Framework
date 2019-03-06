


CREATE PROCEDURE [Finance].[Test GLAccountCode and GLAccountName are the same between LegalEntity]
AS
BEGIN
     
------Execution
		
		
		    		
		
		
		
		

		SELECT 
		a.GLAccountCode, 
		CountGLAccountName = COUNT(distinct a.GLAccountName)   
		INTO #actual
		FROM [DWH_2_Norm].[Norm].[n_GLAccount] a
		GROUP BY  a.GLAccountCode
		HAVING COUNT(DISTINCT a.GLAccountName)  > 1
		
	

------Assertion
        
		CREATE TABLE #expected (GLAccountCode nvarchar(50), CountGLAccountName  TINYINT)
		
		
		EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;