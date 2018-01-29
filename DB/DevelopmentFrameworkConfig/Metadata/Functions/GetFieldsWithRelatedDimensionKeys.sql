
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
/*
	SELECT *
	FROM [Metadata].[GetFieldsWithRelatedDimensionKeys]('Stage', 'DataWarehouse', 'Person', 'DataWarehouse', 'DW', 'Person')
*/
--
--
-- =============================================
CREATE function [Metadata].[GetFieldsWithRelatedDimensionKeys]
    (
      @SourceTableCatalog varchar(128) ,
      @SourceSchemaName varchar(128) ,
      @SourceTableName varchar(128) ,
      @DestinationTableCatalog varchar(128) ,
      @DestinationSchemaName varchar(128) ,
      @DestinationTableName varchar(128)
    )
returns table
as
return
    (
		with    Sourcefields
                  as ( select
                        sf.DestinationTableCatalog ,
                        DestinationSchemaName ,
                        sf.TABLE_NAME as TableName ,
                        sf.COLUMN_NAME as ColumnName ,
                        case when LEN(sf.COLUMN_NAME)
                                  - LEN(REPLACE(sf.COLUMN_NAME, '_', '')) > 1
                             then CONCAT(LEFT(sf.COLUMN_NAME,
                                              CHARINDEX('_', sf.COLUMN_NAME)),
                                         RIGHT(sf.COLUMN_NAME,
                                               CHARINDEX('_',
                                                         REVERSE(sf.COLUMN_NAME))
                                               - 1))
                             else sf.COLUMN_NAME
                        end as FKColumnName ,
                        ORDINAL_POSITION ,
                        DATA_TYPE as DataType ,
                        dt.DestinationTableName
                       from
                        Metadata.SourceField sf
                        join Metadata.DestinationTable dt
                        on dt.SourceTableCatalog = sf.TABLE_CATALOG
                           and dt.SourceSchemaName = sf.[TABLE_SCHEMA]
                           and dt.SourceTableName = sf.TABLE_NAME
                           and dt.DestinationTableCatalog = sf.DestinationTableCatalog
                       where
                        sf.TABLE_CATALOG = @SourceTableCatalog
                        and sf.TABLE_SCHEMA = @SourceSchemaName
                        and sf.TABLE_NAME = @SourceTableName
                        and sf.DestinationTableCatalog = @DestinationTableCatalog
                        and dt.DestinationSchemaName = @DestinationSchemaName
                        and dt.DestinationTableName = @DestinationTableName
                     ),
                Keys
                  as ( select
                        TableCatalog ,
                        SchemaName ,
                        tkd.TableName ,
                        tkd.COLUMN_NAME as ColumnName ,
					-- ifall inte ordinalpositionerna är korrekt satta i TableKeyDefinition använder vi ROW_NUMBER istället
                        'KeyCol'
                        + CONVERT(varchar(2), ROW_NUMBER() over ( partition by tkd.TableCatalog,
                                                              tkd.SchemaName,
                                                              tkd.TableName order by tkd.KeyColumnOrder )) as ColumnOrdinalName
                       from
                        Metadata.TableKeyDefinition tkd
                       where
                        exists ( select top 1
                                    1
                                 from
                                    Sourcefields sf
                                 where
                                    sf.DestinationTableCatalog = tkd.TableCatalog
                                    and sf.DestinationSchemaName = tkd.SchemaName )
                        and KeyType = 'PK'
                        and tkd.COLUMN_NAME not in (
						--'SysSrcGenerationDateTime'
                        'ToDate' ) --, 'SourceSystemKey')
                        and tkd.TableName like 'n_%'
                     ),
                KeyPivot
                  as ( select
                        TableName ,
                        [KeyCol1] ,
                        [KeyCol2] ,
                        [KeyCol3] ,
                        [KeyCol4] ,
                        [KeyCol5] ,
                        [KeyCol6] ,
                        [KeyCol7]
                       from
                        Keys pivot( MAX(ColumnName) for ColumnOrdinalName in ( [KeyCol1],
                                                              [KeyCol2],
                                                              [KeyCol3],
                                                              [KeyCol4],
                                                              [KeyCol5],
                                                              [KeyCol6],
                                                              [KeyCol7] ) ) as pvt
                     )
    select
        sf.TableName ,
        sf.ColumnName ,
        ORDINAL_POSITION as OrdinalPosition ,
        kp.TableName as RelatedTableName ,
        case when KeyCol1 = sf.FKColumnName then KeyCol1
             when KeyCol2 = sf.FKColumnName then KeyCol2
             when KeyCol3 = sf.FKColumnName then KeyCol3
             when KeyCol4 = sf.FKColumnName then KeyCol4
             when KeyCol5 = sf.FKColumnName then KeyCol5
             when KeyCol6 = sf.FKColumnName then KeyCol6
             when KeyCol7 = sf.FKColumnName then KeyCol7
             else null
        end as RelatedKeyColumn ,
        DataType as RelatedKeyDataType ,
        case DataType
          when 'nvarchar' then 'String'
          when 'varchar' then 'String'
          when 'int' then 'Int32'
          when 'bigint' then 'Int64'
          when 'bit' then 'Boolean'
          when 'smallint' then 'Int16'
          when 'date' then 'DateTime'
          when 'numeric' then 'Double'
          else DataType
        end as RelatedKeySSISDataType
    from
        Sourcefields sf
        left join KeyPivot kp
        on ( KeyCol1 = sf.FKColumnName
             or KeyCol2 = sf.FKColumnName
             or KeyCol3 = sf.FKColumnName
             or KeyCol4 = sf.FKColumnName
             or KeyCol5 = sf.FKColumnName
             or KeyCol6 = sf.FKColumnName
             or KeyCol7 = sf.FKColumnName
           )
           and ( KeyCol1 like '%_bkey'
                 and KeyCol1 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol1 is null
               )
           and ( KeyCol2 like '%_bkey'
                 and KeyCol2 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol2 is null
               )
           and ( KeyCol3 like '%_bkey'
                 and KeyCol3 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol3 is null
               )
           and ( KeyCol4 like '%_bkey'
                 and KeyCol4 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol4 is null
               )
           and ( KeyCol5 like '%_bkey'
                 and KeyCol5 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol5 is null
               )
           and ( KeyCol6 like '%_bkey'
                 and KeyCol6 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol6 is null
               )
           and ( KeyCol7 like '%_bkey'
                 and KeyCol7 in ( select
                                    FKColumnName
                                  from
                                    Sourcefields )
                 or KeyCol7 is null
               )
		);