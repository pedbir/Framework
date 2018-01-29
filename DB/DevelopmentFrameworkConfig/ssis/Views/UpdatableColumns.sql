-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[UpdatableColumns]
AS
SELECT dt.SourceTableCatalog
	,dt.SourceSchemaName
	,dt.SourceTableName
	,dt.DestinationTableCatalog
	,dt.DestinationSchemaName
	,dt.DestinationTableName
	,COLUMN_NAME
	,f.ORDINAL_POSITION
FROM Metadata.SourceField f
JOIN Metadata.DestinationTable dt ON f.TABLE_CATALOG = dt.SourceTableCatalog
	AND f.TABLE_SCHEMA = dt.SourceSchemaName
	AND f.TABLE_NAME = dt.SourceTableName
WHERE NOT EXISTS (
		SELECT COLUMN_NAME
		FROM [Metadata].[DestinationFieldExtended] fe
		WHERE fe.DestinationTableCatalog = dt.DestinationTableCatalog
			AND f.COLUMN_NAME = fe.COLUMN_NAME
		)
	AND NOT EXISTS (
		SELECT COLUMN_NAME
		FROM Metadata.TableKeyDefinition pkd
		WHERE KeyType = 'PK'
			AND pkd.TableCatalog = dt.DestinationTableCatalog
			AND pkd.SchemaName = dt.DestinationSchemaName
			AND pkd.TableName = dt.DestinationTableName
			AND pkd.COLUMN_NAME = f.COLUMN_NAME
		)