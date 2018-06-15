
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Refreshes meta data for the current table, from given source
-- Example:	
--
--
-- =============================================
CREATE procedure [Metadata].[UpdateDestinationTableTable] @LinkedServerName varchar(50)
	,@SourceDatabaseName nvarchar(128)
	,@SourceTableName nvarchar(128)
	,@SourceSchemaName nvarchar(128)
	,@DestinationTableCatalog nvarchar(128)
	,@DestinationSchemaName nvarchar(128)
	,@DestinationTableName nvarchar(128)
	,@CorrespondingSSISPackageName nvarchar(128)
	,@CreateTableInDatabase tinyint
	,@CreateChecksumColumns bit
	,@CreateIndexesForChecksumColumns bit
	,@CreateSSISPackage tinyint
	,@CDCInstanceName nvarchar(128)
	,@CompressionType nvarchar(50) = 'PAGE'
	,@UpdateTableKeyDefinitions bit = 0
	,@UpdateDestinationTable bit = 0
	,@UpdateSourceFieldTable bit = 1
	,@GroupName nvarchar(128) = null
	,@SSISIncrementalLoad bit = 0
	,@SourceServer nvarchar(128) = null
	,@CreateStageTable bit = 0
	,@StageTableCatalog varchar(128) = null
	,@StageSchemaName varchar(128) = null
	,@StageTableName varchar(128) = null
	,@ColumnNamesInFirstDataRow bit = null
	,@HeaderRowsToSkip smallint = null
	,@DataRowsToSkip smallint = null
	,@FlatFileType varchar(20) = null
	,@HeaderRowDelimiter varchar(5) = null
	,@RowDelimiter varchar(5) = null
	,@ColumnDelimiter varchar(10) = null
	,@TextQualifier varchar(10) = null
	,@IsUnicode bit = null
	,@DestinationDeleteCondition varchar(128) = null
	,@IsPartitioned bit = 0
	,@PartitionFunctionName nvarchar(128) = null
	,@PartitionSchemeName nvarchar(128) = null
	,@PartitionKeyColumnName nvarchar(128) = null
	,@PartitionETLStrategy nvarchar(128) = 'INSERT'
	,@FactScdType tinyint = null
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRANSACTION ActivateTablesForDestinations

	begin try
		IF (@UpdateSourceFieldTable = 1)
		BEGIN
			DECLARE @ExecString VARCHAR(1000) = 'EXECUTE [Metadata].[UpdateSourceFieldTable] @LinkedServerName = ' + @LinkedServerName + '
									, @SourceDatabaseName = ' + @SourceDatabaseName + '
									, @SourceSchemaName = ' + @SourceSchemaName + '
									, @SourceTableName=' + @SourceTableName + '
									, @DestinationTableCatalog = ' + @DestinationTableCatalog + '
									, @SourceServer = ' + @SourceServer

			RAISERROR (
					@ExecString
					,10
					,1
					)
			WITH NOWAIT

			EXECUTE [Metadata].[UpdateSourceFieldTable] @LinkedServerName = @LinkedServerName
				,@SourceDatabaseName = @SourceDatabaseName
				,@SourceSchemaName = @SourceSchemaName
				,@SourceTableName = @SourceTableName
				,@DestinationTableCatalog = @DestinationTableCatalog
				,@SourceServer = @SourceServer

			print 'Table [Metadata].[RefreshMetadataFieldsFromSource] handled.' + CHAR(10) + '--- No more actions required ---' + CHAR(10)
		end

		IF (@UpdateDestinationTable = 1)
		BEGIN
			-- Change 2013-05-30 
			IF EXISTS (
					SELECT 1
					FROM Metadata.DestinationTable
					WHERE SourceTableCatalog = @SourceDatabaseName
						AND SourceTableName = @SourceTableName
						AND SourceSchemaName = @SourceSchemaName
						AND DestinationTableCatalog = @DestinationTableCatalog
						AND DestinationTableName = @DestinationTableName
						AND DestinationSchemaName = @DestinationSchemaName
						AND (
							@SourceServer IS NULL
							OR SourceServer = @SourceServer
							)
					)
			BEGIN
				UPDATE Metadata.DestinationTable
				SET [SSISPackageName] = @CorrespondingSSISPackageName
					,[CreateTable] = @CreateTableInDatabase
					,[CreateChecksumColumns] = @CreateChecksumColumns
					,[CreateChecksumIndexes] = @CreateIndexesForChecksumColumns
					,[CreateSSISPackage] = @CreateSSISPackage
					,[CDCInstanceName] = @CDCInstanceName
					,[CompressionType] = @CompressionType
					,[GroupName] = isnull(@GroupName, [GroupName])
					,[SSISIncrementalLoad] = isnull(@SSISIncrementalLoad, [SSISIncrementalLoad])
					,[SourceServer] = isnull(@SourceServer, [SourceServer])
					,UserNameUpdated = SYSTEM_USER
					,DateTimeUpdatedUTC = GETUTCDATE()
					,[StageTableCatalog] = @StageTableCatalog
					,[StageSchemaName] = @StageSchemaName
					,[StageTableName] = @StageTableName
					,CreateStageTable = @CreateStageTable
					,DestinationDeleteCondition = isnull(@DestinationDeleteCondition, DestinationDeleteCondition)
					,IsPartitioned = @IsPartitioned
					,PartitionFunctionName = @PartitionFunctionName
					,PartitionSchemeName = @PartitionSchemeName
					,PartitionKeyColumnName = @PartitionKeyColumnName
					,PartitionETLStrategy = @PartitionETLStrategy
					,FactScdType = @FactScdType
				WHERE SourceTableCatalog = @SourceDatabaseName
					AND SourceTableName = @SourceTableName
					AND SourceSchemaName = @SourceSchemaName
					AND DestinationTableCatalog = @DestinationTableCatalog
					AND DestinationTableName = @DestinationTableName
					AND DestinationSchemaName = @DestinationSchemaName
					AND (
						@SourceServer IS NULL
						OR SourceServer = @SourceServer
						)

				--and SourceServer = isnull(@SourceServer, SourceServer)
				print 'Update of Metadata.DestinationTable made (' + CAST(@@ROWCOUNT as nvarchar(10)) + ' rows)'
			end
			else
			begin
				insert into Metadata.DestinationTable (
					[SourceTableCatalog]
					,[SourceSchemaName]
					,[SourceTableName]
					,[DestinationTableCatalog]
					,[DestinationSchemaName]
					,[DestinationTableName]
					,[SSISPackageName]
					,[CreateTable]
					,[CreateChecksumColumns]
					,[CreateChecksumIndexes]
					,[CreateSSISPackage]
					,[CDCInstanceName]
					,[CompressionType]
					,[GroupName]
					,[SSISIncrementalLoad]
					,SourceServer
					,[StageTableCatalog]
					,[StageSchemaName]
					,[StageTableName]
					,CreateStageTable
					,DestinationDeleteCondition
					,IsPartitioned
					,PartitionFunctionName
					,PartitionSchemeName
					,PartitionKeyColumnName
					,PartitionETLStrategy
					,FactScdType
					)
				values (
					@SourceDatabaseName
					,@SourceSchemaName
					,@SourceTableName
					,@DestinationTableCatalog
					,@DestinationSchemaName
					,@DestinationTableName
					,@CorrespondingSSISPackageName
					,@CreateTableInDatabase
					,@CreateChecksumColumns
					,@CreateIndexesForChecksumColumns
					,@CreateSSISPackage
					,@CDCInstanceName
					,@CompressionType
					,ISNULL(@GroupName, 'All')
					,@SSISIncrementalLoad
					,@SourceServer
					,@StageTableCatalog
					,@StageSchemaName
					,@StageTableName
					,@CreateStageTable
					,@DestinationDeleteCondition
					,@IsPartitioned
					,@PartitionFunctionName
					,@PartitionSchemeName
					,@PartitionKeyColumnName
					,@PartitionETLStrategy
					,@FactScdType
					)
			end

			print 'Table [Metadata].[DestinationTable] handled.' + CHAR(10) + '--- No more actions required ---' + CHAR(10)
		end

		IF (@UpdateTableKeyDefinitions = 1)
		BEGIN
			EXECUTE [Metadata].[UpdateTableKeyDefinitionTable] @LinkedServerName = @LinkedServerName
				,@SourceDatabaseName = @SourceDatabaseName
				,@SourceSchemaName = @SourceSchemaName
				,@SourceTableName = @SourceTableName
				,@DestinationTableCatalog = @DestinationTableCatalog
				,@DestinationTableName = @DestinationTableName
				,@DestinationSchemaName = @DestinationSchemaName

			PRINT 'Table [Metadata].[TableKeyDefinition] handled.'
			PRINT '--- Actions required ---'
			PRINT '-- 1. Append extra column definitions for the primary key (to [Metadata].[TableKeyDefinition]). For example "InventoryDate" for "rInventSum"'
			print '-- 2. Set sort order for the definition of the Primary key -> "KeyColumnOrder" (in table [Metadata].[TableKeyDefinition])' + CHAR(10)
		end

		DECLARE @ExecuteString VARCHAR(max)

		SET @ExecuteString = 'EXECUTE [Metadata].[CreateTable] @DestinationTableName = ''' + @DestinationTableName + '''' + ', @DestinationTableCatalog = ''' + @DestinationTableCatalog + '''' + ', @DestinationSchemaName = ''' + @DestinationSchemaName + ''''

		PRINT '--- Actions required ---'
		PRINT 'Creation of table ' + @DestinationTableName + ' needs to be handled' + CHAR(10) + 'Execute following script after actions needed above:'
		PRINT (@ExecuteString)

		commit transaction ActivateTablesForDestinations
	end try

	begin catch
		declare @ErrorMessage varchar(max) = 'No Activation of table ' + @DestinationTableName + ' was made. Error message:' + CHAR(10) + ERROR_MESSAGE()

		raiserror (
				@ErrorMessage
				,16
				,1
				)

		rollback transaction ActivateTablesForDestinations
	end catch
end