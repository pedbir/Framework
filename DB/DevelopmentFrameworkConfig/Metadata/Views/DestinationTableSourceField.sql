-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [Metadata].[DestinationTableSourceField]
AS
SELECT d.SourceTableCatalog
	,d.SourceSchemaName
	,d.SourceTableName
	,d.SourceFile
	,d.DestinationTableCatalog
	,d.DestinationSchemaName
	,d.DestinationTableName
	,d.StageTableCatalog
	,d.StageSchemaName
	,d.StageTableName
	,SourceFieldID
	,COLUMN_NAME
	,ORDINAL_POSITION
	,COLUMN_DEFAULT
	,IS_NULLABLE
	,DATA_TYPE
	,CHARACTER_MAXIMUM_LENGTH
	,CHARACTER_OCTET_LENGTH
	,NUMERIC_PRECISION
	,NUMERIC_PRECISION_RADIX
	,NUMERIC_SCALE
	,DATETIME_PRECISION
	,CHARACTER_SET_CATALOG
	,CHARACTER_SET_SCHEMA
	,CHARACTER_SET_NAME
	,COLLATION_CATALOG
	,COLLATION_SCHEMA
	,COLLATION_NAME
	,DOMAIN_CATALOG
	,DOMAIN_SCHEMA
	,DOMAIN_NAME
FROM Metadata.SourceField s
JOIN Metadata.DestinationTable d ON s.TABLE_CATALOG = d.SourceTableCatalog
	AND s.TABLE_SCHEMA = d.SourceSchemaName
	AND s.TABLE_NAME = d.SourceTableName