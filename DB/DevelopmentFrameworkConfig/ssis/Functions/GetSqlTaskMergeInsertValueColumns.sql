-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSqlTaskMergeInsertValueColumns] (
	@SOURCE_CATALOG VARCHAR(max) --= 'DW'
	,@SOURCE_SCHEMA_NAME VARCHAR(max) -- = 'DM'
	,@SOURCE_TABLE_NAME VARCHAR(max) --= 'dStoreV'
	,@DESTINATION_TABLE_CATALOG VARCHAR(max) -- = 'DM'
	,@USAGE_TYPE VARCHAR(50)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @InsertValueColumns VARCHAR(max)

	IF @USAGE_TYPE = 'Insert'
	BEGIN
		SELECT @InsertValueColumns = (
				SELECT stuff((
							SELECT ', ' + insert_column
							FROM [ssis].[SQLTaskMergeInsertValueColumns]
							WHERE isnull(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
								AND isnull(table_schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
								AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
								AND isnull(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
							ORDER BY ordno
								,Ordinal_position
							FOR XML PATH('')
							), 1, 1, '') InsertColumns
				)
	END

	IF @USAGE_TYPE = 'Value'
	BEGIN
		SELECT @InsertValueColumns = (
				SELECT stuff((
							SELECT ', ' + Value_Column
							FROM [ssis].[SQLTaskMergeInsertValueColumns]
							WHERE isnull(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
								AND isnull(table_schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
								AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
								AND isnull(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
							ORDER BY ordno
								,Ordinal_position
							FOR XML PATH('')
							), 1, 1, '') InsertColumns
				)
	END

	RETURN @InsertValueColumns
END