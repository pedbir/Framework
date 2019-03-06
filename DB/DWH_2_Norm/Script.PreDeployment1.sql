/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/


CREATE TABLE #temp(sqlStatement nvarchar(max), rowNo int)
INSERT INTO #temp
SELECT sqlStatement = 'TRUNCATE TABLE ' + t.TABLE_CATALOG + '.[' + t.TABLE_SCHEMA + '].[' + t.TABLE_NAME + ']'
       , rowNo = ROW_NUMBER() OVER (ORDER BY t.TABLE_NAME)
FROM   INFORMATION_SCHEMA.TABLES t
WHERE t.TABLE_TYPE = 'BASE TABLE'

DECLARE @LastRowNo int = 1, @sqlStatement NVARCHAR(max)

WHILE (@LastRowNo IS NOT NULL)
BEGIN 
	
	SET @sqlStatement = (SELECT TOP 1 t.sqlStatement FROM #temp t WHERE t.rowNo = @LastRowNo)

	PRINT @sqlStatement
	
	EXEC (@sqlStatement)

	set @LastRowNo= (select top 1 rowNo from #temp where rowNo > @LastRowNo order by rowNo)
END

DROP TABLE #temp