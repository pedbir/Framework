-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[SQLTaskMergeDeleteColumns]
AS
SELECT SourceTableCatalog AS TABLE_CATALOG
	,cast(NULL AS VARCHAR(max)) AS TABLE_SCHEMA
	,applicableTable AS TABLE_NAME
	,DestinationTableCatalog AS DestinationTableCatalog
	,column_name + '=?' AS DeleteCols
	,ORDINAL_POSITION
FROM [Metadata].[DestinationFieldExtended]
WHERE SSISColumnSpecification IS NOT NULL
	AND SetFieldOnDelete = 1