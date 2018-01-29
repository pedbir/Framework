-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Updates meta data references, from a given table, from a database to another
-- Example:	
/* 
	EXECUTE [Metadata].[UpdateMetadataReferences]
				@FromDatabase = 'DataMart_Branch'
				, @ToDatabase = 'DataMart'
				, @FromDatabaseSource = 'DataWarehouse_Branch'
				, @ToDatabaseSource = 'DataWarehouse'
				, @CurrentDestinationTableNameToUpdate = 'Person'
*/
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[UpdateMetadataReferences] @FromDatabase NVARCHAR(128)
	,@ToDatabase NVARCHAR(128)
	,@FromDatabaseSource NVARCHAR(128)
	,@ToDatabaseSource NVARCHAR(128)
	,@CurrentDestinationTableNameToUpdate NVARCHAR(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION

	BEGIN TRY
		DECLARE @CurrentSourceTableNameToUpdate NVARCHAR(128) = (
				SELECT SourceTableName
				FROM [Metadata].[DestinationTable]
				WHERE DestinationTableName = @CurrentDestinationTableNameToUpdate
					AND DestinationTableCatalog = @FromDatabase
				)
		DECLARE @CurrentSSISPackageName NVARCHAR(128) = (
				SELECT SSISPackageName
				FROM [Metadata].[DestinationTable]
				WHERE DestinationTableName = @CurrentDestinationTableNameToUpdate
					AND DestinationTableCatalog = @FromDatabase
				)

		-- Update meta data table "DestinationFieldExtended" -> Target/Source attributes
		--/*
		UPDATE [Metadata].[DestinationFieldExtended]
		SET DestinationTableCatalog = @ToDatabase
			,SourceTableCatalog = @ToDatabaseSource
		--*/
		--Select * from [Metadata].[DestinationTable]
		WHERE DestinationTableCatalog = @FromDatabase
			AND ApplicableTable = @CurrentDestinationTableNameToUpdate

		-- Update meta data table "DestinationTable" -> Target attributes
		--/*
		UPDATE [Metadata].[DestinationTable]
		SET DestinationTableCatalog = @ToDatabase
			,SourceTableCatalog = @ToDatabaseSource
		--*/
		--Select * from [Metadata].[DestinationTable]
		WHERE DestinationTableCatalog = @FromDatabase
			AND DestinationTableName = @CurrentDestinationTableNameToUpdate

		-- Update meta data table "SourceField" -> Target attributes
		--/*
		UPDATE [Metadata].[SourceField]
		SET DestinationTableCatalog = @ToDatabase
		--*/
		--Select * from [Metadata].[InferredMemberExceptionDefinition]
		WHERE DestinationTableCatalog = @FromDatabase
			AND Table_Name = @CurrentSourceTableNameToUpdate

		-- Update meta data table "TableKeyDefinition" -> Target attributes
		--/*
		UPDATE [Metadata].[TableKeyDefinition]
		SET TableCatalog = @ToDatabase
		--*/
		--Select * from [Metadata].[InferredMemberExceptionDefinition]
		WHERE TableCatalog = @FromDatabase
			AND TableName = @CurrentDestinationTableNameToUpdate

		PRINT 'CurrentSSISPackageName = ' + @CurrentSSISPackageName

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		PRINT 'Failure'

		ROLLBACK TRANSACTION
	END CATCH
END