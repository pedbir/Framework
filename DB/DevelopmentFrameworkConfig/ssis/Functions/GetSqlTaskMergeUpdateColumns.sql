-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSqlTaskMergeUpdateColumns] (
	@SOURCE_CATALOG VARCHAR(max)
	,@SOURCE_SCHEMA_NAME VARCHAR(max)
	,@SOURCE_TABLE_NAME VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @UpdateColumns VARCHAR(max)

	SELECT @UpdateColumns = (
			SELECT stuff((
						SELECT ',' + UpdateCols
						FROM ssis.SQLTaskMergeUpdateColumns
						WHERE IsNull(Table_Catalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
							AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
							AND isnull(Table_Name, @SOURCE_TABLE_NAME) = @SOURCE_TABLE_NAME
							AND isnull(table_Schema, @SOURCE_SCHEMA_NAME) = @SOURCE_SCHEMA_NAME
						ORDER BY OrdNo
							,Ordinal_position
						FOR XML path('')
						), 1, 1, '') UpdCols
			)

	RETURN @UpdateColumns
END