-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns the select query that the source component
--		will use against the source.
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSourceSelectQuery] (
	@SOURCE_SERVER VARCHAR(50)
	,@SOURCE_CATALOG VARCHAR(50)
	,@SOURCE_SCHEMA_NAME VARCHAR(50)
	,@SOURCE_TABLE_NAME VARCHAR(50)
	,@DESTINATION_TABLE_CATALOG VARCHAR(50)
	,@INCLUDE_HASH BIT = 0
	,@INCREMENTALLOAD BIT = 0
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @SelectQuery VARCHAR(max)

	IF @INCLUDE_HASH = 1
	BEGIN
		SELECT @SelectQuery = (
				SELECT 'Select' + sf.cols + ', ' + hc.[CheckSumNonPK] + ' as [CheckSumNonPK]  from [' + @SOURCE_SCHEMA_NAME + '].[' + @SOURCE_TABLE_NAME + ']' + CASE 
						WHEN isnull(dt.SourceFilterCondition, '') != ''
							THEN ' Where ' + dt.SourceFilterCondition
						ELSE ''
						END Source_Query
				FROM (
					SELECT DISTINCT TABLE_SERVER
						,TABLE_CATALOG
						,TABLE_SCHEMA
						,TABLE_NAME
						,DestinationTableCatalog
						,stuff((
								SELECT ', ' + QUOTENAME(COLUMN_NAME) [text()]
								FROM Metadata.SourceField
								WHERE TABLE_CATALOG = f.TABLE_CATALOG
									AND TABLE_SCHEMA = f.TABLE_SCHEMA
									AND TABLE_NAME = f.TABLE_NAME
								ORDER BY ordinal_position
								FOR XML path('')
									,type
								).value('.', 'NVARCHAR(MAX)'), 1, 1, ' ') cols
					FROM Metadata.SourceField f
					) sf
				JOIN Metadata.DestinationTable dt ON isnull(sf.TABLE_SERVER, '') = isnull(dt.SourceServer, '')
					AND sf.TABLE_CATALOG = dt.SourceTableCatalog
					AND sf.TABLE_SCHEMA = dt.SourceSchemaName
					AND sf.TABLE_NAME = dt.SourceTableName
					AND sf.DestinationTableCatalog = dt.DestinationTableCatalog
				JOIN [ssis].[HashColumn] hc ON isnull(hc.SourceServer, '') = isnull(dt.SourceServer, '')
					AND hc.TABLE_CATALOG = dt.SourceTableCatalog
					AND hc.TABLE_SCHEMA = dt.SourceSchemaName
					AND hc.TABLE_NAME = dt.SourceTableName
					AND hc.DestinationTableCatalog = dt.DestinationTableCatalog
				WHERE (
						dt.SourceServer = @SOURCE_SERVER
						OR TABLE_SERVER IS NULL
						)
					AND dt.SourceTableCatalog = @SOURCE_CATALOG
					AND dt.SourceSchemaName = @SOURCE_SCHEMA_NAME
					AND dt.SourceTableName = @SOURCE_TABLE_NAME
					AND dt.DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
				)
	END

	IF @INCLUDE_HASH = 0
	BEGIN
		SELECT @SelectQuery = (
				SELECT 'Select' + sf.cols + ' from [' + @SOURCE_SCHEMA_NAME + '].[' + @SOURCE_TABLE_NAME + ']' + CASE 
						WHEN isnull(dt.SourceFilterCondition, '') != ''
							THEN ' Where ' + dt.SourceFilterCondition
						ELSE ''
						END Source_Query
				FROM (
					SELECT DISTINCT TABLE_SERVER
						,TABLE_CATALOG
						,TABLE_SCHEMA
						,TABLE_NAME
						,DestinationTableCatalog
						,stuff((
								SELECT ', ' + QUOTENAME(COLUMN_NAME) [text()]
								FROM Metadata.SourceField
								WHERE TABLE_CATALOG = f.TABLE_CATALOG
									AND TABLE_SCHEMA = f.TABLE_SCHEMA
									AND TABLE_NAME = f.TABLE_NAME
								ORDER BY ordinal_position
								FOR XML path('')
									,type
								).value('.', 'NVARCHAR(MAX)'), 1, 1, ' ') cols
					FROM Metadata.SourceField f
					) sf
				JOIN Metadata.DestinationTable dt ON isnull(sf.TABLE_SERVER, '') = isnull(dt.SourceServer, '')
					AND sf.TABLE_CATALOG = dt.SourceTableCatalog
					AND sf.TABLE_SCHEMA = dt.SourceSchemaName
					AND sf.TABLE_NAME = dt.SourceTableName
					AND sf.DestinationTableCatalog = dt.DestinationTableCatalog
				WHERE (
						dt.SourceServer = @SOURCE_SERVER
						OR TABLE_SERVER IS NULL
						)
					AND dt.SourceTableCatalog = @SOURCE_CATALOG
					AND dt.SourceSchemaName = @SOURCE_SCHEMA_NAME
					AND dt.SourceTableName = @SOURCE_TABLE_NAME
					AND dt.DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
				)
	END

	IF (@INCREMENTALLOAD = 1)
	BEGIN
		IF (@SelectQuery NOT LIKE '%Where%')
			SET @SelectQuery = @SelectQuery + CHAR(10) + 'WHERE SysModifiedUTC > cast(? as datetime2(0)) '
		ELSE
			SET @SelectQuery = @SelectQuery + CHAR(10) + '	and SysModifiedUTC > cast(? as datetime2(0)) '
	END

	RETURN @SelectQuery
END