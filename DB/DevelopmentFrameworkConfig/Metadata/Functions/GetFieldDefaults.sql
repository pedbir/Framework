-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetFieldDefaults] (
	@SourceTableCatalog VARCHAR(128)
	,@SourceSchemaName VARCHAR(128)
	,
	--@SourceTableName varchar(128),
	@DestinationTableCatalog VARCHAR(128)
	,@DestinationSchemaName VARCHAR(128)
	,@DestinationTableName VARCHAR(128)
	)
RETURNS TABLE
AS
RETURN (
		SELECT [COLUMN_NAME] AS ColumnName
			,CASE [DATA_TYPE]
				WHEN 'nvarchar'
					THEN 'String'
				WHEN 'varchar'
					THEN 'String'
				WHEN 'int'
					THEN 'Int32'
				WHEN 'bigint'
					THEN 'Int64'
				WHEN 'bit'
					THEN 'Boolean'
				WHEN 'smallint'
					THEN 'Int16'
				WHEN 'date'
					THEN 'DateTime'
				WHEN 'numeric'
					THEN 'Double'
				ELSE [DATA_TYPE]
				END AS DataType
			,[CHARACTER_MAXIMUM_LENGTH] AS CharLength
			,CASE 
				WHEN [DATA_TYPE] IN (
						'nvarchar'
						,'varchar'
						)
					THEN '-1'
				WHEN [DATA_TYPE] IN (
						'bigint'
						,'int'
						,'numeric'
						,'smallint'
						)
					THEN '-1'
				WHEN [DATA_TYPE] = 'bit'
					THEN 'False'
				WHEN [DATA_TYPE] LIKE 'date%'
					THEN '1900-01-01'
				END AS DefaultValue
		FROM Metadata.DestinationTable dt
		JOIN [Metadata].[SourceField] sf ON sf.TABLE_NAME = dt.SourceTableName
			AND sf.TABLE_SCHEMA = dt.SourceSchemaName
			AND sf.TABLE_CATALOG = dt.SourceTableCatalog
			AND sf.DestinationTableCatalog = dt.DestinationTableCatalog
		WHERE TABLE_CATALOG = @SourceTableCatalog
			AND TABLE_SCHEMA = @SourceSchemaName
			AND sf.DestinationTableCatalog = @DestinationTableCatalog
			AND DestinationSchemaName = @DestinationSchemaName
			AND dt.DestinationTableName = @DestinationTableName
			AND NOT EXISTS (
				SELECT COLUMN_NAME
				FROM Metadata.TableKeyDefinition pkd
				WHERE KeyType = 'PK'
					AND pkd.TableCatalog = sf.DestinationTableCatalog
					AND pkd.SchemaName = dt.DestinationSchemaName
					AND pkd.TableName = dt.DestinationTableName
					AND pkd.COLUMN_NAME = sf.COLUMN_NAME
				)
			AND (
				IS_NULLABLE = 'NO'
				OR COLUMN_NAME = 'HistoryRecId'
				OR COLUMN_NAME LIKE '%_bkey'
				)
		);