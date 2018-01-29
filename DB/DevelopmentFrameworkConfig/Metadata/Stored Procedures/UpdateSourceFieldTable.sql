-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Refreshes the meta data for the current table and database
-- Example:	
/* 
	EXECUTE [Metadata].[UpdateSourceFieldTable] @LinkedServerName = '[LOCALHOST]'
		, @SourceDatabaseName = 'Stage'
		, @SourceTableName = 'Person'
		, @DestinationTableCatalog = 'DataWarehouse'
		, @SourceSchemaName = 'DataWarehouse'
		, @SourceServer = null
							
*/--
-- =============================================
CREATE procedure [Metadata].[UpdateSourceFieldTable]
    @LinkedServerName varchar(50)
  , @SourceDatabaseName varchar(50)
  , @SourceSchemaName varchar(50)
  , @SourceTableName varchar(50)
  , @DestinationTableCatalog varchar(50)
  , @SourceServer varchar(128)
as
    begin
	declare @err_msg varchar(400);
	
	/* BEGIN Get DestinationTable metadata */
        declare @FactScdType tinyint;

        select  @FactScdType = FactScdType
        from    Metadata.DestinationTable as dt
        where   1 = 1
                and dt.SourceTableCatalog = @SourceDatabaseName
                and dt.SourceSchemaName = @SourceSchemaName
                and dt.SourceTableName = @SourceTableName
                and dt.DestinationTableCatalog = @DestinationTableCatalog
                and (@SourceServer is null or dt.SourceServer = @SourceServer);

	/* END Get DestinationTable metadata */

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        set nocount on;

        select  *
        into    #Metadata
        from    [Metadata].[SourceField]
        where   1 = 2;

        alter table #Metadata

        drop column SourceFieldID;

        alter table #Metadata

        drop column DestinationTableCatalog;

        alter table #Metadata

        drop column TABLE_SERVER;

        declare @SQLString varchar(max) = 'EXECUTE ' + @LinkedServerName + '.'
            + @SourceDatabaseName + '.dbo.sp_executesql
		N''SELECT * FROM INFORMATION_SCHEMA.Columns WHERE TABLE_SCHEMA = '''''
            + @SourceSchemaName + '''''' + 'AND TABLE_NAME = '''''
            + @SourceTableName + '''''' + '''';

        print @SQLString;

        insert  into #Metadata
                execute ( @SQLString
                       );

        if @DestinationTableCatalog = 'DWH_3_Fact'
            begin
                declare @SysDateTimeDeletedUTCColumnName varchar(255) = 'SysDateTimeDeletedUTC';
                if @FactScdType = 1
                    and not exists ( select *
                                     from   #Metadata as m
                                     where  m.COLUMN_NAME = @SysDateTimeDeletedUTCColumnName )
                    begin 
                        set @err_msg = CONCAT('Column ',
                                                              @SysDateTimeDeletedUTCColumnName,
                                                              ' is mandatory for FactScdType = 1');
                        raiserror (
							@err_msg
							,16
							,1
						);
						return;
                    end;
            end; 

        begin transaction Metadata;

        begin try
            delete  from [Metadata].[SourceField]
            where   DestinationTableCatalog = @DestinationTableCatalog
                    and TABLE_SCHEMA = @SourceSchemaName
                    and TABLE_NAME = @SourceTableName
                    and TABLE_CATALOG = @SourceDatabaseName
                    and ( @SourceServer is null
                          or TABLE_SERVER = @SourceServer
                        ); --addition 2013-06-12 wiol

            insert  into [Metadata].[SourceField]
                    ( [TABLE_CATALOG]
                    , [TABLE_SCHEMA]
                    , [TABLE_NAME]
                    , [COLUMN_NAME]
                    , [ORDINAL_POSITION]
                    , [COLUMN_DEFAULT]
                    , [IS_NULLABLE]
                    , [DATA_TYPE]
                    , [CHARACTER_MAXIMUM_LENGTH]
                    , [CHARACTER_OCTET_LENGTH]
                    , [NUMERIC_PRECISION]
                    , [NUMERIC_PRECISION_RADIX]
                    , [NUMERIC_SCALE]
                    , [DATETIME_PRECISION]
                    , [CHARACTER_SET_CATALOG]
                    , [CHARACTER_SET_SCHEMA]
                    , [CHARACTER_SET_NAME]
                    , [COLLATION_CATALOG]
                    , [COLLATION_SCHEMA]
                    , [COLLATION_NAME]
                    , [DOMAIN_CATALOG]
                    , [DOMAIN_SCHEMA]
                    , [DOMAIN_NAME]
                    , [TABLE_SERVER]
                    , DestinationTableCatalog
			        )
                    select  #Metadata.[TABLE_CATALOG]
                          , #Metadata.[TABLE_SCHEMA]
                          , #Metadata.[TABLE_NAME]
                          , #Metadata.[COLUMN_NAME]
                          , #Metadata.[ORDINAL_POSITION]
                          , #Metadata.[COLUMN_DEFAULT]
                          , #Metadata.[IS_NULLABLE]
                          , #Metadata.[DATA_TYPE]
                          , #Metadata.[CHARACTER_MAXIMUM_LENGTH]
                          , #Metadata.[CHARACTER_OCTET_LENGTH]
                          , #Metadata.[NUMERIC_PRECISION]
                          , #Metadata.[NUMERIC_PRECISION_RADIX]
                          , #Metadata.[NUMERIC_SCALE]
                          , #Metadata.[DATETIME_PRECISION]
                          , #Metadata.[CHARACTER_SET_CATALOG]
                          , #Metadata.[CHARACTER_SET_SCHEMA]
                          , #Metadata.[CHARACTER_SET_NAME]
                          , #Metadata.[COLLATION_CATALOG]
                          , #Metadata.[COLLATION_SCHEMA]
                          , #Metadata.[COLLATION_NAME]
                          , #Metadata.[DOMAIN_CATALOG]
                          , #Metadata.[DOMAIN_SCHEMA]
                          , #Metadata.[DOMAIN_NAME]
                          , @SourceServer
                          , @DestinationTableCatalog
                    from    #Metadata
                            left outer join Metadata.DestinationFieldExtended
                                as e
                                on #Metadata.COLUMN_NAME = e.COLUMN_NAME
                                   and e.DestinationTableCatalog = @DestinationTableCatalog
                                   and ISNULL(e.SourceTableCatalog,
                                              @SourceDatabaseName) = @SourceDatabaseName
                    where   #Metadata.COLUMN_NAME not like 'Checksum%' -- Vi tar inte med checksumma kolumner
                            and e.COLUMN_NAME is null
                            or e.COLUMN_NAME = 'SysDateTimeDeletedUTC';

		-- Mark this update as update also in the destinationtable table
            update  Metadata.DestinationTable
            set     UserNameUpdated = system_user
                  , DateTimeUpdatedUTC = GETUTCDATE()
            where   DestinationTableCatalog = @DestinationTableCatalog
                    and SourceSchemaName = @SourceSchemaName
                    and SourceTableName = @SourceTableName
                    and SourceTableCatalog = @SourceDatabaseName
                    and ( @SourceServer is null
                          or SourceServer = @SourceServer
                        );

            commit transaction Metadata;
        end try

        begin catch
            set @err_msg= 'Source field meta data not updated: '
                + ERROR_MESSAGE();

            raiserror (
				@err_msg
				,16
				,1
				);

            rollback transaction Metadata;
        end catch;

        drop table #Metadata;

        print '	Table [Metadata].[SourceField] refreshed (' + @SourceTableName
            + ')';
    end;