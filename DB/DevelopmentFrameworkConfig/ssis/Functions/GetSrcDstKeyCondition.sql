-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSrcDstKeyCondition] (
	@TABLE_CATALOG VARCHAR(max)
	,@SCHEMA_NAME VARCHAR(max)
	,@TABLE_NAME VARCHAR(max)
	,@COLUMN_SEPARATOR VARCHAR(50)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @KeyCondition VARCHAR(max)

	SELECT @KeyCondition = (
			SELECT stuff((
						SELECT CONCAT (
								@COLUMN_SEPARATOR
								,' dst.'
								,QUOTENAME(COLUMN_NAME)
								,' = src.' + QUOTENAME(COLUMN_NAME)
								,' '
								)
						FROM Metadata.TableKeyDefinition
						WHERE KeyType = 'PK'
							AND TableCatalog = @TABLE_CATALOG
							AND SchemaName = @SCHEMA_NAME
							AND TableName = @TABLE_NAME
						ORDER BY KeyColumnOrder ASC
						FOR XML path('')
						), 1, len(@COLUMN_SEPARATOR), '') KeyCondition
			)

	RETURN @KeyCondition
END