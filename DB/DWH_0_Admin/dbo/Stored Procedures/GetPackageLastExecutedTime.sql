
-- =============================================
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

	DECLARE @DestinationTableFullPath NVARCHAR(100) = 
		(
		SELECT '[' + pdt.DestinationTableCatalog + '].[' + pdt.DestinationSchemaName + '].[' + pdt.DestinationTableName + ']'		
		FROM Logging.PackageDestinationTable pdt
		WHERE pdt.PackageID = @PackageGUID
		AND LEN(pdt.DestinationTableCatalog) > 0 AND LEN(pdt.DestinationTableName) > 0 AND LEN(pdt.DestinationSchemaName) > 0
		)
	
	
	IF @DestinationTableFullPath IS NULL
		SELECT CAST('1900-01-01' AS DATETIME)
	ELSE
		DECLARE @SQL NVARCHAR(max) = '
			IF NOT EXISTS (SELECT TOP 1 * FROM '+@DestinationTableFullPath+')
				SELECT PackageLastExecuted =  CAST(''1900-01-01'' as Datetime)
			ELSE
				SELECT
					PackageLastExecuted = ISNULL(DATEADD(MINUTE, '+CAST(@MinutesAdd AS NVARCHAR(100))+', MAX(ExecutionStart)), ''1899-12-31'') 
				FROM [Logging].[PackageExecutionV] 
				WHERE 
					PackageID = '''+@PackageGUID+''' AND
					[Status] = ''Success'' AND 
					RowsRead > 0'
		PRINT @SQL
		EXEC (@SQL)


END
GO