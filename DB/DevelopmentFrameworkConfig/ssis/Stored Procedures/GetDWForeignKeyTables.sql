-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [ssis].[GetDWForeignKeyTables] @DimensionTableCatalog VARCHAR(max)
	,@DimensionSchemaName VARCHAR(max)
	,@DimensionFactTableName VARCHAR(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ForeignKeyTableName
		,ForeignKeyColumn
		,CONCAT (
			'Lookup '
			,[ForeignKeyColumn]
			) AS LkpName
		,CONCAT (
			'Select distinct '
			,[ForeignKeyTableColumnName] + ' as ' + ForeignKeyColumn
			,' From '
			,quotename(DimensionSchemaName)
			,'.'
			,quotename(ForeignKeyTableName)
			) AS LkpSelectQuery
		, CONCAT (
			'Get Distinct '
			,[ForeignKeyColumn]
			) AS AggName
		,CONCAT (
			ForeignKeyTableName
			,' ('
			, ForeignKeyColumn
			, ')'
			) AS DerivedColumnName
	FROM [ssis].[DimensionForeignKeyColumns]
	WHERE [DimensionTableCatalog] = @DimensionTableCatalog
		AND [DimensionSchemaName] = @DimensionSchemaName
		AND [DimensionTableName] = @DimensionFactTableName
END