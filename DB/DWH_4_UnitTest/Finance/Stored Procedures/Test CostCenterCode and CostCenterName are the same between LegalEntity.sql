


CREATE PROCEDURE [Finance].[Test CostCenterCode and CostCenterName are the same between LegalEntity]
AS
BEGIN
     
------Execution
		
		
		    		
		
		
		
		SELECT C.CostCenterCode,COUNT(DISTINCT C.CostCenterName) CountCostCenterName
		INTO #actual
        FROM DWH_2_Norm.Norm.n_CostCenter C
        GROUP BY C.CostCenterCode
		HAVING COUNT(DISTINCT C.CostCenterName) > 1

	

------Assertion
        
		CREATE TABLE #expected (CostCenterCode nvarchar(100), CountCostCenterName  TINYINT)
		
		
	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;