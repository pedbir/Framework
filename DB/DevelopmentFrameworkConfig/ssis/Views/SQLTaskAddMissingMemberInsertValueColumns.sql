

-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[SQLTaskAddMissingMemberInsertValueColumns]
AS
SELECT Table_Catalog
	,Table_Schema
	,Table_Name
	,COLUMN_NAME
	,CASE 
		WHEN column_name = 'SysDatetimeDeletedUTC'
			THEN 'null'
		WHEN data_type LIKE '%date%'
			THEN '''1900-01-01'''
		WHEN column_name LIKE '%_bkey'
			THEN '''-1'''
		WHEN COLUMN_NAME = 'SysValidFromDateTime'
			THEN '''1900-01-01'''
		WHEN COLUMN_NAME = 'ToDate'
			THEN '''9999-12-31'''
		WHEN column_name = 'SysDatetimeInsertedUTC'
			THEN '''' + CONVERT(CHAR(10), GetDate(), 126) + ''''
		WHEN DATA_TYPE LIKE '%char%'
			OR DATA_TYPE LIKE '%text%'
			THEN '''N/A'''
		WHEN DATA_TYPE = 'varbinary'
			OR data_type = 'binary'
			THEN 'null'
		WHEN data_type IN (
				'int'
				,'bigint'
				,'money'
				,'smallmoney'
				,'decimal'
				,'tinyint'
				,'float'
				,'bit'
				,'numeric'
				)
			THEN '0'
		WHEN data_type = 'uniqueidentifier'
			THEN '''00000000-0000-0000-0000-000000000000'''
		ELSE '''-1'''
		END ValueCol
	,DestinationTableCatalog
	,'-' as DestinationSchemaName
	,data_type
	,1 AS ordNo
	,ORDINAL_POSITION
FROM Metadata.SourceField

UNION ALL

SELECT SourceTableCatalog AS Table_Catalog
	,NULL AS Table_Schema
	,applicableTable AS Table_Name
	,column_name AS Insert_Column
	,CASE 
		WHEN column_name = 'SysDatetimeInsertedUTC'
			THEN 'GETUTCDATE()'
		WHEN COLUMN_NAME = 'SysValidFromDateTime'
			THEN '''1900-01-01'''
		WHEN data_type LIKE '%date%'
			THEN 'GETUTCDATE()'
		WHEN column_name LIKE '%_bkey'
			THEN '''-1'''
		WHEN column_name = 'SysExecutionLog_key'
			THEN '?'
		WHEN COLUMN_NAME = 'ToDate'
			THEN '''9999-12-31'''
		WHEN DATA_TYPE LIKE '%char%'
			OR DATA_TYPE LIKE '%text%'
			OR data_type = 'varbinary'
			THEN '''N/A'''
		WHEN data_type IN (
				'int'
				,'bigint'
				,'money'
				,'smallmoney'
				,'decimal'
				,'tinyint'
				,'float'
				,'bit'
				,'numeric'
				)
			THEN '0'
		WHEN data_type = 'uniqueidentifier'
			THEN '''00000000-0000-0000-0000-000000000000'''
		ELSE '''-1'''
		END ValueCol
	,DestinationTableCatalog
	,DestinationSchemaName
	,data_type
	,2 AS ordNo
	,ORDINAL_POSITION
FROM [Metadata].[DestinationFieldExtended]
--where (SSISColumnSpecification IS NOT NULL)
WHERE ApplicableTable IS NULL
	AND DestinationTableCatalog IN (	(SELECT TOP 1 [NormEnvironmentName]
								FROM [Metadata].[EnvironmentVariables]), 
									    (SELECT TOP 1 RawEnvironmentName
									    FROM [Metadata].[EnvironmentVariables]))
	AND NOT SSISColumnSpecification IS NULL
	AND (
		SetFieldOnInsert = 1
		OR COLUMN_NAME IN (
			'SysValidFromDateTime'
			,'ToDate'
			)
		)
-- include table specific extended fields. setfield on insert is set to 0 but needed. 
-- AS applicable table does not have same name as source it needs to be 
-- fetched via destinationTable. dStore in DW have name dStoreV in stage

UNION ALL

SELECT dt.SourceTableCatalog AS Table_Catalog
	,dt.SourceSchemaName AS Table_Schema
	,dt.SourceTableName AS Table_Name
	,-- apply source name and not destination
	column_name AS Insert_Column
	,CASE 
		WHEN data_type LIKE '%date%'
			THEN '''1900-01-01'''
		WHEN column_name LIKE '%_bkey'
			THEN '''-1'''
		WHEN column_name LIKE '%_key'
			THEN '''-1'''
		WHEN DATA_TYPE LIKE '%char%'
			OR DATA_TYPE LIKE '%text%'
			OR data_type = 'varbinary'
			THEN '''N/A'''
		WHEN data_type IN (
				'int'
				,'bigint'
				,'money'
				,'smallmoney'
				,'decimal'
				,'tinyint'
				,'float'
				,'bit'
				,'numeric'
				)
			THEN '0'
		WHEN data_type = 'uniqueidentifier'
			THEN '''00000000-0000-0000-0000-000000000000'''
		ELSE '''-1'''
		END ValueCol
	,ext.DestinationTableCatalog
	,ext.DestinationSchemaName
	,data_type
	,2 AS ordNo
	,ORDINAL_POSITION
FROM Metadata.DestinationFieldExtended ext
JOIN Metadata.DestinationTable dt ON ext.ApplicableTable = dt.DestinationTableName
	AND ext.DestinationTableCatalog = dt.DestinationTableCatalog
	AND ext.SourceTableCatalog = dt.SourceTableCatalog
	AND ext.DestinationSchemaName = dt.DestinationSchemaName
WHERE NOT ext.ApplicableTable IS NULL