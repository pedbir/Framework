-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Function used by ssis.GetDerivedColumn when a dynamic value is applied
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetDerivedColumnDynamicOverrideValue] (
	@SOURCE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@DerivedColumnOverrideID INT
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @DynamicValue VARCHAR(max) = ''
		,@DerivedColumnType VARCHAR(50)
		,@DerivedColumnName NVARCHAR(255)

	SELECT @DerivedColumnType = [DerivedColumnType]
		,@DerivedColumnName = [DerivedColumnName]
	FROM [Metadata].[DerivedColumnOverride]
	WHERE Id = @DerivedColumnOverrideID

	IF @DerivedColumnType = 'dwError'
		AND @DerivedColumnName = 'SourceTableName'
	BEGIN
		SELECT @DynamicValue = CONCAT (
				'"'
				,SourceTableName
				,'"'
				)
		FROM Metadata.DestinationTable
		WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
			AND SourceTableCatalog = @SOURCE_CATALOG
			AND DestinationTableName = @DESTINATION_TABLE_NAME
	END

	IF @DerivedColumnType = 'dwError'
		AND @DerivedColumnName = 'RowData'
	BEGIN
		SELECT @DynamicValue = CONCAT (
				'"'
				,(
					SELECT ldic.ColumnName AS 'Name'
						,CONCAT (
							'"+(DT_WSTR,150)REPLACENULL('
							,ldic.ColumnName
							,', "NULL")+"'
							) AS 'Value'
					FROM [ssis].[LookupDimensionInputColumns] ldic
					WHERE tableCatalog = @DESTINATION_TABLE_CATALOG
						/* Jukka de-activated 2016-05-02
				and SchemaName = 'Avega' -- TODO !! Add SchemaName
				*/
						AND TableName = @DESTINATION_TABLE_NAME
					FOR XML path('Column')
						,root('Row')
					)
				,'"'
				)
	END

	RETURN @DynamicValue
END