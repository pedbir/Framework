-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSqlTaskMergeDiffColumns] (
	@SOURCE_CATALOG VARCHAR(max)
	,@SOURCE_SCHEMA_NAME VARCHAR(max)
	,@SOURCE_TABLE_NAME VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @DiffColumns VARCHAR(max)

	SELECT @DiffColumns = (
			SELECT stuff((
						SELECT ' OR ' + DiffCols
						FROM ssis.SQLTaskMergeDiffColumns x
						WHERE IsNull(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
							AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
							AND isnull(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
							AND isnull(table_Schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
						FOR XML path('')
						), 1, 3, '') DiffCols
			)

	RETURN @DiffColumns
END