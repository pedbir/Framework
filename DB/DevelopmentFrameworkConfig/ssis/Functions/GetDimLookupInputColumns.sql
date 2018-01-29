-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Xml format <Column SourceColumn="column_name" TargetColumn="column_name"></Column>
--		Return all native key columns that where not derived from Extended Fields in previous load step
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetDimLookupInputColumns] (
	@DIMENSION_SCHEMA_NAME VARCHAR(max)
	,@DIMENSION_TABLE_NAME VARCHAR(max)
	)
RETURNS XML
AS
BEGIN
	DECLARE @DerivedColumns XML

	SELECT @DerivedColumns = (
			SELECT ColumnName AS '@SourceColumn'
				,ColumnName AS '@TargetColumn'
			FROM ssis.LookupDimensionInputColumns
			WHERE SchemaName = @DIMENSION_SCHEMA_NAME
				AND TableName = @DIMENSION_TABLE_NAME
			ORDER BY KeyColumnOrder
			FOR XML path('Column')
			)

	RETURN @DerivedColumns
END