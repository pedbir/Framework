-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
/*
		Todo: Handle Extended field properly. 
		If DestinationFieldExtended column B is added in a later stage,
		rows with data that has not changed will not be updated in DW/DM layer
*/
-- =============================================




CREATE VIEW [ssis].[LookupDimensionKeyColumns]
AS
SELECT TableCatalog AS DimensionCatalogName
	,SchemaName AS DimensionSchemaName
	,TableName AS DimensionName
	,Column_Name
	,KeyColumnOrder Ordinal_Position
FROM Metadata.TableKeyDefinition pkd
WHERE (pkd.KeyType = 'PK') -- or column_name ='FromDate')
	AND TableCatalog IN (
		(SELECT TOP 1 [NormEnvironmentName]
		FROM [Metadata].[EnvironmentVariables])
		, (SELECT TOP 1 [MartEnvironmentName]
			FROM [Metadata].[EnvironmentVariables]), 
			    (SELECT TOP 1 RawEnvironmentName
			    FROM [Metadata].[EnvironmentVariables])
		) -- should only be used for DW/DM layer only

UNION

SELECT DestinationTableCatalog
	,NULL AS DimensionSchemaName
	,ApplicableTable AS DimensionName
	,Column_Name
	,Ordinal_Position
FROM Metadata.DestinationFieldExtended
WHERE DestinationTableCatalog IN (
		(SELECT TOP 1 [NormEnvironmentName]
		FROM [Metadata].[EnvironmentVariables])
		, (	SELECT TOP 1 [MartEnvironmentName]
			FROM [Metadata].[EnvironmentVariables])
			, (SELECT TOP 1 RawEnvironmentName
			    FROM [Metadata].[EnvironmentVariables])
		)
	AND (
		IsIdentity = 1
		OR column_name = 'SysIsInferred'
		)