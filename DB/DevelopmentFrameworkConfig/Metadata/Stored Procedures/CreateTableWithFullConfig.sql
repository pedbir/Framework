-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[CreateTableWithFullConfig] @pSourceDatabaseName VARCHAR(50)
	,@pSourceTableName VARCHAR(50)
	,@pSourceSchemaName VARCHAR(50)
	,@pDestinationTableCatalog VARCHAR(50)
	,@pDestinationSchemaName VARCHAR(50)
	,@pDestinationTableName VARCHAR(50)
	,@pSourceFilterCondition VARCHAR(50)
	,@pSSISPackageName VARCHAR(50)
	,@pSSISGroupName VARCHAR(50) = 'All'
	,@pCreateStage BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/* 1. Create table in metadata.DestinationTable. source and destination info ssis info */
	EXECUTE [Metadata].[UpdateDestinationTableTable] @LinkedServerName = NULL
		,@SourceDatabaseName = @pSourceDatabaseName
		,@SourceTableName = @pSourceTableName
		,@SourceSchemaName = @pSourceSchemaName
		,@DestinationTableCatalog = @pDestinationTableCatalog
		,@DestinationSchemaName = @pDestinationSchemaName
		,@DestinationTableName = @pDestinationTableName
		,@CorrespondingSSISPackageName = @pSSISPackageName
		,@GroupName = @pSSISGroupName
		,@CreateTableInDatabase = 1 -- IF TABLE EXISTS, IT WILL BE DROPPED AND RECREATEAD
		,@CreateChecksumColumns = 0
		,@CreateIndexesForChecksumColumns = 0
		,@CreateSSISPackage = 1
		,@CDCInstanceName = NULL
		,@CompressionType = 'PAGE'
		,@UpdateTableKeyDefinitions = 1
		,@UpdateDestinationTable = 1

	/* 2. Update landing area (Raw) information. if set raw table will be created.
		Apply source filter condition		  
		*/
	IF @pCreateStage = 1
	BEGIN
		UPDATE Metadata.DestinationTable
		SET StageTableCatalog = 'Raw'
			,SourceFilterCondition = @pSourceFilterCondition
			,StageSchemaName = @pDestinationSchemaName
			,StageTableName = @pDestinationTableName
			,CreateStageTable = 1
		WHERE SourceTableName = @pSourceTableName
	END

	/* 3. Insert data field information original proc was updated due to no linked server*/
	EXEC [Metadata].[UpdateSourceFieldTable] @LinkedServerName = NULL
		,@SourceDatabaseName = @pSourceDatabaseName
		,@SourceSchemaName = @pSourceSchemaName
		,@SourceTableName = @pSourceTableName
		,@DestinationTableCatalog = @pDestinationTableCatalog
		,@SourceServer = NULL

	/* 4. Insert primary key information.*/
	EXEC [Metadata].[UpdateTableKeyDefinitionTable] @LinkedServerName = NULL
		,@SourceDatabaseName = @pSourceDatabaseName
		,@SourceSchemaName = @pSourceSchemaName
		,@SourceTableName = @pSourceTableName
		,@DestinationTableCatalog = @pDestinationTableCatalog
		,@DestinationTableName = @pDestinationTableName
		,@DestinationSchemaName = @pDestinationSchemaName

	/* 5. Create table(s)*/
	EXEC [Metadata].[CreateTable] @pDestinationTableName
		,@pDestinationTableCatalog
		,@pDestinationSchemaName
END