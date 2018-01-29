-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[SQLTaskMergeUpdateColumns]
AS
SELECT TABLE_CATALOG
	,TABLE_SCHEMA
	,TABLE_NAME
	,DestinationTableCatalog
	,QUOTENAME(column_name) + '=src.' + QUOTENAME(column_name) UpdateCols
	,1 AS ordNo
	,ORDINAL_POSITION
FROM Metadata.SourceField f
WHERE NOT EXISTS (
		SELECT COLUMN_NAME
		FROM Metadata.TableKeyDefinition pkd
		WHERE KeyType = 'PK'
			AND f.TABLE_NAME = pkd.TableName
			AND f.COLUMN_NAME = pkd.COLUMN_NAME
		)

UNION

SELECT SourceTableCatalog AS TABLE_CATALOG
	,NULL AS TABLE_SCHEMA
	,applicableTable AS TABLE_NAME
	,DestinationTableCatalog AS DestinationTableCatalog
	,column_name + '=?' AS UpdateCols
	,2 AS ordNo
	,ORDINAL_POSITION
FROM [Metadata].[DestinationFieldExtended]
WHERE SSISColumnSpecification IS NOT NULL
	AND SetFieldOnUpdate = 1
	AND COLUMN_NAME != 'SysExecutionLog_key'