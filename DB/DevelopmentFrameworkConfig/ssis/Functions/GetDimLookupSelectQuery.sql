
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns the select query, for the lookup component, for the current lookup
--		table.
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetDimLookupSelectQuery] (
	@DIMENSION_TABLE_CATALOG VARCHAR(50)
	,@DIMENSION_SCHEMA_NAME VARCHAR(50)
	,@DIMENSION_TABLE_NAME VARCHAR(50)
	,@INCLUDE_HASH BIT = 0
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @SelectQuery VARCHAR(max)
	DECLARE @T TABLE (
		DimensionCatalogName VARCHAR(max)
		,DimensionSchemaName VARCHAR(max)
		,DimensionName VARCHAR(max)
		,ColumnList VARCHAR(max)
		)

	INSERT INTO @T (
		DimensionCatalogName
		,DimensionSchemaName
		,DimensionName
		,ColumnList
		)
	SELECT DimensionCatalogName
		,DimensionSchemaName
		,DimensionName
		,cols
	FROM (
		SELECT DISTINCT DimensionCatalogName
			,DimensionSchemaName
			,DimensionName
			,stuff((
					SELECT ', ' + QUOTENAME(COLUMN_NAME)
					FROM ssis.LookupDimensionKeyColumns
					WHERE DimensionCatalogName = ldkc.DimensionCatalogName
						AND isnull(DimensionSchemaName, ldkc.DimensionSchemaName) = ldkc.DimensionSchemaName
						AND isnull(DimensionName, ldkc.DimensionName) = ldkc.DimensionName
					ORDER BY Ordinal_Position
					FOR XML path('')
					), 1, 1, ' ') cols
		FROM ssis.LookupDimensionKeyColumns ldkc
		WHERE DimensionCatalogName = @DIMENSION_TABLE_CATALOG
			AND isnull(DimensionSchemaName, @DIMENSION_SCHEMA_NAME) = @DIMENSION_SCHEMA_NAME
			AND isnull(DimensionName, @DIMENSION_TABLE_NAME) = @DIMENSION_TABLE_NAME
		) cols
	WHERE NOT cols IS NULL

	IF @INCLUDE_HASH = 1
	BEGIN
		SELECT @SelectQuery = (
				SELECT
					--	'Select top 1 ' + t.ColumnList + ', ' + hc.[CheckSumNonPK] + ' as [CheckSumNonPK]  from ['+@DIMENSION_SCHEMA_NAME+'].['+@DIMENSION_TABLE_NAME+'] ORDER BY FromDate DESC'  as Source_Query
					'Select ' + t.ColumnList + ', ' + hc.[CheckSumNonPK] + ' as [CheckSumNonPK]  
					from [' + @DIMENSION_SCHEMA_NAME + '].[' + @DIMENSION_TABLE_NAME + '] n
						cross apply (select top 1 SysValidFromDateTime as SysValidFromDateTimeLatest  
									from [' + @DIMENSION_SCHEMA_NAME + '].[' + @DIMENSION_TABLE_NAME + '] n2
									where n2.[' + substring(@DIMENSION_TABLE_NAME, 3, 100) + '_bkey] = n.[' + substring(@DIMENSION_TABLE_NAME, 3, 100) +'_bkey]
									order by SysValidFromDateTime DESC) n2
					where n.[SysValidFromDateTime] = n2.[SysValidFromDateTimeLatest]
					' AS Source_Query
				FROM @T t
				JOIN [ssis].[HashColumn] hc ON hc.DestinationTableCatalog = t.DimensionCatalogName
					AND hc.DestinationSchemaName = t.DimensionSchemaName
					AND hc.DestinationTableName = t.DimensionName
				)
	END

	IF @INCLUDE_HASH = 0
	BEGIN
		SELECT @SelectQuery = (
				SELECT
					--	'Select top 1 ' + t.ColumnList + ' from ['+@DIMENSION_SCHEMA_NAME+'].['+@DIMENSION_TABLE_NAME+'] ORDER BY FromDate DESC'  as Source_Query
					'Select ' + t.ColumnList + ' from [' + @DIMENSION_SCHEMA_NAME + '].[' + @DIMENSION_TABLE_NAME + '] ORDER BY SysValidFromDateTime DESC' AS Source_Query
				FROM @T t
				)
	END

	RETURN @SelectQuery
END