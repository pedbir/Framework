


CREATE PROC [Finance].[test that no errors in the SSIS ETL Log]
AS
BEGIN
	DECLARE @actual INT, @expected INT = 0;

  ------Execution 

  WITH CTE AS
    (
    -- This is end of the recursion: Select items with no parent
    SELECT  SysExecutionLog_key
           ,SysBatchLogExecutionLog_key
           ,RowsError
           ,RowsIgnored
    FROM    DWH_0_Admin.Logging.PackageExecution pe
    WHERE   SysBatchLogExecutionLog_key = (SELECT MAX(pev.SysExecutionLog_key) FROM DWH_0_Admin.Logging.PackageExecutionV pev WHERE pev.PackageName = 'Agresso_Master')
    UNION ALL
    -- This is the recursive part: It joins to CTE
    SELECT      t.SysExecutionLog_key
               ,t.SysBatchLogExecutionLog_key
               ,t.RowsError
               ,t.RowsIgnored
    FROM        DWH_0_Admin.Logging.PackageExecution t
    INNER JOIN  CTE                                  c ON t.SysBatchLogExecutionLog_key = c.SysExecutionLog_key
    )
   SELECT  @actual = SUM(CTE.RowsError) FROM CTE
   
  ------Assertion 

  EXEC tSQLt.AssertEquals @Expected = @expected  -- sql_variant
                         ,@Actual = @actual    -- sql_variant
                         
   
END;