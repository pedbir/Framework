-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [ssis].[GetInferredForeignKeyDataFlow] @SourceTableCatalog VARCHAR(max)
	,@DimensionTableCatalog VARCHAR(max)
	,@DimensionSchemaName VARCHAR(max)
	,@DimensionName VARCHAR(max)
	,@ForeignKeyColumn VARCHAR(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @iForeignKeyCount INT
		,@ForeignKeyTable VARCHAR(max)

	SELECT @iForeignKeyCount = count(1)
	FROM ssis.DimensionForeignKeyColumns
	WHERE DimensionTableCatalog = @DimensionTableCatalog
		AND DimensionSchemaName = @DimensionSchemaName
		AND DimensionTableName = @DimensionName

	SELECT @ForeignKeyTable = TableName
	FROM Metadata.TableKeyDefinition
	WHERE TableCatalog = @DimensionTableCatalog
		AND COLUMN_NAME = @ForeignKeyColumn
		AND KeyType = 'PK'

	DECLARE @T TABLE (
		DimensionTableCatalog VARCHAR(max)
		,DimensionSchemaName VARCHAR(max)
		,DimensionTableName VARCHAR(max)
		,ForeignKeyTableName VARCHAR(max)
		,ForeignKeyColumn VARCHAR(max)
		,lkpName VARCHAR(max)
		,AggName VARCHAR(max)
		)

	INSERT INTO @T
	SELECT DimensionTableCatalog
		,DimensionSchemaName
		,DimensionTableName
		,ForeignKeyTableName
		,ForeignKeyColumn
		,CONCAT (
			'Lookup '
			,[ForeignKeyColumn]
			)
		,CONCAT (
			'Get Distinct '
			,[ForeignKeyColumn]
			)
	FROM [ssis].[DimensionForeignKeyColumns]
	WHERE [DimensionTableCatalog] = @DimensionTableCatalog
		AND [DimensionSchemaName] = @DimensionSchemaName
		AND [DimensionTableName] = @DimensionName
		AND [ForeignKeyTableName] = @ForeignKeyTable
		AND [ForeignKeyColumn] = @ForeignKeyColumn

	-- Lookup
	SELECT lkpName AS '@Name'
		,'RedirectRowsToNoMatchOutput' AS '@NoMatchBehavior'
		,'Partial' AS '@CacheMode'
		-- ,'Full' AS '@CacheMode'
		,@DimensionTableCatalog AS '@OleDbConnectionName'
		,CONCAT (
			'SELECT DISTINCT '
			,[ForeignKeyColumn]
			,' FROM '
			,quotename(t.DimensionSchemaName)
			,'.'
			,quotename(t.ForeignKeyTableName)
			) AS 'DirectInput'
		,CASE 
			WHEN @iForeignKeyCount = 1
				THEN 'DC Inferred.Output'
			ELSE CONCAT (
					'MC Inferred.'
					,[ForeignKeyColumn]
					)
			END AS 'InputPath/@OutputPathName'
		,ForeignKeyColumn AS 'Inputs/Column/@SourceColumn'
		,ForeignKeyColumn AS 'Inputs/Column/@TargetColumn'
	FROM @T t
	FOR XML path('Lookup')
END