-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Re-creates database table from metadata
-- Example:	
/*	
	EXECUTE [DevelopmentFrameworkConfig].[Metadata].[ReGenerateTable]
				@_DestinationTableCatalog = 'DataWarehouse'
				, @_DestinationTableName = 'dPersonTradedoublerTeam'
*/
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[ReGenerateTable] @_DestinationTableCatalog NVARCHAR(128)
	,@_LinkedServerName NVARCHAR(128) = '[LOCALHOST]'
	,@_DestinationTableName NVARCHAR(128)
	,@_DestinationSchemaName NVARCHAR(128)
	,@UpdateSourceFields BIT = 1
	,@VersionComment VARCHAR(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION ReGenerateTable

	BEGIN TRY
		-- Generering av tabeller och metadata för EDWRaw_BIML
		DECLARE @TABLE_CATALOG NVARCHAR(128)
			,@TABLE_SCHEMA NVARCHAR(128)
			,@TABLE_NAME NVARCHAR(128)
			,@_SSISPackageName NVARCHAR(128)

		DECLARE cTemp CURSOR
		FOR
		SELECT SourceTableCatalog AS TABLE_CATALOG
			,SourceSchemaName AS TABLE_SCHEMA
			,SourceTableName AS TABLE_NAME
			,DestinationTableName
			,SSISPackageName
		FROM [Metadata].[DestinationTable] WITH (NOLOCK)
		WHERE DestinationTableCatalog = @_DestinationTableCatalog
			AND CreateTable = 1
			AND DestinationTableName LIKE @_DestinationTableName
			AND DestinationSchemaName LIKE @_DestinationSchemaName
		ORDER BY 4

		OPEN cTemp

		FETCH NEXT
		FROM cTemp
		INTO @TABLE_CATALOG
			,@TABLE_SCHEMA
			,@TABLE_NAME
			,@_DestinationTableName
			,@_SSISPackageName

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE [Metadata].[UpdateDestinationTableTable] @LinkedServerName = @_LinkedServerName
				,@SourceDatabaseName = @TABLE_CATALOG
				,@SourceTableName = @TABLE_NAME
				,@SourceSchemaName = @TABLE_SCHEMA
				,@DestinationTableCatalog = @_DestinationTableCatalog
				,@DestinationSchemaName = @_DestinationSchemaName
				,@DestinationTableName = @_DestinationTableName
				,@CreateSSISPackage = 1
				-- do not change parameters below
				,@CorrespondingSSISPackageName = @_SSISPackageName
				,@CreateTableInDatabase = 0
				,@CreateChecksumColumns = 0
				,@CDCInstanceName = NULL
				,@CreateIndexesForChecksumColumns = 0
				,@UpdateTableKeyDefinitions = 0
				,@UpdateDestinationTable = 0
				,@UpdateSourceFieldTable = @UpdateSourceFields

			RAISERROR (
					'[Metadata].[UpdateDestinationTableTable] finished successfully'
					,10
					,1
					)
			WITH NOWAIT

			EXECUTE [Metadata].[CreateTable] @DestinationTableName = @_DestinationTableName
				,@DestinationTableCatalog = @_DestinationTableCatalog
				,@DestinationSchemaName = @_DestinationSchemaName

			DECLARE @Msg NVARCHAR(200) = @_DestinationTableName + ' tabell skapad'

			RAISERROR (
					@Msg
					,10
					,1
					)
			WITH NOWAIT

			INSERT INTO [Metadata].DestinationTableLog (
				SourceTableCatalog
				,SourceSchemaName
				,SourceTableName
				,DestinationTableCatalog
				,DestinationSchemaName
				,DestinationTableName
				,VersionComment
				,UserNameInserted
				,DateTimeInsertedUTC
				)
			VALUES (
				@TABLE_CATALOG
				,@TABLE_SCHEMA
				,@TABLE_NAME
				,@_DestinationTableCatalog
				,@_DestinationSchemaName
				,@_DestinationTableName
				,@VersionComment
				,SYSTEM_USER
				,GetUTCDate()
				)

			FETCH NEXT
			FROM cTemp
			INTO @TABLE_CATALOG
				,@TABLE_SCHEMA
				,@TABLE_NAME
				,@_DestinationTableName
				,@_SSISPackageName
		END

		CLOSE cTemp

		DEALLOCATE cTemp

		COMMIT TRANSACTION ReGenerateTable
	END TRY

	BEGIN CATCH
		CLOSE cTemp

		DEALLOCATE cTemp

		ROLLBACK TRANSACTION ReGenerateTable;
		THROW ;
	END CATCH
END