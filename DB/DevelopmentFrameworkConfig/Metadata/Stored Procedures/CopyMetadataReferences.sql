-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Copies meta data references, from a given table, from a database to another
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[CopyMetadataReferences] @FromDatabase NVARCHAR(128)
	,@ToDatabase NVARCHAR(128)
	,@FromDatabaseSource NVARCHAR(128)
	,@ToDatabaseSource NVARCHAR(128)
	,@CurrentDestinationTableNameToCopy NVARCHAR(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @CurrentSourceTableNameToCopy NVARCHAR(128) = (
				SELECT SourceTableName
				FROM [Metadata].[DestinationTable]
				WHERE DestinationTableName = @CurrentDestinationTableNameToCopy
					AND DestinationTableCatalog = @FromDatabase
				)

		-- Insert meta data into the SourceField table
		IF NOT EXISTS (
				SELECT 1
				FROM [Metadata].[SourceField]
				WHERE DestinationTableCatalog = @ToDatabaseSource
					AND TABLE_NAME = @CurrentSourceTableNameToCopy
				)
		BEGIN
			INSERT INTO [Metadata].[SourceField] (
				TABLE_CATALOG
				,TABLE_SCHEMA
				,TABLE_NAME
				,COLUMN_NAME
				,ORDINAL_POSITION
				,COLUMN_DEFAULT
				,IS_NULLABLE
				,DATA_TYPE
				,CHARACTER_MAXIMUM_LENGTH
				,CHARACTER_OCTET_LENGTH
				,NUMERIC_PRECISION
				,NUMERIC_PRECISION_RADIX
				,NUMERIC_SCALE
				,DATETIME_PRECISION
				,CHARACTER_SET_CATALOG
				,CHARACTER_SET_SCHEMA
				,CHARACTER_SET_NAME
				,COLLATION_CATALOG
				,COLLATION_SCHEMA
				,COLLATION_NAME
				,DOMAIN_CATALOG
				,DOMAIN_SCHEMA
				,DOMAIN_NAME
				,DestinationTableCatalog
				,TABLE_SERVER
				)
			SELECT @ToDatabaseSource
				,TABLE_SCHEMA
				,TABLE_NAME
				,COLUMN_NAME
				,ORDINAL_POSITION
				,COLUMN_DEFAULT
				,IS_NULLABLE
				,DATA_TYPE
				,CHARACTER_MAXIMUM_LENGTH
				,CHARACTER_OCTET_LENGTH
				,NUMERIC_PRECISION
				,NUMERIC_PRECISION_RADIX
				,NUMERIC_SCALE
				,DATETIME_PRECISION
				,CHARACTER_SET_CATALOG
				,CHARACTER_SET_SCHEMA
				,CHARACTER_SET_NAME
				,COLLATION_CATALOG
				,COLLATION_SCHEMA
				,COLLATION_NAME
				,DOMAIN_CATALOG
				,DOMAIN_SCHEMA
				,DOMAIN_NAME
				,@ToDatabase
				,TABLE_SERVER
			FROM [Metadata].[SourceField]
			WHERE DestinationTableCatalog = @FromDatabase
				AND TABLE_NAME = @CurrentSourceTableNameToCopy

			PRINT 'Inserted records into [Metadata].[SourceField]'
		END
		ELSE
			PRINT '[Metadata].[SourceField] skipped'

		-- Insert meta data for PK definition
		IF NOT EXISTS (
				SELECT 1
				FROM [Metadata].[SourceField]
				WHERE DestinationTableCatalog = @ToDatabase
					AND TABLE_NAME = @CurrentSourceTableNameToCopy
				)
		BEGIN
			INSERT INTO [Metadata].[TableKeyDefinition] (
				TableCatalog
				,SchemaName
				,TableName
				,TableKeyName
				,COLUMN_NAME
				,DATA_TYPE
				,KeyType
				,KeyColumnOrder
				,IncludedColumn
				)
			SELECT @ToDatabase
				,SchemaName
				,TableName
				,TableKeyName
				,COLUMN_NAME
				,DATA_TYPE
				,KeyType
				,KeyColumnOrder
				,IncludedColumn
			FROM [Metadata].[TableKeyDefinition]
			WHERE TableCatalog = @FromDatabase
				AND TableName = @CurrentDestinationTableNameToCopy
				AND KeyType = 'PK'

			PRINT 'Inserted records into [Metadata].[TableKeyDefinition]'
		END
		ELSE
			PRINT '[Metadata].[TableKeyDefinition] skipped'

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT 'Failure'

		ROLLBACK TRANSACTION
	END CATCH
END