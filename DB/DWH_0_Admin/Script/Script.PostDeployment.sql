/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Test
/*
IF 'Local' = '$(Environment)'
BEGIN
PRINT '***** Creating Test Data for UTV Enviroment *****';

END
*/


DECLARE @Result INT
SELECT  @Result = CASE HOST_NAME() WHEN 'dwbuildsrv01' THEN 1 WHEN 'STO-BIT-01' THEN 2 WHEN 'STO-DB-04' THEN 3 ELSE -1 END


IF @Result = 1
BEGIN 
:r .\Script.InsertConfigurationBuild.sql
END
IF @Result = 2
BEGIN 
:r .\Script.InsertConfigurationUAT.sql
END
IF @Result = 3
BEGIN 
:r .\Script.InsertConfigurationPROD.sql
END
IF @Result = -1
BEGIN 
:r .\Script.InsertConfigurationLocal.sql
END

