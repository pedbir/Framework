
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[LookupDimensionInputColumns]
AS
SELECT t.TableCatalog
	,t.SchemaName
	,t.TableName
	,t.COLUMN_NAME ColumnName
	,t.KeyColumnOrder
FROM Metadata.TableKeyDefinition t
WHERE TableCatalog IN ((SELECT TOP 1 [NormEnvironmentName]
					FROM [Metadata].[EnvironmentVariables]), 
					    (SELECT TOP 1 RawEnvironmentName
					    FROM [Metadata].[EnvironmentVariables]))
	-- add where KeyType = 'PK' ??
	AND NOT EXISTS (
		SELECT 1
		FROM [Metadata].[DestinationFieldExtended]
		WHERE DestinationTableCatalog IN ((SELECT TOP 1 [NormEnvironmentName]
									FROM [Metadata].[EnvironmentVariables]), 
										  (SELECT TOP 1 RawEnvironmentName
										  FROM [Metadata].[EnvironmentVariables]))
			AND SourceTableCatalog = (SELECT TOP 1 [StagingEnvironmentName]
										FROM [Metadata].[EnvironmentVariables])
			AND IsNull(ApplicableTable, t.TableName) = t.TableName
			AND COLUMN_NAME = t.COLUMN_NAME
		)
	AND t.COLUMN_NAME NOT LIKE 'SysValidFromDatetime'