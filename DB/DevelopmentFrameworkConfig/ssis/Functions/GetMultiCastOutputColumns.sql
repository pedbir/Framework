-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	 
--		Returns the BIML code to handle outputpaths for 
--		foreign key constraints in the SSIS multicast component.
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetMultiCastOutputColumns] (
	@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_SCHEMA VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@MultiCastType VARCHAR(50)
	)
RETURNS XML
AS
BEGIN
	DECLARE @OutputPaths XML

	IF @MultiCastType = 'dwInfFK'
	BEGIN
		SELECT @OutputPaths = (
				SELECT fkc.ForeignKeyColumn AS '@Name'
				FROM ssis.DimensionForeignKeyColumns fkc
				WHERE fkc.DimensionTableCatalog = @DESTINATION_TABLE_CATALOG
					AND fkc.DimensionSchemaName = @DESTINATION_TABLE_SCHEMA
					AND fkc.DimensionTableName = @DESTINATION_TABLE_NAME
				ORDER BY ForeignKeyColumn
				FOR XML path('OutputPath')
				)
	END

	RETURN @OutputPaths
END