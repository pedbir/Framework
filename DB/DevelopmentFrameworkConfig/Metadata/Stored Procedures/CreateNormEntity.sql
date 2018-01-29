
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--	Creates  meta data and tables for dimension in the Norm layer.
--	Before you execute this procedure you must create the view in the "Staging" layer.
--	After the meta data and table are created you need to create the SSIS packet in Visual Studio (using BIML scripts)
-- Example:	
--
--
-- =============================================
CREATE PROC Metadata.CreateNormEntity
    (
      @source_DB NVARCHAR(50)
    , @dest_db NVARCHAR(50)
    , @source_schema NVARCHAR(50)
    , @dest_schema NVARCHAR(50)
    , @source_table NVARCHAR(50) = NULL
    , @BIP NVARCHAR(50)
    , @GroupName NVARCHAR(50)
    , @FactScdType TINYINT = 1
    , @CreateStageTable BIT = 0
    )
AS

SET XACT_ABORT ON	
SET NOCOUNT ON

    DECLARE @dest_table NVARCHAR(50);
    DECLARE @_GroupName NVARCHAR(25);
    DECLARE @StageTableName NVARCHAR(50);
    DECLARE @StageSchemaName NVARCHAR(50);
    DECLARE @StageTableCatalog NVARCHAR(50);
    DECLARE @DestinationTableName NVARCHAR(50) = '#N/A';
    

    DECLARE @SQL_GetSourceTable NVARCHAR(MAX) = '
			SELECT TABLE_NAME
			FROM '+@source_DB+'.INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = ''VIEW'' AND TABLE_SCHEMA = '''+@source_schema+'''' + IIF(@source_table IS NOT NULL, ' AND TABLE_NAME LIKE ''' + @source_table + '%''', '')



	CREATE TABLE #Source_tables(SourceTable NVARCHAR(500)) 
	INSERT into #Source_tables execute (@SQL_GetSourceTable)

	DECLARE @source_table_curr NVARCHAR(255)
	DECLARE SourceTableCursor CURSOR FAST_FORWARD READ_ONLY FOR SELECT DISTINCT SourceTable FROM #Source_tables
	OPEN SourceTableCursor
	FETCH NEXT FROM SourceTableCursor INTO @source_table_curr

	WHILE @@FETCH_STATUS = 0
	BEGIN
    

	SELECT TOP 1
            @DestinationTableName = dt.DestinationTableName
    FROM    Metadata.DestinationTable AS dt
    WHERE   dt.SourceTableCatalog = @source_DB AND dt.DestinationTableCatalog = @dest_db AND dt.SourceSchemaName = @source_schema AND dt.DestinationSchemaName = @dest_schema AND dt.SourceTableName = @source_table_curr

	PRINT CHAR(10) + '------------------------------------------------------------------------------------------------------------------------------'
	PRINT 'Creating Table and Metadata for Source: [' + @source_schema + '].[' + @source_table_curr  + ']'
	PRINT '------------------------------------------------------------------------------------------------------------------------------'+ CHAR(10) 

    EXEC Metadata.RemoveMetaData @DestinationTableDataBase = @dest_db -- nvarchar(128)
        , @SourceTableDataBase = @source_DB -- nvarchar(128)
        , @DestinationTableName = @DestinationTableName -- nvarchar(128)
        , @DestinationSchemaName = @dest_schema -- nvarchar(128)


    IF ( @GroupName NOT IN ( 'Fact', 'Dimension', 'Datamart objects' ) )
        BEGIN
            RAISERROR (
			'Error in the provided @GroupName parameter -> must be ''Fact'', ''Dimension'' or ''Data Mart objects'''
			,10
			,1
			);
            RETURN;
        END;

    SET @_GroupName = @GroupName;

    IF UPPER(@dest_db) = 'DWH_2_Norm'
        BEGIN
            SET @dest_table = CONCAT('n_', @source_table_curr);
        END;
    ELSE
        IF UPPER(@dest_db) LIKE '%DWH_3_Fact%'
            BEGIN
                SET @dest_table = @source_table_curr;
            END;
        ELSE
            IF UPPER(@dest_db) = 'DWH_1_Raw'
                BEGIN
                    SET @dest_table = CONCAT('r_', @source_table_curr);
                END;


    DECLARE @_SSISPackageName NVARCHAR(101) = @dest_db + '_' + @dest_schema + '_' + @dest_table
      , @_CompressionType NVARCHAR(50) = ( SELECT TOP 1
                                                    DefaultTableCompressionType
                                           FROM     Metadata.EnvironmentVariables
                                         )
      , @_SSISIncrementalLoad BIT = ( SELECT TOP 1
                                                DefaultSSISIncrementalLoad
                                      FROM      Metadata.EnvironmentVariables
                                    );
    IF @CreateStageTable = 1
        BEGIN
            SET @StageSchemaName = 'Stage';
            SET @StageTableCatalog = 'DWH_2_Norm';
            SET @StageTableName = CONCAT('n_', @source_table_curr);	 
        END 
    BEGIN TRY
        EXECUTE Metadata.UpdateDestinationTableTable @LinkedServerName = '[LOCALHOST]', @SourceDatabaseName = @source_DB, @SourceTableName = @source_table_curr, @SourceSchemaName = @source_schema, @DestinationTableCatalog = @dest_db, @DestinationSchemaName = @dest_schema, @DestinationTableName = @dest_table, @CorrespondingSSISPackageName = @_SSISPackageName, @CreateTableInDatabase = 1, @CreateChecksumColumns = 0, @CreateIndexesForChecksumColumns = 0, @CreateSSISPackage = 1, @CDCInstanceName = NULL, @CompressionType = @_CompressionType, @UpdateTableKeyDefinitions = 1, @UpdateDestinationTable = 1, @UpdateSourceFieldTable = 1, @GroupName = @_GroupName, @SSISIncrementalLoad = @_SSISIncrementalLoad, @CreateStageTable = @CreateStageTable, @StageTableCatalog = @StageTableCatalog, @StageSchemaName = @StageSchemaName, @StageTableName = @StageTableName, @SourceServer = NULL, @FactScdType = @FactScdType;


        IF UPPER(@dest_db) IN ( 'DWH_2_Norm', 'DWH_1_Raw' )
            BEGIN
		-- Create meta data, for the Norm layer, for the Primary Key (whick also will be the clustered index)
                INSERT  INTO Metadata.TableKeyDefinition
                        ( TableCatalog
                        , SchemaName
                        , TableName
                        , TableKeyName
                        , COLUMN_NAME
                        , DATA_TYPE
                        , KeyType
                        , KeyColumnOrder
                        , IncludedColumn
                        , IndexStorageLocation )
                SELECT  @dest_db
                      , @dest_schema
                      , @dest_table
                      , ''
                      , 'SysValidFromDateTime'
                      , 'Date'
                      , 'PK'
                      , 2
                      , 0
                      , ( SELECT TOP 1
                                    CASE WHEN @dest_db = 'DWH_1_Raw' THEN DefaultRawLayerDataStorageLocation
                                         ELSE DefaultNormLayerDataStorageLocation
                                    END
                          FROM      Metadata.EnvironmentVariables
                        )
                UNION ALL
                SELECT  @dest_db
                      , @dest_schema
                      , @dest_table
                      , ''
                      , @source_table_curr + '_bkey'
                      , 'nvarchar'
                      , 'PK'
                      , 1
                      , 0
                      , ( SELECT TOP 1
                                    CASE WHEN @dest_db = 'DWH_1_Raw' THEN DefaultRawLayerDataStorageLocation
                                         ELSE DefaultNormLayerDataStorageLocation
                                    END
                          FROM      Metadata.EnvironmentVariables
                        );

                IF ( @_GroupName = 'Dimension' )
                    BEGIN
                        INSERT  INTO Metadata.DestinationFieldExtended
                                ( COLUMN_NAME
                                , DATA_TYPE
                                , ORDINAL_POSITION
                                , IS_NULLABLE
                                , IncludeInChecksum_src
                                , IsIdentity
                                , CreateColumnIndex
                                , SourceTableCatalog
                                , DestinationTableCatalog
                                , DestinationSchemaName
                                , ApplicableTable
                                , SSISDataType
                                , SetFieldOnInsert
                                , SetFieldOnUpdate
                                , SetFieldOnDelete
                                , GroupName )
                        SELECT  COLUMN_NAME = SUBSTRING(@dest_table, 3, 200) + '_key'
                              , DATA_TYPE = 'int'
                              , ORDINAL_POSITION = 1001
                              , IS_NULLABLE = 'NO'
                              , IncludeInChecksum_src = 0
                              , IsIdentity = 1
                              , CreateColumnIndex = 1
                              , SourceTableCatalog = @source_DB
                              , DestinationTableCatalog = @dest_db
                              , DestinationSchemaName = @dest_schema
                              , ApplicableTable = @dest_table
                              , SSISDataType = 'Int32'
                              , SetFieldOnInsert = 0
                              , SetFieldOnUpdate = 0
                              , SetFieldOnDelete = 0
                              , GroupName = 'All';
                    END;
            END;
        ELSE
            BEGIN
                DECLARE @PKColumnName NVARCHAR(100);

                IF ( RIGHT(@dest_table, 2) = '_h' )
                    SET @PKColumnName = SUBSTRING(LEFT(@dest_table, LEN(@dest_table) - 2), 3, 200) + '_key';
                ELSE
                    SET @PKColumnName = SUBSTRING(@dest_table, 3, 200) + '_key';

		-- Create meta data for the "data mart" layer -> "surrogate key" will be the 
                INSERT  INTO Metadata.TableKeyDefinition
                        ( TableCatalog
                        , SchemaName
                        , TableName
                        , TableKeyName
                        , COLUMN_NAME
                        , DATA_TYPE
                        , KeyType
                        , KeyColumnOrder
                        , IncludedColumn
                        , IndexStorageLocation )
                SELECT  @dest_db
                      , @dest_schema
                      , @dest_table
                      , ''
                      , @PKColumnName
                      , 'int'
                      , 'PK'
                      , 1
                      , 0
                      , ( SELECT TOP 1
                                    DefaultMartLayerDataStorageLocation
                          FROM      Metadata.EnvironmentVariables
                        );
                IF ( @FactScdType = 2 AND @_GroupName = 'Fact' )
                    BEGIN
                        INSERT  INTO Metadata.TableKeyDefinition
                                ( TableCatalog
                                , SchemaName
                                , TableName
                                , TableKeyName
                                , COLUMN_NAME
                                , DATA_TYPE
                                , KeyType
                                , KeyColumnOrder
                                , IncludedColumn
                                , IndexStorageLocation )
                        SELECT  @dest_db
                              , @dest_schema
                              , @dest_table
                              , ''
                              , 'SysValidFromDateTime'
                              , 'Date'
                              , 'PK'
                              , 2
                              , 0
                              , ( SELECT TOP 1
                                            DefaultMartLayerDataStorageLocation
                                  FROM      Metadata.EnvironmentVariables
                                )
                    END 
            END;

	-- Re-generates the table in the Norm database
        EXECUTE Metadata.ReGenerateTable @_DestinationTableCatalog = @dest_db, @_DestinationTableName = @dest_table, @_DestinationSchemaName = @dest_schema, @UpdateSourceFields = 1, @VersionComment = @BIP; -- Jira No (for deployment purposes)
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;
        EXECUTE Metadata.RemoveMetaData @DestinationTableDataBase = @dest_db, @SourceTableDataBase = @source_DB, @DestinationTableName = @dest_table, @DestinationSchemaName = @dest_schema;

        DECLARE @ErrorMessage NVARCHAR(2048) = 'Error creating object Check your view for errors -> All metadata updates rollbacked' + CHAR(10) + ERROR_MESSAGE();
        THROW 50000, @ErrorMessage, 1;
    END CATCH;


		FETCH NEXT FROM SourceTableCursor INTO @source_table_curr
	END

	CLOSE SourceTableCursor
	DEALLOCATE SourceTableCursor