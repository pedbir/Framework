CREATE VIEW [Deployment].[ObjectChangeLog]
AS
SELECT SourceTableCatalog + '.' + SourceSchemaName + '.' + SourceTableName AS ObjectName
	,VersionComment
	,UserNameInserted AS UserNameChanged
	,max(DateTimeInsertedUTC) AS LastChangedUTC
	,'View' AS ObjectType
FROM [Metadata].[DestinationTableLog]
GROUP BY SourceTableCatalog
	,SourceSchemaName
	,SourceTableName
	,VersionComment
	,UserNameInserted

UNION

SELECT DestinationTableCatalog + '.' + DestinationSchemaName + '.' + DestinationTableName AS ObjectName
	,VersionComment
	,UserNameInserted
	,max(DateTimeInsertedUTC) AS LastChangedUTC
	,'Table' AS ObjectType
FROM [Metadata].[DestinationTableLog]
GROUP BY DestinationTableCatalog
	,DestinationSchemaName
	,DestinationTableName
	,VersionComment
	,UserNameInserted

UNION

SELECT SSISPackageName AS ObjectName
	,VersionComment
	,dtl.UserNameInserted
	,max(dtl.DateTimeInsertedUTC) AS LastChangedUTC
	,'SSIS Package' AS ObjectType
FROM [Metadata].[DestinationTableLog] dtl
INNER JOIN [Metadata].[DestinationTable] dt ON dtl.SourceTableCatalog = dt.SourceTableCatalog
	AND dtl.SourceSchemaName = dt.SourceSchemaName
	AND dtl.SourceTableName = dt.SourceTableName
	AND dtl.DestinationTableCatalog = dt.DestinationTableCatalog
	AND dtl.DestinationSchemaName = dt.DestinationSchemaName
	AND dtl.DestinationTableName = dt.DestinationTableName
GROUP BY SSISPackageName
	,VersionComment
	,dtl.UserNameInserted