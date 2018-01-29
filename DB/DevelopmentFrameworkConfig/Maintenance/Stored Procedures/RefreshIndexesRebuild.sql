-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Rebuilds indexes and updates statistics
-- Example:	
/* 
		EXECUTE [DevelopmentFrameworkConfig].[Maintenance].[RefreshIndexesRebuild] @DestinationTableCatalog = 'DataWarehouse'
*/
--
--
-- =============================================
CREATE PROCEDURE [Maintenance].[RefreshIndexesRebuild] @DestinationTableCatalog NVARCHAR(128)
	,@TableSchemaName NVARCHAR(128) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- SQL Server 2008 script to REBUILD all indexes for all tables 
	DECLARE @TableName VARCHAR(256)
	DECLARE @FILLFACTOR INT = 100
	DECLARE @DynamicSQL NVARCHAR(max) = 'DECLARE curAllTablesInDB CURSOR FOR SELECT TABLE_CATALOG + ''.'' + TABLE_SCHEMA + 
	 ''.'' + TABLE_NAME AS TABLENAME   
	 FROM ' + @DestinationTableCatalog + '.INFORMATION_SCHEMA.TABLES WHERE 
	 TABLE_TYPE = ''BASE TABLE''' + isnull(' and TABLE_SCHEMA = ''' + @TableSchemaName, ' ') + '''
	  ORDER BY 1'

	BEGIN
		EXEC sp_executeSQL @DynamicSQL -- create tables cursor

		OPEN curAllTablesInDB

		FETCH NEXT
		FROM curAllTablesInDB
		INTO @TableName

		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			SET @DynamicSQL = 'ALTER INDEX ALL ON ' + @TableName + ' REBUILD PARTITION = ALL'

			PRINT @DynamicSQL

			EXEC sp_executeSQL @DynamicSQL

			FETCH NEXT
			FROM curAllTablesInDB
			INTO @TableName
		END -- cursor WHILE

		CLOSE curAllTablesInDB

		DEALLOCATE curAllTablesInDB
	END

	-- Update statistics for optimal execution plans
	SET @DynamicSQL = 'execute ' + @DestinationTableCatalog + '.dbo.sp_updatestats'

	EXEC sp_executeSQL @DynamicSQL -- create tables cursor	
END