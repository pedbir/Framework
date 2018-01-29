-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE VIEW [ssis].[SQLTaskMergeDiffColumns]
AS
SELECT TABLE_CATALOG
	,TABLE_SCHEMA
	,TABLE_NAME
	,DestinationTableCatalog
	,CASE 
		WHEN IS_NULLABLE = 'NO'
			THEN 'dst.' + QUOTENAME(column_name) + ' != src.' + QUOTENAME(column_name)
		ELSE 'IsNull(Convert(nvarchar(max),dst.' + QUOTENAME(column_name) + '),'''') !=IsNull(Convert(nvarchar(max),src.' + QUOTENAME(column_name) + '),'''')'
		END DiffCols
FROM Metadata.SourceField f
WHERE NOT EXISTS (
		SELECT COLUMN_NAME
		FROM Metadata.TableKeyDefinition pkd
		WHERE KeyType = 'PK'
			AND f.TABLE_NAME = pkd.TableName
			AND f.COLUMN_NAME = pkd.COLUMN_NAME
		)
	AND NOT EXISTS (
		SELECT COLUMN_NAME
		FROM [Metadata].[DestinationFieldExtended] fe
		WHERE fe.DestinationTableCatalog = f.DestinationTableCatalog
			AND f.COLUMN_NAME = fe.COLUMN_NAME
		)