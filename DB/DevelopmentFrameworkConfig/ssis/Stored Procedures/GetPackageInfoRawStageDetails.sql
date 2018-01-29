
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [ssis].[GetPackageInfoRawStageDetails] @SOURCE_SERVER VARCHAR(MAX)
	,@SOURCE_CATALOG VARCHAR(MAX)
	,@SOURCE_SCHEMA_NAME VARCHAR(MAX)
	,@SOURCE_TABLE_NAME VARCHAR(MAX) = NULL
	,@DESTINATION_TABLE_CATALOG VARCHAR(MAX)
	,@DESTINATION_SCHEMA_NAME VARCHAR(MAX)
	,@DESTINATION_TABLE_NAME VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT InsVal.table_Catalog AS Source_Table_Catalog
		,InsVal.table_Schema AS Source_Table_Schema
		,InsVal.table_name AS Source_Table_Name
		,InsVal.DestinationTableCatalog
		,
		-- Data Flow objects
		ssis.GetDerivedColumns(insVal.table_catalog, InsVal.DestinationTableCatalog, InsVal.table_name, 'ins', 0) DerivedCols
		,
		-- Merge to Stage objects
		ssis.GetSqlTaskMergeParameter(InsVal.table_catalog, InsVal.DestinationTableCatalog, InsVal.table_name, 'Stage', 0) SqlTaskMergeParameters
		,ssis.GetSrcDstKeyCondition(@DESTINATION_TABLE_CATALOG, @DESTINATION_SCHEMA_NAME, @DESTINATION_TABLE_NAME, 'AND') AS SqlTaskMergeKeyCondition
		,InsVal.InsertColumns SqlTaskMergeInsColumns
		,InsVal.ValueColumns SqlTaskMergeInsValues
		,UpdCols.UpdCols SqlTaskMergeUpdCols
		,DiffCols.DiffCols SqlTaskMergeDiffCols
		,DelCols.DelCols SqlTaskMergeDelCols
	FROM (
		SELECT DISTINCT table_Catalog
			,table_schema
			,table_name
			,DestinationTableCatalog
			,STUFF((
					SELECT ', ' + insert_column
					FROM [ssis].[SQLTaskMergeInsertValueColumns] x
					WHERE ISNULL(x.Table_Catalog, tic.Table_Catalog) = tic.Table_Catalog
						AND ISNULL(x.table_schema, tic.table_schema) = tic.table_schema
						AND x.DestinationTableCatalog = tic.DestinationTableCatalog
						AND ISNULL(x.Table_Name, tic.Table_Name) = tic.Table_Name
					ORDER BY ordno
						,Ordinal_position
					FOR XML PATH('')
					), 1, 1, '') InsertColumns
			,STUFF((
					SELECT ', ' + value_column
					FROM [ssis].[SQLTaskMergeInsertValueColumns] x
					WHERE ISNULL(x.Table_Catalog, tic.Table_Catalog) = tic.Table_Catalog
						AND x.DestinationTableCatalog = tic.DestinationTableCatalog
						AND ISNULL(x.Table_Name, tic.Table_Name) = tic.Table_Name
						AND ISNULL(x.table_schema, tic.table_schema) = tic.table_schema
					ORDER BY ordno
						,Ordinal_position
					FOR XML PATH('')
					), 1, 1, '') ValueColumns
		FROM [ssis].[SQLTaskMergeInsertValueColumns] tic
		WHERE ISNULL(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
			AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
			AND ISNULL(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
			AND ISNULL(table_Schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
		) InsVal
	JOIN (
		SELECT DISTINCT udc.table_Catalog
			,udc.Table_schema
			,udc.table_name
			,udc.DestinationTableCatalog
			,STUFF((
					SELECT ',' + UpdateCols
					FROM ssis.SQLTaskMergeUpdateColumns x
					WHERE ISNULL(x.table_Catalog, udc.table_catalog) = udc.Table_Catalog
						AND ISNULL(x.table_Schema, udc.table_schema) = udc.Table_Schema
						AND ISNULL(x.table_Name, udc.table_name) = udc.Table_Name
						AND x.DestinationTableCatalog = udc.DestinationTableCatalog
					ORDER BY OrdNo
						,Ordinal_position
					FOR XML PATH('')
					), 1, 1, '') UpdCols
		FROM [ssis].[SQLTaskMergeUpdateColumns] udc
		WHERE ISNULL(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
			AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
			AND ISNULL(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
			AND ISNULL(table_Schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
		) UpdCols ON InsVal.table_catalog = UpdCols.table_catalog
		AND InsVal.table_Schema = UpdCols.table_schema
		AND InsVal.table_name = UpdCols.table_name
		AND InsVal.DestinationTableCatalog = UpdCols.DestinationTableCatalog
	JOIN (
		SELECT DISTINCT mdc.table_Catalog
			,mdc.Table_schema
			,mdc.table_name
			,mdc.DestinationTableCatalog
			,STUFF((
					SELECT ' OR ' + DiffCols
					FROM ssis.SQLTaskMergeDiffColumns x
					WHERE x.table_Catalog = mdc.Table_Catalog
						AND x.table_Schema = mdc.Table_Schema
						AND x.table_Name = mdc.Table_Name
					FOR XML PATH('')
					), 1, 3, '') DiffCols
		FROM [ssis].[SQLTaskMergeDiffColumns] mdc
		WHERE ISNULL(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
			AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
			AND ISNULL(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
			AND ISNULL(table_Schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
		) DiffCols ON InsVal.table_Catalog = DiffCols.table_Catalog
		AND InsVal.table_Schema = DiffCols.table_Schema
		AND InsVal.table_name = DiffCols.table_name
		AND InsVal.destinationtablecatalog = DiffCols.destinationtablecatalog
	JOIN (
		-- för delete finns bara null värden för alla fält förutom destinationTableCatalog
		SELECT DISTINCT mdelc.table_Catalog
			,mdelc.Table_schema
			,mdelc.table_name
			,mdelc.DestinationTableCatalog
			,STUFF((
					SELECT ',' + DeleteCols
					FROM [ssis].[SQLTaskMergeDeleteColumns] x
					WHERE x.DestinationTableCatalog = mdelc.DestinationTableCatalog
					ORDER BY ordinal_position
					FOR XML PATH('')
					), 1, 1, '') DelCols
		FROM [ssis].[SQLTaskMergeDeleteColumns] mdelc
		WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
		) DelCols ON InsVal.destinationtablecatalog = DelCols.destinationtablecatalog
END