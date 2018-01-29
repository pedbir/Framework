-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[SQLTaskMergeInsertValueColumns]
AS
SELECT Table_Catalog
	,Table_Schema
	,Table_Name
	,QUOTENAME(COLUMN_NAME) Insert_Column
	,QUOTENAME(COLUMN_NAME) AS Value_Column
	,DestinationTableCatalog
	,1 AS ordNo
	,ORDINAL_POSITION
FROM Metadata.SourceField

UNION ALL

SELECT SourceTableCatalog AS Table_Catalog
	,NULL AS Table_Schema
	,applicableTable AS Table_Name
	,column_name AS Insert_Column
	,'?' AS Value_Column
	,DestinationTableCatalog
	,2 AS ordNo
	,ORDINAL_POSITION
FROM [Metadata].[DestinationFieldExtended]
WHERE SSISColumnSpecification IS NOT NULL
	AND SetFieldOnInsert = 1