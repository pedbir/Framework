
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[HashColumn]
AS
SELECT SourceServer
	,TABLE_CATALOG
	,TABLE_SCHEMA
	,TABLE_NAME
	,
	-- Destination columns should be used when view is applied for DW and DM layer
	DestinationTableCatalog
	,DestinationSchemaName
	,DestinationTableName
	,'CONVERT(VARCHAR(40), HASHBYTES(''SHA1'',' + ColsForHashInput + '))' AS CheckSumNonPK
FROM (
	SELECT DISTINCT dt.SourceServer
		,sf.TABLE_CATALOG
		,sf.TABLE_SCHEMA
		,sf.TABLE_NAME
		,sf.DestinationTableCatalog
		,dt.DestinationSchemaName
		,dt.DestinationTableName
		,stuff((
				SELECT CASE 
						WHEN COLUMN_NAME LIKE '%_bkey'
							-- Foreign Key. Set value to '-1'
							THEN '+IsNull(CAST(' + column_name + ' as nvarchar(max)), ''-1'')'
								-- Set value to empty string
						ELSE '+IsNull(CAST(' + column_name + ' as nvarchar(max)), '''')'
						END
				FROM Metadata.SourceField x
				WHERE x.TABLE_CATALOG = sf.table_catalog
					AND x.TABLE_SCHEMA = sf.table_schema
					AND x.table_name = sf.table_name
					AND x.DestinationTableCatalog = sf.DestinationTableCatalog
					AND x.COLUMN_NAME NOT IN (
						'HistoryRecId'
						,'SourceSystemKey'
						)
					-- Primary key should always be excluded from the Hash
					AND x.COLUMN_NAME NOT IN (
						SELECT kc.Column_Name
						FROM ssis.LookupDimensionKeyColumns kc
						WHERE kc.DimensionCatalogName = dt.DestinationTableCatalog
							AND kc.DimensionSchemaName = dt.DestinationSchemaName
							AND kc.DimensionName = dt.DestinationTableName
						)
					-- SysSrcGenerationDateTime shouldn´t be included in the HASH either
					AND x.COLUMN_NAME NOT IN ('SysSrcGenerationDateTime')
				ORDER BY ordinal_position
				FOR XML path('')
				), 1, 1, '') ColsForHashInput
	FROM Metadata.SourceField sf
	JOIN Metadata.DestinationTable dt ON sf.TABLE_CATALOG = dt.SourceTableCatalog
		AND sf.TABLE_SCHEMA = dt.SourceSchemaName
		AND sf.TABLE_NAME = dt.SourceTableName
	) HashInput