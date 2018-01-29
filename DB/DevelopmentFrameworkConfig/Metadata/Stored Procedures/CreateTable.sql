-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE procedure [Metadata].[CreateTable]
    @DestinationTableName nvarchar(128) = null ,
    @DestinationTableCatalog nvarchar(128) ,
    @DestinationSchemaName nvarchar(128)
as
    begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        set nocount on;

	-- Insert statements for procedure here
        declare
            @TABLE_CATALOG nvarchar(128) ,
            @TABLE_SCHEMA nvarchar(128) ,
            @TABLE_NAME nvarchar(128) ,
            @DestinationTableName2 nvarchar(128)
		--, @DestinationSchemaName nvarchar(128)
            ,
            @CreateTableString varchar(max) ,
			@DropString varchar(max),
            @CreatePKString varchar(max) ,
            @PrimaryKeyString varchar(max) ,
            @IndexChecksumPrimaryKeyString varchar(max) ,
            @IndexChecksumAllNettoColumnsString varchar(max) ,
            @CreateIndexesForChecksumColumns bit ,
            @CreateTableInDatabase tinyint ,
            @CompressionType nvarchar(50) ,
            @CreateCheckSumColumns bit ,
            @StageSchemaName varchar(128) ,
            @StageTableName varchar(128) ,
            @StageTableCatalog varchar(128) ,
            @CreateStageTable bit ,
            @TABLE_SERVER nvarchar(128) ,
            @IsPartitioned bit ,
            @PartitionSchemeName nvarchar(128) ,
            @PartitionKeyColumnName nvarchar(128);


        begin transaction CreateTables;
        begin try
            declare cTables cursor
            for
                select
                    SourceTableCatalog as TABLE_CATALOG ,
                    SourceSchemaName as TABLE_SCHEMA ,
                    SourceTableName as TABLE_NAME ,
                    DestinationTableName as RawTableName ,
                    DestinationSchemaName as RawSchemaName ,
                    CreateChecksumIndexes ,
                    CreateTable ,
                    CreateChecksumColumns ,
                    CompressionType ,
                    StageSchemaName ,
                    StageTableName ,
                    StageTableCatalog ,
                    CreateStageTable ,
                    SourceServer as TABLE_SERVER ,
                    IsPartitioned ,
                    PartitionSchemeName ,
                    PartitionKeyColumnName
                from
                    [Metadata].[DestinationTable] with ( nolock )
                where
                    DestinationTableCatalog = @DestinationTableCatalog
                    and DestinationTableName = ISNULL(@DestinationTableName,
                                                      DestinationTableName)
                    and DestinationSchemaName = @DestinationSchemaName;

            open cTables;

            fetch next
		from cTables
		into @TABLE_CATALOG, @TABLE_SCHEMA, @TABLE_NAME,
                @DestinationTableName2, @DestinationSchemaName,
                @CreateIndexesForChecksumColumns, @CreateTableInDatabase,
                @CreateCheckSumColumns, @CompressionType, @StageSchemaName,
                @StageTableName, @StageTableCatalog, @CreateStageTable,
                @TABLE_SERVER, @IsPartitioned, @PartitionSchemeName,
                @PartitionKeyColumnName;

            while @@Fetch_Status = 0
                begin
			-- set PK columns to NON nullable if they are nullable
			-- before create BasteTableString
                    update
                        f
                    set
                        IS_NULLABLE = 'NO'
                    from
                        Metadata.DestinationTable d with ( nolock )
                        inner join Metadata.SourceField f with ( nolock )
                        on d.DestinationTableCatalog = f.DestinationTableCatalog
                           and d.SourceSchemaName = f.TABLE_SCHEMA
                           and d.SourceTableName = f.TABLE_NAME
                        inner join Metadata.TableKeyDefinition k with ( nolock )
                        on k.TableCatalog = d.DestinationTableCatalog
                           and k.SchemaName = d.DestinationSchemaName
                           and k.TableName = d.DestinationTableName
                           and k.COLUMN_NAME = f.COLUMN_NAME
                    where
                        d.SourceTableCatalog = @TABLE_CATALOG
                        and d.SourceSchemaName = @TABLE_SCHEMA
                        and d.SourceTableName = @TABLE_NAME
                        and k.KeyType = 'PK'
                        and f.IS_NULLABLE = 'YES';

                    set @CreateTableString = Metadata.GetCreateBaseTableString(@TABLE_CATALOG,
                                                              @TABLE_SCHEMA,
                                                              @TABLE_NAME,
                                                              @TABLE_SERVER,
                                                              @DestinationTableCatalog,
                                                              @DestinationSchemaName,
                                                              @DestinationTableName2,
                                                              @CompressionType,
                                                              default, default,
                                                              default,
                                                              @IsPartitioned,
                                                              @PartitionSchemeName,
                                                              @PartitionKeyColumnName);
                    set @CreatePKString = Metadata.GetCreatePKChecksumString(@TABLE_CATALOG,
                                                              @TABLE_SCHEMA,
                                                              @TABLE_NAME,
                                                              @DestinationTableCatalog,
                                                              @DestinationSchemaName,
                                                              @DestinationTableName2,
                                                              @CreateCheckSumColumns,
                                                              default, default,
                                                              default,
                                                              @IsPartitioned,
                                                              @PartitionSchemeName,
                                                              @PartitionKeyColumnName,
                                                              @CompressionType);

                    if @CreateTableString is not null
                        and @CreateTableInDatabase = 1
                        begin
                            exec (@CreateTableString);

                            if @CreatePKString is not null
                                exec (@CreatePKString);
                            else
                                print 'No Primary Key was created!';

                            if @CreateStageTable = 1
                                begin
                                    set @CreateTableString = Metadata.GetCreateBaseTableString(@TABLE_CATALOG,
                                                              @TABLE_SCHEMA,
                                                              @TABLE_NAME,
                                                              @TABLE_SERVER,
                                                              @DestinationTableCatalog,
                                                              @DestinationSchemaName,
                                                              @DestinationTableName,
                                                              @CompressionType,
                                                              ISNULL(@StageTableCatalog,
                                                              @DestinationTableCatalog),
                                                              @StageSchemaName,
                                                              @StageTableName,
                                                              @IsPartitioned,
                                                              @PartitionSchemeName,
                                                              @PartitionKeyColumnName);
                                    set @CreatePKString = Metadata.GetCreatePKChecksumString(@TABLE_CATALOG,
                                                              @TABLE_SCHEMA,
                                                              @TABLE_NAME,
                                                              @DestinationTableCatalog,
                                                              @DestinationSchemaName,
                                                              @DestinationTableName2,
                                                              @CreateCheckSumColumns,
                                                              ISNULL(@StageTableCatalog,
                                                              @DestinationTableCatalog),
                                                              @StageSchemaName,
                                                              @StageTableName,
                                                              @IsPartitioned,
                                                              @PartitionSchemeName,
                                                              @PartitionKeyColumnName,
                                                              @CompressionType);

                                    if @CreateTableString is not null
                                        begin
                                            exec (@CreateTableString);

                                            if @CreatePKString is not null
                                                begin
                                                    exec (@CreatePKString);
                                                end;
                                            else
                                                print 'No Primary Key for Stage table was created!';

                                            select  @CreateTableString =  Metadata.GetCreateStageViewString(@TABLE_CATALOG,
                                                              @TABLE_SCHEMA,
                                                              @TABLE_NAME,
                                                              @TABLE_SERVER,
                                                              @StageTableCatalog,
                                                              @StageSchemaName,
                                                              @StageTableName,
                                                              @DestinationTableCatalog,
                                                              @DestinationSchemaName,
                                                              @DestinationTableName);
											
											if @CreateTableString is not null
                                                begin
                                                    exec (@CreateTableString);
                                                end;
                                            else
                                                begin
                                                    print 'No view for Stage table was created!';
                                                end;
					
                                        end;
                    
                                end;

				-- Create additional nonclustered indexes for table
                            declare @ncix_index_name as nvarchar(128);

                            declare cNonClusteredIndex cursor
                            for
                                select distinct
                                    TableKeyName
                                from
                                    [Metadata].[TableKeyDefinition]
                                where
                                    TableCatalog = @DestinationTableCatalog
                                    and SchemaName = @DestinationSchemaName
                                    and TableName = @DestinationTableName2
                                    and KeyType = 'NCIX';

                            open cNonClusteredIndex;

                            fetch next
				from cNonClusteredIndex
				into @ncix_index_name;

                            declare @ncix_dml as nvarchar(1000);

                            while @@Fetch_Status = 0
                                begin
                                    declare @ncix_index_columns as nvarchar(500) = '';
                                    declare @ncix_index_included_columns as nvarchar(500) = '';
                                    declare @ncix_index_filter_predicate as nvarchar(500) = '';
                                    declare @ncix_index_storage_location as nvarchar(500) = '';
                                    declare @ncix_unique_definition nvarchar(20) = '';

                                    select
                                        @ncix_index_columns = @ncix_index_columns
                                        + COLUMN_NAME
                                        + case when a.IsAscendingOrder = 0
                                               then ' DESC'
                                               else ''
                                          end + ','
                                    from
                                        [Metadata].[TableKeyDefinition] a
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableName = @DestinationTableName2
                                        and TableKeyName = @ncix_index_name
                                        and IncludedColumn = 0
                                    order by
                                        KeyColumnOrder asc;

                                    select
                                        @ncix_index_included_columns = @ncix_index_included_columns
                                        + COLUMN_NAME + ','
                                    from
                                        [Metadata].[TableKeyDefinition]
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableName = @DestinationTableName2
                                        and TableKeyName = @ncix_index_name
                                        and IncludedColumn = 1
                                    order by
                                        KeyColumnOrder asc;

					-- Get NCIX filter predicate
                                    select
                                        @ncix_index_filter_predicate = ISNULL('WHERE '
                                                              + MAX(fp.FilterPredicate),
                                                              '')
                                    from
                                        [Metadata].[TableKeyDefinition] fp
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableName = @DestinationTableName2
                                        and TableKeyName = @ncix_index_name;

					-- Get NCIX storage location
                                    select
                                        @ncix_index_storage_location = MAX(fp.IndexStorageLocation)
                                    from
                                        [Metadata].[TableKeyDefinition] fp
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableName = @DestinationTableName2
                                        and TableKeyName = @ncix_index_name
                                        and fp.IndexStorageLocation != 'DefaultLocation';

					-- Get NCIX Unique definition
                                    select
                                        @ncix_unique_definition = case
                                                              when MAX(case
                                                              when fp.IndexIsUnique = 1
                                                              then 1
                                                              else 0
                                                              end) = 1
                                                              then 'UNIQUE'
                                                              else ''
                                                              end
                                    from
                                        [Metadata].[TableKeyDefinition] fp
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableName = @DestinationTableName2
                                        and TableKeyName = @ncix_index_name
                                        and fp.IndexIsUnique = 1;

					-- Add fill factor to the non-clustered index
                                    declare @pk_index_fill_factor varchar(180);

                                    select
                                        @pk_index_fill_factor = ISNULL(',  FILLFACTOR = '
                                                              + CAST(MAX(fp.IndexFillFactor) as varchar(5)),
                                                              '')
                                    from
                                        [Metadata].[TableKeyDefinition] fp
                                    where
                                        TableCatalog = @DestinationTableCatalog
                                        and SchemaName = @DestinationSchemaName
                                        and TableKeyName = @ncix_index_name;

                                    set @ncix_index_columns = LEFT(@ncix_index_columns,
                                                              LEN(@ncix_index_columns)
                                                              - 1);
                                    set @ncix_dml = 'CREATE  '
                                        + @ncix_unique_definition
                                        + ' NONCLUSTERED INDEX '
                                        + @ncix_index_name + ' ON ' + '['
                                        + @DestinationTableCatalog + '].['
                                        + @DestinationSchemaName + '].['
                                        + @DestinationTableName2 + ']' + '('
                                        + @ncix_index_columns + ')';

					-- Add extra text for included columns in the index
                                    if ( LEN(@ncix_index_included_columns) > 0 )
                                        begin
                                            set @ncix_index_included_columns = LEFT(@ncix_index_included_columns,
                                                              LEN(@ncix_index_included_columns)
                                                              - 1);
                                            set @ncix_dml = @ncix_dml
                                                + ' INCLUDE('
                                                + @ncix_index_included_columns
                                                + ')';
                                        end;

					-- Apply filter on index
                                    set @ncix_dml = @ncix_dml
                                        + @ncix_index_filter_predicate + ' ';
					-- Apply compression and fill factor on the non-clustered index
                                    set @ncix_dml = @ncix_dml
                                        + ' WITH (DATA_COMPRESSION = '
                                        + @CompressionType
                                        + @pk_index_fill_factor + ')';
					-- Apply storage location on the non-clustered index
                                    set @ncix_dml = @ncix_dml + ISNULL(' ON ['
                                                              + @ncix_index_storage_location
                                                              + ']', '');

                                    raiserror (
							@ncix_dml
							,10
							,1
							)
					with nowait;

                                    execute (@ncix_dml);

                                    fetch next
					from cNonClusteredIndex
					into @ncix_index_name;
                                end;

                            close cNonClusteredIndex;

                            deallocate cNonClusteredIndex;
					-- Finished creating indexes
                        end;

                    fetch next
			from cTables
			into @TABLE_CATALOG, @TABLE_SCHEMA, @TABLE_NAME,
                        @DestinationTableName2, @DestinationSchemaName,
                        @CreateIndexesForChecksumColumns,
                        @CreateTableInDatabase, @CreateCheckSumColumns,
                        @CompressionType, @StageSchemaName, @StageTableName,
                        @StageTableCatalog, @CreateStageTable, @TABLE_SERVER,
                        @IsPartitioned, @PartitionSchemeName,
                        @PartitionKeyColumnName;
                end;

            close cTables;

            deallocate cTables;

            commit transaction CreateTables;
        end try

        begin catch
            close cTables;
            deallocate cTables;
			declare @errmsg varchar(max) = CONCAT('Error: ',ERROR_MESSAGE(), ' while executing ',CHAR(13),CHAR(10),@CreateTableString);
			declare @errnum int = 51001;
			declare @errstate int = ERROR_STATE();
			print @errmsg;

			rollback transaction CreateTables;
			throw;
			
            print @CreateTableString;
            print @CreatePKString;
        end catch;
    end;