

-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns the result set of all the columns, with their specifications,
--		that will be part of the derived columns in the SSIS Dataflow
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[DerivedColumns]
AS
SELECT SourceTableCatalog
	,CAST(NULL AS VARCHAR(MAX)) AS SourceSchemaName
	,DestinationTableCatalog
	,ApplicableTable DestinationTableName
	,Column_Name
	,CAST(NULL AS VARCHAR(128)) AS ForeignKeyTable
	,
	--SSISDataType as Data_Type,
	dtt.Biml AS Data_Type
	,SSISColumnSpecification AS Col
	,CASE dtt.DataTypeGroup
		WHEN 'Numeric'
			THEN '-1'
		WHEN 'Text'
			THEN '"-1"'
		WHEN 'Date'
			THEN SSISColumnSpecification
		ELSE '"-1"'
		END AS ColMissingMember
	,character_maximum_length AS ColMaxLength
	,'false' AS ReplaceExisting
	,SetFieldOnInsert
	,SetFieldOnUpdate
	,SetFieldOnDelete
	,GroupName
	,dfe.DestinationSchemaName
FROM [Metadata].[DestinationFieldExtended] dfe
JOIN Metadata.DataTypeTranslation dtt ON dfe.DATA_TYPE = dtt.SQLServer
WHERE SSISColumnSpecification IS NOT NULL
-- add foreign keys if destination is DW or DM layer

UNION ALL



SELECT ds.SourceTableCatalog
	,ds.SourceSchemaName
	,ds.DestinationTableCatalog
	,ds.DestinationTableName
	,ds.COLUMN_NAME
	,tkd.TableName AS ForeignKeyTable
	,dtt.Biml AS Data_Type
	,CASE dtt.DataTypeGroup
		WHEN 'Numeric'
			THEN 'ISNULL(' + ds.column_name + ') ? -1 : ' + ds.column_name
		WHEN 'Text'
			THEN 'ISNULL(' + ds.column_name + ') ? "-1" : ' + ds.column_name
	     WHEN 'Date'
			THEN 'ISNULL(' + ds.column_name + ') ? (DT_DBTIMESTAMP)"1990-01-01" : ' + ds.column_name
		ELSE 'ISNULL(' + ds.column_name + ') ? "-1" : ' + ds.column_name
		END AS Col
	,CASE dtt.DataTypeGroup
		WHEN 'Numeric'
			THEN '-1'
		WHEN 'Text'
			THEN '"-1"'
	     WHEN 'Date'
		  THEN '"1990-01-01"'
		ELSE '"-1"'
		END AS ColMissingMember
	,ds.character_maximum_length AS ColMaxLength
	,'true' AS ReplaceExisting
	,0 AS SetFieldOnInsert
	,0 AS SetFieldOnUpdate
	,0 AS SetFieldOnDelete
	,'Dim/Fact' AS GroupName
	,ds.DestinationSchemaName
FROM Metadata.DestinationTableSourceField ds
JOIN Metadata.DataTypeTranslation dtt ON ds.DATA_TYPE = dtt.SQLServer
-- Get Foreign Key table
LEFT JOIN Metadata.TableKeyDefinition tkd ON tkd.TableCatalog = ds.DestinationTableCatalog
	AND tkd.SchemaName = ds.DestinationSchemaName
	AND tkd.COLUMN_NAME = ds.COLUMN_NAME
	AND tkd.KeyType = 'PK'
	AND STUFF(tkd.TableName, 1, 1, '') = REPLACE(tkd.column_name, '_bkey', '')
WHERE ds.DestinationTableCatalog IN (
		(SELECT TOP 1 [NormEnvironmentName]
		FROM [Metadata].[EnvironmentVariables])
		, (SELECT TOP 1 [MartEnvironmentName]
			FROM [Metadata].[EnvironmentVariables])
		)
	AND ds.COLUMN_NAME LIKE '%_bkey'
	AND REPLACE(ds.column_name, '_bkey', '') != STUFF(ds.destinationTableName, 1, 1, '')