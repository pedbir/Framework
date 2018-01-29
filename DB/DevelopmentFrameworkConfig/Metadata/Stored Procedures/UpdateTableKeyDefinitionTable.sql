-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Refreshes the Primary Keys (picked from the source)
-- Example:	
/* 		
	EXECUTE [Metadata].[UpdateTableKeyDefinitionTable] @LinkedServerName = '[LOCALHOST]'
		, @SourceDatabaseName = 'Stage'
		, @SourceSchemaName = 'DataWarehouse'
		, @SourceTableName = 'Person'
		, @DestinationTableCatalog = 'DataWarehouse'
		, @DestinationTableName = 'Person'
		, @DestinationSchemaName = 'DW'
*/
--
--
-- =============================================
CREATE procedure [Metadata].[UpdateTableKeyDefinitionTable]
    @LinkedServerName nvarchar(128) ,
    @SourceDatabaseName nvarchar(128) ,
    @SourceSchemaName nvarchar(128) ,
    @SourceTableName nvarchar(128) ,
    @DestinationTableCatalog nvarchar(128) ,
    @DestinationTableName nvarchar(128) ,
    @DestinationSchemaName nvarchar(128)
as
    begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        set nocount on;

        select
            *
        into
            #Metadata
        from
            [Metadata].[TableKeyDefinition]
        where
            1 = 2;

        alter table #Metadata

        drop column TableKeyDefinitionRowID;

        declare @SQLString varchar(max) = 'EXECUTE ' + @LinkedServerName + '.'
            + @SourceDatabaseName + '.dbo.sp_executesql
		N''' + 'SELECT ''''' + @DestinationTableCatalog
            + ''''' as TableCatalog, ''''' + @DestinationSchemaName
            + ''''' as SchemaName
						, ''''' + @DestinationTableName
            + ''''' as TableName, ''''' + ''
            + ''''' as TableKeyName, ccu.COLUMN_NAME
						, col.DATA_TYPE
						, ''''' + 'PK'
            + ''''' as KeyType
						, 1 as KeyColumnOrder
						, 0 as IncludedColumn
                        , ''''DefaultLocation'''' as IndexStorageLocation
                        , CAST(NULL AS nvarchar(128)) AS FilterPredicate
                        , 1 As IsAscendingOrder
						, 0 as IndexIsUnique
						, null as IndexFillFactor
				FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc         
					inner join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON tc.CONSTRAINT_NAME = ccu.Constraint_name
					inner join INFORMATION_SCHEMA.COLUMNS col on  ccu.TABLE_CATALOG = col.TABLE_CATALOG
																and ccu.TABLE_SCHEMA = col.TABLE_SCHEMA
																and ccu.TABLE_NAME = col.TABLE_NAME
																and ccu.COLUMN_NAME = col.COLUMN_NAME

				WHERE tc.CONSTRAINT_TYPE = ''''Primary Key''''
				    and tc.CONSTRAINT_SCHEMA = ''''' + @SourceSchemaName
            + ''''' 
					and tc.TABLE_NAME = ''''' + @SourceTableName + '''''''';

        insert  into #Metadata
                execute ( @SQLString
                       );

	/* Add indexes for extended destination fields that is marked for being indexed.
	   The index creation is made in the CreateTable procedure.
	 */
        insert  into #Metadata
                ( [TableCatalog] ,
                  [SchemaName] ,
                  [TableName] ,
                  [TableKeyName] ,
                  [COLUMN_NAME] ,
                  [DATA_TYPE] ,
                  [KeyType] ,
                  [KeyColumnOrder] ,
                  [IncludedColumn] ,
                  IndexStorageLocation ,
                  FilterPredicate ,
                  IsAscendingOrder ,
                  IndexIsUnique ,
                  IndexFillFactor
		        )
                select distinct
                    dfe.DestinationTableCatalog ,
                    dt.DestinationSchemaName ,
                    DestinationTableName ,
                    'NCIDX_' + [COLUMN_NAME] + '_' + dt.DestinationSchemaName
                    + '_' + DestinationTableName ,
                    [COLUMN_NAME] ,
                    DATA_TYPE ,
                    'NCIX' ,
                    1 ,
                    0 ,
                    IndexStorageLocation = ( select
                                                case when dfe.DestinationTableCatalog = ( select top 1
                                                              [MartEnvironmentName]
                                                              from
                                                              [Metadata].[EnvironmentVariables]
                                                              )
                                                     then ( select top 1
                                                              [DefaultMartLayerIndexStorageLocation]
                                                            from
                                                              [Metadata].[EnvironmentVariables]
                                                          )
                                                     when dfe.DestinationTableCatalog = ( select top 1
                                                              [NormEnvironmentName]
                                                              from
                                                              [Metadata].[EnvironmentVariables]
                                                              )
                                                     then ( select top 1
                                                              [DefaultNormLayerIndexStorageLocation]
                                                            from
                                                              [Metadata].[EnvironmentVariables]
                                                          )
                                                     when dfe.DestinationTableCatalog = ( select top 1
                                                              [RawEnvironmentName]
                                                              from
                                                              [Metadata].[EnvironmentVariables]
                                                              )
                                                     then ( select top 1
                                                              [DefaultRawLayerIndexStorageLocation]
                                                            from
                                                              [Metadata].[EnvironmentVariables]
                                                          )
                                                     else 'DefaultLocation'
                                                end
                                           ) ,
                    null ,
                    1 ,
                    0 ,
                    null
                from
                    Metadata.[DestinationFieldExtended] dfe
                    join Metadata.DestinationTable dt
                    on dt.DestinationTableCatalog = dfe.DestinationTableCatalog
                       and ISNULL(ApplicableTable, dt.DestinationTableName) = dt.DestinationTableName
                       and ( case when ApplicableTable is null
                                  then dt.DestinationSchemaName
                                  else dfe.DestinationSchemaName
                             end ) = dt.DestinationSchemaName
		-- Only indexes for current group (or all or if group isn´t specified) will be created
                       and ( case when dfe.GroupName = 'All'
                                       or dfe.GroupName is null then 1
                                  when dfe.GroupName = dt.GroupName then 1
                                  else 0
                             end ) = 1
                where
                    CreateColumnIndex = 1
                    and dfe.DestinationTableCatalog = @DestinationTableCatalog
                    and dt.DestinationSchemaName = @DestinationSchemaName
                    and dt.DestinationTableName = @DestinationTableName;

        begin transaction PrimaryKeyDefinitionsFromSource;

        begin try
            delete from
                [Metadata].[TableKeyDefinition]
            where
                TableCatalog = @DestinationTableCatalog
                and SchemaName = @DestinationSchemaName
                and TableName = @DestinationTableName;

            insert  into [Metadata].[TableKeyDefinition]
                    select
                        *
                    from
                        #Metadata;

            commit transaction PrimaryKeyDefinitionsFromSource;

            print '	Table [Metadata].[TableKeyDefinition] refreshed ('
                + @SourceTableName + ')';
        end try

        begin catch
            raiserror (
				'Meta data not updated'
				,16
				,1
				);

            rollback transaction PrimaryKeyDefinitionsFromSource;
        end catch;

        drop table #Metadata;
    end;