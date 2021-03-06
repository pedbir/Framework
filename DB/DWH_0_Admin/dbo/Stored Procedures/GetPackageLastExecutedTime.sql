﻿-- =============================================
-- Author:			Pedram Birounvand
-- Create date:		2017-08-25
-- Modified date:	
--
-- Description: 
--		Returns a datetime for last successful execution for a package. 
--		When the destination table is empty, return datetime 1900-01-01 so that all transactions are extracted.

--		Example:	EXECUTE [DWH_0_Admin].[dbo].[GetPackageLastExecutedTime] @PackageGUID = '6F76B0D6-BD0B-4A14-BC56-962A24D2E4CD', @MinutesAdd = -10

-- =============================================
CREATE PROC [dbo].[GetPackageLastExecutedTime] 
	@PackageGUID nvarchar(50),
	@MinutesAdd int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DestinationTableCatalog nvarchar(50), @DestinationSchemaName NVARCHAR(50), @DestinationTableName NVARCHAR(50), @DestinationTableFullPath NVARCHAR(100), @SQL NVARCHAR(max), @SysIsInferred INT
	SELECT TOP 1 @DestinationTableCatalog = pdt.DestinationTableCatalog 
			, @DestinationSchemaName = pdt.DestinationSchemaName 
			, @DestinationTableName = pdt.DestinationTableName 
	FROM Logging.PackageDestinationTable pdt
	WHERE pdt.PackageID = @PackageGUID
			AND LEN(pdt.DestinationTableCatalog) > 0
			AND LEN(pdt.DestinationTableName)	> 0
			AND LEN(pdt.DestinationSchemaName) > 0			

	SELECT * INTO #temp FROM INFORMATION_SCHEMA.TABLES t WHERE 1=0
	ALTER TABLE #temp ADD SysIsInferred INT NULL
	DECLARE @InfoSql NVARCHAR(MAX) = 'SELECT top 1 t.*, SysIsInferred = IIF(c.COLUMN_NAME IS NULL, 0, 1) FROM '+ @DestinationTableCatalog +'.INFORMATION_SCHEMA.TABLES t LEFT JOIN '+ @DestinationTableCatalog +'.INFORMATION_SCHEMA.COLUMNS c ON t.TABLE_CATALOG = c.TABLE_CATALOG AND t.TABLE_NAME = c.TABLE_NAME AND t.TABLE_SCHEMA = c.TABLE_SCHEMA AND c.COLUMN_NAME = ''SysIsInferred'' WHERE t.TABLE_CATALOG = '''+ @DestinationTableCatalog +''' AND t.TABLE_SCHEMA = '''+ @DestinationSchemaName +''' AND t.TABLE_NAME = '''+ @DestinationTableName +''' AND t.TABLE_TYPE = ''BASE TABLE'''
	
	PRINT @InfoSql

	INSERT INTO #temp
	EXEC (@InfoSql)	

	SET @DestinationTableFullPath = QUOTENAME(@DestinationTableCatalog) + '.' + QUOTENAME(@DestinationSchemaName) + '.' + QUOTENAME(@DestinationTableName)
	SET @SysIsInferred = (SELECT TOP 1 SysIsInferred FROM #temp t)


	IF NOT EXISTS (SELECT TOP 1 * FROM #temp t)
		SET @SQL = 'SELECT
					PackageLastExecuted = ISNULL(DATEADD(MINUTE, '+CAST(@MinutesAdd AS NVARCHAR(100))+', MAX(ExecutionStart)), ''1899-12-31'') 
				FROM [Logging].[PackageExecutionV] 
				WHERE 
					PackageID = '''+@PackageGUID+''' AND
					[Status] = ''Success'''
	ELSE
		SET @SQL = '
			IF NOT EXISTS (SELECT TOP 1 * FROM '+@DestinationTableFullPath + IIF(@SysIsInferred = 1, ' WHERE SysIsInferred = 0', '') + ')
				SELECT PackageLastExecuted =  CAST(''1900-01-01'' as Datetime)
			ELSE
				SELECT
					PackageLastExecuted = ISNULL(DATEADD(MINUTE, '+CAST(@MinutesAdd AS NVARCHAR(100))+', MAX(ExecutionStart)), ''1899-12-31'') 
				FROM [Logging].[PackageExecutionV] 
				WHERE 
					PackageID = '''+@PackageGUID+''' AND
					[Status] = ''Success'' AND RowsRead > 0'
	

	PRINT @SQL
	EXEC (@SQL)

END
