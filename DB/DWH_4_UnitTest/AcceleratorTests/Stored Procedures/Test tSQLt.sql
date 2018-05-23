


CREATE PROC [AcceleratorTests].[Test tSQLt]
AS
BEGIN 

 --Assemble: Fake the Particle table to make sure it is empty and that constraints will not be a problem
  EXEC tSQLt.FakeTable 'Accelerator.Particle';

  DECLARE @variable1 NVARCHAR(250) = (SELECT TOP 1  p.PackageID FROM DWH_0_Admin.Logging.Package P)
	, @variable2 NVARCHAR(250) = (SELECT TOP 1  p.PackageID FROM DWH_0_Admin.Logging.Package P)
  
  --Act: 
 
    
  --Assert:  
 
  EXEC tSQLt.AssertEquals   @Expected=@variable1,@Actual=@variable2 


  
END;