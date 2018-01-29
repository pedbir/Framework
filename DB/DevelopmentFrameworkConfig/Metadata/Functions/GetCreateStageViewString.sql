



-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Returns a string with a create table statement, expressed in t-sql.
-- Example:	
--
--
-- =============================================
CREATE function [Metadata].[GetCreateStageViewString]
    (
      @SourceTableCatalog varchar(128) ,
      @SourceSchemaName varchar(128) ,
      @SourceTableName varchar(128) ,
      @SourceServer varchar(128) = null ,
      @StageTableCatalog varchar(128) ,
      @StageSchemaName varchar(128) ,
      @StageTableName varchar(128) ,
      @DestinationTableCatalog varchar(128) ,
      @DestinationTableSchema varchar(128) ,
      @DestinationTableName varchar(128)
    )
	returns varchar(max)
as
    begin
        declare
            @DropString varchar(max) ,
            @CreateString varchar(max) ,
            @COLUMN_NAME varchar(100) ,
            @DATA_TYPE varchar(100) ,
            @CHARACTER_MAXIMUM_LENGTH int ,
            @ORDINAL_POSITION int ,
            @NUMERIC_PRECISION int ,
            @NUMERIC_SCALE int ,
            @ColumnNamePrimaryKey varchar(100) ,
            @IS_NULLABLE varchar(3) ,
            @ColumnNameNettoColumn varchar(100) ,
            @ColumnNameNettoColumnDataType varchar(100) ,
            @ColumnNamePrimaryKeyDataType varchar(100) ,
            @IsIdentity bit ,
            @TableColumnSpecification nvarchar(1000) ,
            @TableCatalogName varchar(128) ,
            @SchemaName varchar(128) ,
            @ViewName varchar(128) ,
            @DATETIME_PRECISION int ,
            @pk_index_storage_location varchar(128) ,
            @CrLf char(2);

        set @CrLf = CHAR(13) + CHAR(10);

        set @ViewName = @SourceTableName;

        set @DropString = CONCAT('EXEC [' , @StageTableCatalog ,'].sys.sp_executesql N''if exists (select * from ',
                                 @StageTableCatalog, '.sys.objects 
				where object_id = OBJECT_ID(N''''', '[' + @StageTableCatalog,
                                 '].[', @StageSchemaName, '].[', @ViewName,
                                 ']'''') 
					and type in (N''''V''''))
					drop view [',
                                 @StageSchemaName + '].[', @ViewName, '];''',
                                 @CrLf);
        set @CreateString = CONCAT('EXEC [' , @StageTableCatalog ,'].sys.sp_executesql N''create view [', @StageSchemaName, '].[',
                                   @ViewName, '] as ');

        if ( select
                COUNT(*)
             from
                [Metadata].[SourceField]
             where
                TABLE_CATALOG = @SourceTableCatalog
                and TABLE_SCHEMA = @SourceSchemaName
                and TABLE_NAME = @SourceTableName
           ) < 1
            declare @err as int = CAST('Source table has no source fields' as int);

	-- Build up the create string from meta data
        declare cColumns cursor
        for
            select
                ax.COLUMN_NAME ,
                ax.DATA_TYPE ,
                ax.CHARACTER_MAXIMUM_LENGTH ,
                ax.ORDINAL_POSITION + 100000 as ORDINAL_POSITION ,
                ax.NUMERIC_PRECISION ,
                ax.NUMERIC_SCALE ,
                ax.IS_NULLABLE ,
                0 as IsIdentity ,
                null as TableColumnSpecification ,
                ax.DATETIME_PRECISION
            from
                [Metadata].[SourceField] as ax
                left outer join [Metadata].[DestinationFieldExtended] e
                on ax.DestinationTableCatalog = e.DestinationTableCatalog
                   and ax.COLUMN_NAME = e.COLUMN_NAME
                   and ISNULL(e.SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
            where
                ax.TABLE_NAME = @SourceTableName
                and ax.TABLE_SCHEMA = @SourceSchemaName
                and ax.DestinationTableCatalog = @DestinationTableCatalog
                and e.COLUMN_NAME is null
                and ax.COLUMN_NAME not like 'Checksum%'
                and ax.TABLE_CATALOG = @SourceTableCatalog
                and ( @SourceServer is null
                      or ax.TABLE_SERVER = @SourceServer
                    )
            union
	
	-- Extended columns -> Group "All"
            select
                [COLUMN_NAME] ,
                [DATA_TYPE] ,
                [CHARACTER_MAXIMUM_LENGTH] ,
                [ORDINAL_POSITION] ,
                [NUMERIC_PRECISION] ,
                [NUMERIC_SCALE] ,
                [IS_NULLABLE] ,
                IsIdentity ,
                TableColumnSpecification ,
                a.DATETIME_PRECISION
            from
                [Metadata].[DestinationFieldExtended] a
            where
                [DestinationTableCatalog] = @DestinationTableCatalog
                and ISNULL(ApplicableTable, @DestinationTableName) = @DestinationTableName
                and ISNULL(SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
                and ISNULL(GroupName, 'All') = 'All'
            union
	
	-- Extended columns -> The group extensions for the current table
            select
                [COLUMN_NAME] ,
                [DATA_TYPE] ,
                [CHARACTER_MAXIMUM_LENGTH] ,
                [ORDINAL_POSITION] ,
                [NUMERIC_PRECISION] ,
                [NUMERIC_SCALE] ,
                [IS_NULLABLE] ,
                IsIdentity ,
                TableColumnSpecification ,
                dfe.DATETIME_PRECISION
            from
                [Metadata].[DestinationFieldExtended] as dfe
                inner join [Metadata].DestinationTable as dt
                on dfe.DestinationTableCatalog = dt.DestinationTableCatalog
		--and dfe.GroupName = dt.GroupName
                   and dt.DestinationTableName = @DestinationTableName
                   and dt.GroupName = dfe.GroupName
            where
                dfe.[DestinationTableCatalog] = @DestinationTableCatalog
                and ISNULL(ApplicableTable, @DestinationTableName) = @DestinationTableName
                and ISNULL(dfe.SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
                and ISNULL(dfe.GroupName, 'All') <> 'All'
            order by
                ORDINAL_POSITION;

        open cColumns;

        fetch next
	from cColumns
	into @COLUMN_NAME, @DATA_TYPE, @CHARACTER_MAXIMUM_LENGTH,
            @ORDINAL_POSITION, @NUMERIC_PRECISION, @NUMERIC_SCALE,
            @IS_NULLABLE, @IsIdentity, @TableColumnSpecification,
            @DATETIME_PRECISION;

        declare @columnString varchar(max) = '';

        while @@Fetch_Status = 0
            begin
                set @columnString = CONCAT(@columnString, ',[', @COLUMN_NAME,
                                           ']=CONVERT(',
                                           case @DATA_TYPE
                                             when 'image'
                                             then 'varbinary(max)'
                                             when 'ntext' then 'nvarchar(max)'
                                             when 'text' then 'varchar(max)'
                                             when 'timestamp'
                                             then 'varbinary(8)'
                                             else @DATA_TYPE
                                           end,
                                           case when @CHARACTER_MAXIMUM_LENGTH = -1
                                                     and @DATA_TYPE not like '%text'
                                                     and @DATA_TYPE not like '%image'
                                                then '(max)'
                                                when @CHARACTER_MAXIMUM_LENGTH is not null
                                                     and @DATA_TYPE not like '%text'
                                                     and @DATA_TYPE not like '%image'
                                                then CONCAT('(',
                                                            LTRIM(STR(@CHARACTER_MAXIMUM_LENGTH)),
                                                            ')')
                                                when @NUMERIC_PRECISION is not null
                                                     and @DATA_TYPE not like '%int'
                                                     and @DATA_TYPE not like '%money'
                                                     and @DATA_TYPE not like '%float'
                                                then CONCAT('(',
                                                            LTRIM(STR(@NUMERIC_PRECISION)),
                                                            ', ',
                                                            LTRIM(STR(@NUMERIC_SCALE)),
                                                            ')')
                                                when @DATETIME_PRECISION is not null
                                                     and ( @DATA_TYPE like 'datetime2'
                                                           or @DATA_TYPE like 'time'
                                                         )
                                                then CONCAT('(',
                                                            LTRIM(STR(@DATETIME_PRECISION)),
                                                            ')')
                                                else ''
                                           end, ',', '[', @COLUMN_NAME, ']',
                                           ')', @CrLf);

                fetch next
		from cColumns
		into @COLUMN_NAME, @DATA_TYPE, @CHARACTER_MAXIMUM_LENGTH,
                    @ORDINAL_POSITION, @NUMERIC_PRECISION, @NUMERIC_SCALE,
                    @IS_NULLABLE, @IsIdentity, @TableColumnSpecification,
                    @DATETIME_PRECISION;
            end;

        close cColumns;

        deallocate cColumns;

        set @columnString = RIGHT(@columnString, LEN(@columnString) - 1);
        set @CreateString = CONCAT(@DropString, @CrLf, @CrLf, @CreateString, @CrLf, @CrLf, 'select ',
                                   @CrLf, @columnString, 'from ',
                                   @StageTableCatalog, '.', @StageSchemaName,
                                   '.', @StageTableName, ';'''); 

        
        return @CreateString;
    end;