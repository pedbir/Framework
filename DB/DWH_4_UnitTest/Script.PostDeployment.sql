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



IF NOT EXISTS (SELECT * FROM tSQLt.Private_NewTestClassList  WHERE ClassName = 'AcceleratorTests')
	INSERT INTO tSQLt.Private_NewTestClassList VALUES (N'AcceleratorTests')

IF NOT EXISTS (SELECT * FROM tSQLt.Private_NewTestClassList  WHERE ClassName = 'Finance')
	INSERT INTO tSQLt.Private_NewTestClassList VALUES (N'Finance')

IF NOT EXISTS (SELECT * FROM tSQLt.Private_NewTestClassList  WHERE ClassName = 'SalesML')
	INSERT INTO tSQLt.Private_NewTestClassList VALUES (N'SalesML')
	

