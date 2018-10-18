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


SELECT tablename = QUOTENAME(t.TABLE_SCHEMA) + '.' + QUOTENAME(t.TABLE_NAME)
INTO #temp
FROM   INFORMATION_SCHEMA.TABLES t
WHERE t.TABLE_TYPE = 'BASE TABLE' AND t.TABLE_SCHEMA = 'Metadata'


DECLARE @sqlDeleteStatement NVARCHAR(MAX),  @sqlDeleteStatement1 NVARCHAR(MAX)

SELECT @sqlDeleteStatement  = STUFF((SELECT '1' + 'ALTER TABLE ' + t.tablename + ' NOCHECK CONSTRAINT ALL' FROM #temp t FOR XML path('')), 1, 1, '') 
SELECT @sqlDeleteStatement  = @sqlDeleteStatement  + '1' +  STUFF((SELECT '1' + 'DELETE ' + t.tablename FROM #temp t FOR XML path('')), 1, 1, '') 
SELECT @sqlDeleteStatement  = @sqlDeleteStatement  + '1' + STUFF((SELECT '1' + 'ALTER TABLE ' + t.tablename + ' CHECK CONSTRAINT ALL' FROM #temp t FOR XML path('')), 1, 1, '') 

SELECT @sqlDeleteStatement1 = REPLACE(@sqlDeleteStatement, '1', CHAR(13))

EXEC(@sqlDeleteStatement1)


:r .\Script.InsertDataTypeTranslation.sql

:r .\Script.InsertDerivedColumnOverride.sql

:r .\Script.InsertDestinationTableGroup.sql

:r .\Script.InsertEnvironmentVariables.sql

:r .\Script.InsertDestinationFieldExtended.sql

:r .\Script.DeployMetadata.sql