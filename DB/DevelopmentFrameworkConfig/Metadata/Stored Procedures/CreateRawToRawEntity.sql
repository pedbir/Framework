CREATE proc Metadata.CreateRawToRawEntity
@sourcedb varchar(255) = 'DW_1_Raw',
@targetdb varchar(255) = 'DWH_1_Raw',
@clusteringfields varchar(255) = 'ExecutionLog_key'
as 
declare @sql_createtable varchar(max)= '';
declare @sql_createindex varchar(max)= '';
declare @sql_filltables varchar(max) = CONCAT('insert into #tables',CHAR(13),CHAR(10),'select * from ', @sourcedb, '.INFORMATION_SCHEMA.TABLES')
declare @sql_fillcolumns varchar(max) = CONCAT('insert into #columns',CHAR(13),CHAR(10),'select * from ', @sourcedb, '.INFORMATION_SCHEMA.COLUMNS')

set nocount on;

select * 
into #columns
from INFORMATION_SCHEMA.COLUMNS as c
where 1=0


select * 
into #tables
from INFORMATION_SCHEMA.TABLES as t 
where 1=0;

exec(@sql_fillcolumns);
exec(@sql_filltables);

with    rawinfo
          as ( select   TableName = CONCAT('RawTyped.[', c.TABLE_NAME, ']')
                      , ColumnDeclaration = CONCAT('[', c.COLUMN_NAME, '] ',
                                                   c.DATA_TYPE,
                                                   case when c.DATA_TYPE = 'datetime2'
                                                        then CONCAT('(',
                                                              CONVERT(varchar(2), c.DATETIME_PRECISION),
                                                              ')')
                                                        when CHARINDEX('char',
                                                              c.DATA_TYPE) > 0
                                                        then CONCAT('(',
                                                              CONVERT(varchar(2), c.CHARACTER_MAXIMUM_LENGTH),
                                                              ')')
                                                        when c.DATA_TYPE in (
                                                             'decimal',
                                                             'numerical' )
                                                        then CONCAT('(',
                                                              CONVERT(varchar(2), c.NUMERIC_PRECISION),
                                                              ',',
                                                              CONVERT(varchar(2), c.NUMERIC_SCALE),
                                                              ')')
                                                        else ''
                                                   end, ' ',
                                                   case when c.IS_NULLABLE = 'YES'
                                                        then 'null'
                                                        else 'not null'
                                                   end)
                      , c.ORDINAL_POSITION
               from     #columns as c
               where    1 = 1
                        and c.TABLE_SCHEMA = 'RawTyped_External'
             )
    select  @sql_createtable = CONCAT(@sql_createtable, CHAR(13), CHAR(10),
                                      CHAR(13), CHAR(10), 'create table ',
                                      @targetdb, '.', t1.TableName, '(',
                                      STUFF(
                   (select  CONCAT(', ', CHAR(13), CHAR(10),
                                   t2.ColumnDeclaration)
                    from    rawinfo t2
                    where   t1.TableName = t2.TableName
                    order by t2.ORDINAL_POSITION
                                      for   xml path('')
                                              , type
                   ).value('.', 'varchar(max)'), 1, 2, ''), ');', CHAR(13),
                                      CHAR(10))
    from    rawinfo t1
    group by t1.TableName;


print @sql_createtable;
exec(@sql_createtable);



select  @sql_createindex = CONCAT(@sql_createindex, 'create clustered index [CI_', c.TABLE_NAME, '] on ', @targetdb, '.RawTyped.[', c.TABLE_NAME, '](', CHAR(13), CHAR(10), @clusteringfields, CHAR(13), CHAR(10), ') with (data_compression=page);', CHAR(13), CHAR(10), CHAR(13), CHAR(10))
from    #tables as c
where   1 = 1
        and c.TABLE_SCHEMA = 'RawTyped_External';
     
print @sql_createindex;
exec(@sql_createindex);