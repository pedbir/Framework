-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE procedure [ssis].[GetPackageInfoDWDetails]
    @SOURCE_SERVER varchar(max) ,
    @SOURCE_CATALOG varchar(max) ,
    @SOURCE_SCHEMA_NAME varchar(max) ,
    @SOURCE_TABLE_NAME varchar(max) = null ,
    @DESTINATION_TABLE_CATALOG varchar(max) ,
    @UseStageTable bit = 0
as
    begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        set nocount on;

        declare
            @DESTINATION_SCHEMA_NAME varchar(max) ,
            @DESTINATION_TABLE_NAME varchar(max) ,
            @_SOURCE_CATALOG varchar(max) ,
            @_SOURCE_SCHEMA_NAME varchar(max) ,
            @_SOURCE_TABLE_NAME varchar(max),
			@_IncludeHash bit = 1;

        select
            @DESTINATION_SCHEMA_NAME = dt.DestinationSchemaName ,
            @DESTINATION_TABLE_NAME = dt.DestinationTableName ,
            @_SOURCE_CATALOG = dt.SourceTableCatalog ,
            @_SOURCE_SCHEMA_NAME = dt.SourceSchemaName ,
            @_SOURCE_TABLE_NAME = dt.SourceTableName,
			@_IncludeHash = case dt.GroupName when 'Fact' then 0 else  1 end
        from
            Metadata.DestinationTable dt
        where
            1 = 1
            and ( @UseStageTable = 1
                  and dt.StageTableCatalog = @SOURCE_CATALOG
                  and dt.StageSchemaName = @SOURCE_SCHEMA_NAME
                  or ( dt.SourceTableCatalog = @SOURCE_CATALOG
                       and dt.SourceSchemaName = @SOURCE_SCHEMA_NAME
                     )
                )
			and dt.SourceTableName = @SOURCE_TABLE_NAME;

        select
		-- Execute Sql Task Add unknown member objects
            umInsValCols.InsCol as UnknownMemberInsCols ,
            umInsValCols.ValCol as UnKnownMemberValCols ,
            ssis.GetSrcDstKeyCondition(@DESTINATION_TABLE_CATALOG,
                                       @DESTINATION_SCHEMA_NAME,
                                       @DESTINATION_TABLE_NAME, 'AND') as SqlTaskKeyCondition
		-- Data Flow objects
            ,
            IdColumn.IdentityColumn as DestinationIdentityColumn ,
            FkCount.FkCount as ForeignKeyCount ,
            case @UseStageTable
              when 1
              then REPLACE(ssis.GetSourceSelectQuery(null,
                                                     dt.SourceTableCatalog,
                                                     dt.SourceSchemaName,
                                                     dt.SourceTableName,
                                                     dt.DestinationTableCatalog,
                                                     @_IncludeHash, dt.SSISIncrementalLoad),
                           CONCAT(QUOTENAME(dt.SourceSchemaName), '.',
                                  QUOTENAME(dt.SourceTableName)),
                           CONCAT(QUOTENAME(dt.StageSchemaName), '.',
                                  QUOTENAME(dt.SourceTableName)))
              else ssis.GetSourceSelectQuery(null, dt.SourceTableCatalog,
                                             dt.SourceSchemaName,
                                             dt.SourceTableName,
                                             dt.DestinationTableCatalog, @_IncludeHash,
                                             dt.SSISIncrementalLoad)
            end SourceSQLQuery 
		-- Dimension Lookup objects
            ,
            ssis.GetDimLookupSelectQuery(dt.DestinationTableCatalog,
                                         dt.DestinationSchemaName,
                                         dt.DestinationTableName, 1) DimLkpSqlQuery ,
            ssis.GetDimLookupInputColumns(dt.DestinationSchemaName,
                                          dt.DestinationTableName) as DimLkpInputCols ,
            ssis.GetDimLookupOutputColumns(dt.DestinationSchemaName,
                                           dt.DestinationTableName) as DimLkpOutputCols
		-- Derived Columns
            ,
            ssis.GetDerivedColumns(dt.SourceTableCatalog,
                                   dt.DestinationTableCatalog,
                                   dt.DestinationTableName,
                                   dt.DestinationSchemaName, 'dwInit') DCInit ,
            ssis.GetDerivedColumns(dt.SourceTableCatalog,
                                   dt.DestinationTableCatalog,
                                   dt.DestinationTableName,
                                   dt.DestinationSchemaName, 'dwInf') DCInf ,
            ssis.GetDerivedColumns(dt.SourceTableCatalog,
                                   dt.DestinationTableCatalog,
                                   dt.DestinationTableName,
                                   dt.DestinationSchemaName, 'dwNewRow') DCNewRow ,
            ssis.GetDerivedColumns(dt.SourceTableCatalog,
                                   dt.DestinationTableCatalog,
                                   dt.DestinationTableName,
                                   dt.DestinationSchemaName, 'dwNewVer') DCNewVer ,
            ssis.GetDerivedColumns(dt.SourceTableCatalog,
                                   dt.DestinationTableCatalog,
                                   dt.DestinationTableName,
                                   dt.DestinationSchemaName, 'dwError') DCError
		-- Multi Cast objects
            ,
            ssis.GetMultiCastOutputColumns(dt.DestinationTableCatalog,
                                           dt.DestinationSchemaName,
                                           dt.DestinationTableName, 'dwInfFK') MCInfFK
		-- OleDb Command objects
            ,
            ssis.GetOleDbCommandParameters(dt.SourceTableCatalog,
                                           dt.DestinationTableCatalog,
                                           dt.DestinationSchemaName,
                                           dt.DestinationTableName, 'All') as OleDbCmdParams ,
            ssis.GetOleDbCommandParameters(dt.SourceTableCatalog,
                                           dt.DestinationTableCatalog,
                                           dt.DestinationSchemaName,
                                           dt.DestinationTableName, 'dwToDate') as OleDbCmdToDateParams ,
            CONCAT('Update ', QUOTENAME(dt.DestinationSchemaName), '.',
                   QUOTENAME(dt.DestinationTableName), ' Set ',
                   ssis.GetOleDbCommandUpdateColumns(dt.SourceTableCatalog,
                                                     dt.DestinationTableCatalog,
                                                     dt.DestinationSchemaName,
                                                     dt.DestinationTableName,
                                                     'dwInfUpd'), ' Where ',
                   IdColumn.IdentityColumn, ' = ?') as OleDbCmdUpdInfSql ,
            CONCAT('Update ', QUOTENAME(dt.DestinationSchemaName), '.',
                   QUOTENAME(dt.DestinationTableName), ' Set ',
                   ssis.GetOleDbCommandUpdateColumns(dt.SourceTableCatalog,
                                                     dt.DestinationTableCatalog,
                                                     dt.DestinationSchemaName,
                                                     dt.DestinationTableName,
                                                     'dwSCD1'), ' Where ',
                   IdColumn.IdentityColumn, ' = ?') as OleDbCmdUpdSCD1Sql ,
            CONCAT('Update ', QUOTENAME(dt.DestinationSchemaName), '.',
                   QUOTENAME(dt.DestinationTableName), ' Set ',
                   ssis.GetOleDbCommandUpdateColumns(dt.SourceTableCatalog,
                                                     dt.DestinationTableCatalog,
                                                     dt.DestinationSchemaName,
                                                     dt.DestinationTableName,
                                                     'dwToDate'), ' Where ',
                   IdColumn.IdentityColumn, ' = ?') as OleDbCmdUpdToDateSql
		-- Union Error objects
            ,
            ssis.GetUnionErrorInputColumns(dt.SourceTableCatalog,
                                           dt.DestinationTableCatalog,
                                           dt.DestinationSchemaName,
                                           dt.DestinationTableName, 'dwDim') UEInputColumns
	-- Union Error objects
	, case @UseStageTable
              when 1
			  then  ssis.GetSourceSelectQuery(null, dt.SourceTableCatalog,
                                             dt.SourceSchemaName,
                                             dt.SourceTableName,
                                             dt.DestinationTableCatalog, 0,
                                             dt.SSISIncrementalLoad)
			else null end as StageSqlQuery
        from
            Metadata.DestinationTable dt
            join ( select distinct
                    ivc.Table_Catalog ,
                    ivc.Table_Schema ,
                    ivc.Table_Name ,
                    ivc.DestinationTableCatalog ,
                    ivc.DestinationSchemaName ,
                    STUFF(( select
                                ',' + COLUMN_NAME
                            from
                                [ssis].[SQLTaskAddMissingMemberInsertValueColumns] x
                            where
                                x.DestinationTableCatalog = ivc.DestinationTableCatalog
                                and x.Table_Catalog = ivc.Table_Catalog
                                and ISNULL(x.Table_Name, ivc.Table_Name) = ivc.Table_Name
                                and ISNULL(x.Table_Schema, ivc.Table_Schema) = ivc.Table_Schema
                            order by
                                ordNo ,
                                ORDINAL_POSITION
                          for
                            xml path('')
                          ), 1, 1, '') InsCol ,
                    STUFF(( select
                                ',' + ValueCol
                            from
                                [ssis].[SQLTaskAddMissingMemberInsertValueColumns] x
                            where
                                x.DestinationTableCatalog = ivc.DestinationTableCatalog
                                and x.Table_Catalog = ivc.Table_Catalog
                                and ISNULL(x.Table_Name, ivc.Table_Name) = ivc.Table_Name
                                and ISNULL(x.Table_Schema, ivc.Table_Schema) = ivc.Table_Schema
                            order by
                                ordNo ,
                                ORDINAL_POSITION
                          for
                            xml path('')
                          ), 1, 1, '') ValCol
                   from
                    [ssis].[SQLTaskAddMissingMemberInsertValueColumns] ivc
                   where
                    ISNULL(ivc.Table_Catalog, @_SOURCE_CATALOG) = @_SOURCE_CATALOG
                    and ISNULL(ivc.Table_Schema, @_SOURCE_SCHEMA_NAME) = @_SOURCE_SCHEMA_NAME
                    and ISNULL(ivc.Table_Name, @_SOURCE_TABLE_NAME) = @_SOURCE_TABLE_NAME
                    and ivc.DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
                 ) umInsValCols
            on dt.SourceTableCatalog = umInsValCols.Table_Catalog
               and dt.SourceSchemaName = umInsValCols.Table_Schema
               and dt.SourceTableName = umInsValCols.Table_Name
               and dt.DestinationTableCatalog = umInsValCols.DestinationTableCatalog
		--AND dt.DestinationSchemaName = umInsValCols.DestinationSchemaName
            left join (
		-- get the one identity column for target (SurrogateKey). 
		-- It is derived from DestinationFieldExtended table.
		-- Fact table do not have identity column, left join 
                        select
                            [COLUMN_NAME] IdentityColumn ,
                            ApplicableTable
                        from
                            [Metadata].[DestinationFieldExtended]
                        where
                            DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
                            and SourceTableCatalog = @_SOURCE_CATALOG
                            and ApplicableTable = @DESTINATION_TABLE_NAME
                            and DestinationSchemaName = @DESTINATION_SCHEMA_NAME
                            and IsIdentity = 1
                      ) IdColumn
            on 1 = 1
            left join ( select
                            COUNT(1) as FkCount
                        from
                            ssis.DimensionForeignKeyColumns fkc
                        where
                            fkc.DimensionTableCatalog = @DESTINATION_TABLE_CATALOG
                            and fkc.DimensionSchemaName = @DESTINATION_SCHEMA_NAME
                            and fkc.DimensionTableName = @DESTINATION_TABLE_NAME
                      ) FkCount
            on 1 = 1
        where
            not ValCol is null;
    end;