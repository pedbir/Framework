-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Removes meta data for a current target table
-- Example:	
/* 
	EXECUTE [Metadata].[RemoveMetaData]
		@DestinationTableDataBase = 'DWH_2_Norm',
		@SourceTableDataBase = 'DWH_1_Raw',
		@DestinationTableName = 'dPerson'
*/
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[RemoveMetaData] @DestinationTableDataBase NVARCHAR(128)
	,@SourceTableDataBase NVARCHAR(128)
	,@DestinationTableName NVARCHAR(128)
	,@DestinationSchemaName NVARCHAR(128)
AS
BEGIN
	-- Set database variables
	DECLARE @ToDatabase NVARCHAR(128) = @DestinationTableDataBase
		,@ToDatabaseSource NVARCHAR(128) = @SourceTableDataBase
		,@CurrentDestinationTableNameToDelete NVARCHAR(128) = @DestinationTableName
	DECLARE @CurrentSourceTableNameToUpdate NVARCHAR(128) = (
			SELECT SourceTableName
			FROM [Metadata].[DestinationTable]
			WHERE DestinationTableName = @CurrentDestinationTableNameToDelete
				AND DestinationTableCatalog = @ToDatabase
				AND DestinationSchemaName = @DestinationSchemaName
			)

	DECLARE @CurrentSourceTableSchemaToUpdate NVARCHAR(128) = (
			SELECT SourceSchemaName
			FROM [Metadata].[DestinationTable]
			WHERE DestinationTableName = @CurrentDestinationTableNameToDelete
				AND DestinationTableCatalog = @ToDatabase
				AND DestinationSchemaName = @DestinationSchemaName
			)

	DECLARE @CurrentSSISPackageName NVARCHAR(128) = (
			SELECT SSISPackageName
			FROM [Metadata].[DestinationTable]
			WHERE DestinationTableName = @CurrentDestinationTableNameToDelete
				AND DestinationTableCatalog = @ToDatabase
				AND DestinationSchemaName = @DestinationSchemaName
			)

	-- Delete meta data table "DestinationFieldExtended" -> Target/Source attributes
	--/*
	PRINT ' Deleting : DestinationFieldExtended'

	DELETE
	FROM [Metadata].[DestinationFieldExtended]
	WHERE DestinationTableCatalog = @ToDatabase
		AND SourceTableCatalog = @ToDatabaseSource
		AND DestinationSchemaName = @DestinationSchemaName
		AND ApplicableTable = @CurrentDestinationTableNameToDelete

	-- Delete meta data table "DestinationTable" -> Target attributes
	PRINT ' Deleting : DestinationTable'

	DELETE
	FROM [Metadata].[DestinationTable]
	--*/
	WHERE DestinationTableCatalog = @ToDatabase
		AND SourceTableCatalog = @ToDatabaseSource
		AND DestinationTableName = @CurrentDestinationTableNameToDelete
		AND DestinationSchemaName = @DestinationSchemaName

	-- Update meta data table "SourceField" -> Target attributes
	--/*
	PRINT ' Deleting : SourceField'

	DELETE
	FROM [Metadata].[SourceField]
	WHERE DestinationTableCatalog = @ToDatabase
		AND Table_Name = @CurrentSourceTableNameToUpdate
		AND TABLE_SCHEMA = @CurrentSourceTableSchemaToUpdate

	-- Update meta data table "TableKeyDefinition" -> Target attributes
	PRINT ' Deleting : TableKeyDefinition'

	DELETE
	FROM [Metadata].[TableKeyDefinition]
	WHERE TableCatalog = @ToDatabase
		AND TableName = @CurrentDestinationTableNameToDelete
		AND SchemaName = @DestinationSchemaName
END