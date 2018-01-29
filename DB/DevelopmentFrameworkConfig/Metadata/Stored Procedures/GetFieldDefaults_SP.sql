-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[GetFieldDefaults_SP] (
	@SourceTableCatalog SYSNAME
	,@SourceSchemaName SYSNAME
	,@SourceTableName SYSNAME
	,@DestinationTableCatalog SYSNAME
	,@DestinationSchemaName SYSNAME
	,@DestinationTableName SYSNAME
	)
AS
SELECT [COLUMN_NAME] AS ColumnName
	,CASE [DATA_TYPE]
		WHEN 'nvarchar'
			THEN 'String'
		WHEN 'varchar'
			THEN 'String'
		WHEN 'tinyint'
			THEN 'Byte'
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
WHERE dt.SourceTableCatalog = @SourceTableCatalog
	AND dt.SourceSchemaName = @SourceSchemaName
	AND dt.SourceTableName = @SourceTableName
	AND dt.DestinationTableCatalog = @DestinationTableCatalog
	AND dt.DestinationSchemaName = @DestinationSchemaName
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
		);