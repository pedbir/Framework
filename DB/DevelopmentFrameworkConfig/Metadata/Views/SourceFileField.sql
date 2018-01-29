-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [Metadata].[SourceFileField]
AS
SELECT FileCatalog = [TABLE_CATALOG]
	,FileSchema = TABLE_SCHEMA
	,[FileName] = [TABLE_NAME]
	,[COLUMN_NAME]
	,[ORDINAL_POSITION]
	,[IS_NULLABLE]
	,[DATA_TYPE]
	,[CHARACTER_MAXIMUM_LENGTH]
	,[CHARACTER_OCTET_LENGTH]
	,[NUMERIC_PRECISION]
	,[NUMERIC_PRECISION_RADIX]
	,[NUMERIC_SCALE]
	,[DATETIME_PRECISION]
	,[DestinationTableCatalog]
	,[SourceFieldID]
FROM [Metadata].[SourceField]