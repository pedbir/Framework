


CREATE PROCEDURE [Finance].[Test that the daily expected file has arrived]
AS
BEGIN
     
------Execution
		
			    
		
		
		
		
		SELECT FileExists
		INTO #actual
		FROM 
		(	SELECT  
			FileExists = CASE WHEN COUNT(*) = 8 THEN 1 ELSE 0 END,
			ExecutionEnd = CONVERT(VARCHAR(20),ExecutionEnd,100)   
			FROM DWH_0_Admin.Logging.PackageFileExecution WITH (NOLOCK)
			WHERE  CONVERT(DATE,ExecutionEnd) = CONVERT(DATE,GETDATE()) 
			AND (SysFileName  LIKE 'svc_dimensioner_costcenter%'
			OR SysFileName  LIKE 'svc_dimensioner_konto%'
			OR SysFileName  LIKE 'svc_dimensioner_miscellaneous%'
			OR SysFileName  LIKE 'svc_dimensioner_reportstructure%'
			OR SysFileName  LIKE 'svc_dimrelationer%'
			OR SysFileName  LIKE 'svc_dimrelationer_konto%'
			OR SysFileName  LIKE 'svc_kontoplan%'
			OR SysFileName  LIKE 'svc_rapportstruktur%'
			)
			GROUP BY CONVERT(VARCHAR(20),ExecutionEnd,100)  
	   		UNION
			SELECT  
			FileExists = CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END,
			ExecutionEnd = CONVERT(VARCHAR(20),ExecutionEnd,100) 
			FROM DWH_0_Admin.Logging.PackageFileExecution WITH (NOLOCK)
			WHERE  CONVERT(DATE,ExecutionEnd) = CONVERT(DATE,GETDATE()) 
			AND SysFileName  LIKE 'svc_huvudbok%'
			GROUP BY CONVERT(VARCHAR(20),ExecutionEnd,100)  
	   	) FileExistsCheck
		GROUP BY FileExists
		
		
	

		

------Assertion
        
		CREATE TABLE #expected (FileExists  TINYINT)
		INSERT INTO #expected
		VALUES
		(1)

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;