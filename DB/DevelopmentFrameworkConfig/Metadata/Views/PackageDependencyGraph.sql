-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [Metadata].[PackageDependencyGraph]
AS
-- InferredMemberDependencies --> Add recursivity together with a depth
SELECT dt.SSISPackageName
	,dtdependency.SSISPackageName AS DependentOnSSISPackageName
FROM Metadata.DestinationTable dt
LEFT OUTER JOIN Metadata.SourceField sf ON dt.DestinationTableCatalog = sf.DestinationTableCatalog
	AND dt.SourceTableCatalog = sf.TABLE_CATALOG
	AND dt.SourceSchemaName = sf.TABLE_SCHEMA
	AND dt.SourceTableName = sf.TABLE_NAME
	AND sf.COLUMN_NAME LIKE '%_bkey'
	AND replace(sf.COLUMN_NAME, '_bkey', '') NOT LIKE right(dt.SSISPackageName, len(replace(sf.COLUMN_NAME, 'Key', '')))
	AND sf.COLUMN_NAME NOT IN (
		'SysValidFromDateTime'
		,'ToDateKey'
		)
LEFT OUTER JOIN Metadata.DestinationTable dtdependency ON replace(sf.COLUMN_NAME, '_bkey', '') = replace(dtdependency.SSISPackageName, 'DW_d', '')
	AND dtdependency.DestinationTableCatalog = 'DataWarehouse'
WHERE sf.COLUMN_NAME IS NOT NULL
	AND dt.DestinationTableCatalog = 'DataWarehouse'