-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [ssis].[GetPackageInfoDMDetails] @SOURCE_SERVER VARCHAR(max)
	,@SOURCE_CATALOG VARCHAR(max)
	,@SOURCE_SCHEMA_NAME VARCHAR(max)
	,@SOURCE_TABLE_NAME VARCHAR(max) = NULL
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DESTINATION_SCHEMA_NAME VARCHAR(max)
		,@DESTINATION_TABLE_NAME VARCHAR(max)

	SELECT @DESTINATION_SCHEMA_NAME = dt.DestinationSchemaName
		,@DESTINATION_TABLE_NAME = dt.DestinationTableName
	FROM Metadata.DestinationTable dt
	WHERE dt.SourceTableCatalog = @SOURCE_CATALOG
		AND dt.SourceSchemaName = @SOURCE_SCHEMA_NAME
		AND dt.SourceTableName = @SOURCE_TABLE_NAME

	SELECT
		-- SQL Merge objects
		ssis.GetSrcDstKeyCondition(dt.DestinationTableCatalog, dt.DestinationSchemaName, dt.DestinationTableName, 'AND') AS SqlTaskMergeKeyCondition
		,ssis.GetSqlTaskMergeInsertValueColumns(dt.SourceTableCatalog, dt.SourceSchemaName, dt.SourceTableName, dt.DestinationTableCatalog, 'Insert') AS SqlTaskMergeInsColumns
		,ssis.GetSqlTaskMergeInsertValueColumns(dt.SourceTableCatalog, dt.SourceSchemaName, dt.SourceTableName, dt.DestinationTableCatalog, 'Value') AS SqlTaskMergeValColumns
		,ssis.GetSqlTaskMergeDiffColumns(dt.SourceTableCatalog, dt.SourceSchemaName, dt.SourceTableName, dt.DestinationTableCatalog) AS SqlTaskMergeDiffCols
		,ssis.GetSqlTaskMergeUpdateColumns(dt.SourceTableCatalog, dt.SourceSchemaName, dt.SourceTableName, dt.DestinationTableCatalog) AS SqlTaskMergeUpdCols
		,ssis.GetSqlTaskMergeParameter(dt.SourceTableCatalog, dt.DestinationTableCatalog, dt.DestinationTableName, 'DWH_3_Fact', dt.SSISIncrementalLoad) SqlTaskMergeParameters
		, dt.SSISIncrementalLoad
		, dt.FactScdType
	FROM Metadata.DestinationTable dt
	WHERE dt.SourceTableCatalog = @SOURCE_CATALOG
		AND dt.SourceSchemaName = @SOURCE_SCHEMA_NAME
		AND dt.SourceTableName = @SOURCE_TABLE_NAME
		AND dt.DestinationTableName = @DESTINATION_TABLE_NAME
END