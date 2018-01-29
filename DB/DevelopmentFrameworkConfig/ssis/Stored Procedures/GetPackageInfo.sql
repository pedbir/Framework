-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE procedure [ssis].[GetPackageInfo]
    @DESTINATION_TABLE_CATALOG varchar(max) ,
    @DESTINATION_SCHEMA_NAMES varchar(max) = null ,
    @SOURCE_TABLE_NAME varchar(max) = null
as
    begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
        set nocount on;

        select
		-- Source
            t2.SourceServer ,
            t2.SourceTableCatalog ,
            t2.SourceSchemaName ,
            t2.SourceTableName ,
            t2.SourceName ,
            SourceSQLQuery = case t2.UseStageTable
                               when 1
                               then REPLACE(t2.SourceSQLQuery,
                                            t2.StageSourceName, t2.SourceName)
							   else t2.SourceSQLQuery
                             end ,
            t2.SourceFilterCondition
		
		-- Stage
            ,
            t2.StageTableCatalog ,
            t2.StageName ,
            t2.StageFilterCondition
		-- Destination
            ,
            t2.DestinationTableCatalog ,
            t2.DestinationSchemaName ,
            t2.DestinationTableName ,
            t2.DestinationName ,
            t2.DestinationDeleteCondition
		-- SSIS
            ,
            t2.SSISPackageName ,
            t2.SSISPackageGUID ,
            t2.SSISConfigurationFrameWorkCatalog ,
            t2.DtsConfigEnvironmentVariableName ,
            t2.CDCInstanceName ,
            t2.UseSSISLoggingFrameWork ,
            t2.SSISIncrementalLoad
		-- MISC
            ,
            t2.ContainerVariables ,
            t2.BimlType ,
            t2.UseStageTable ,
            t2.StageSchemaName ,
            t2.StageTableName ,
            t2.StageSourceTableCatalog ,
            t2.StageSourceSchemaName ,
            t2.StageSourceName ,
            t2.StageSourceSqlQuery
        from
            ( select 
	-- Source
                t1.SourceServer ,
                t1.SourceTableCatalog ,
                t1.SourceSchemaName ,
                t1.SourceTableName ,
                CONCAT(QUOTENAME(t1.SourceSchemaName), '.',
                       QUOTENAME(t1.SourceTableName)) as SourceName ,
                t1.SourceSQLQuery ,
                t1.SourceFilterCondition
		
		-- Stage
                ,
                t1.StageTableCatalog ,
                CONCAT(QUOTENAME(t1.StageSchemaName), '.',
                       QUOTENAME(t1.StageTableName)) as StageName ,
                t1.StageFilterCondition
		-- Destination
                ,
                t1.DestinationTableCatalog ,
                t1.DestinationSchemaName ,
                t1.DestinationTableName ,
                CONCAT(QUOTENAME(t1.DestinationSchemaName), '.',
                       QUOTENAME(t1.DestinationTableName)) as DestinationName ,
                t1.DestinationDeleteCondition
		-- SSIS
                ,
                t1.SSISPackageName ,
                t1.SSISPackageGUID ,
                t1.SSISConfigurationFrameWorkCatalog ,
                t1.DtsConfigEnvironmentVariableName ,
                t1.CDCInstanceName ,
                t1.UseSSISLoggingFrameWork ,
                t1.SSISIncrementalLoad
		-- MISC
                ,
                t1.ContainerVariables ,
                t1.BimlType ,
                t1.UseStageTable ,
                t1.StageSchemaName ,
                t1.StageTableName ,
                t1.StageSourceTableCatalog ,
                t1.StageSourceSchemaName ,
                CONCAT(QUOTENAME(t1.StageSourceSchemaName), '.',
                       QUOTENAME(t1.SourceTableName)) as StageSourceName ,
                StageSourceSqlQuery = case t1.UseStageTable
                                        when 1 then t1.SourceSQLQuery
                                        else null
                                      end
              from
                ( select
		-- Source
                    dt.SourceServer ,
                    SourceTableCatalog = case dt.CreateStageTable
                                           when 1 then dt.StageTableCatalog
                                           else dt.SourceTableCatalog
                                         end ,
                    SourceSchemaName = case dt.CreateStageTable
                                         when 1 then dt.StageSchemaName
                                         else dt.SourceSchemaName
                                       end ,
                    dt.SourceTableName ,
                    ssis.GetSourceSelectQuery(null, dt.SourceTableCatalog,
                                              dt.SourceSchemaName,
                                              dt.SourceTableName,
                                              dt.DestinationTableCatalog, 0,
                                              dt.SSISIncrementalLoad) SourceSQLQuery ,
                    case when ISNULL(dt.SourceFilterCondition, '') = ''
                         then ''
                         else 'Where ' + dt.SourceFilterCondition
                    end SourceFilterCondition
		
		-- Stage
                    ,
                    ISNULL(dt.StageTableCatalog, dt.DestinationTableCatalog) as StageTableCatalog ,
                    case when ISNULL(dt.StageFilterCondition, '') = '' then ''
                         else 'Where ' + dt.StageFilterCondition
                    end StageFilterCondition
		-- Destination
                    ,
                    dt.DestinationTableCatalog ,
                    dt.DestinationSchemaName ,
                    dt.DestinationTableName ,
                    dt.DestinationDeleteCondition
		-- SSIS
                    ,
                    dt.SSISPackageName ,
                    dt.SSISPackageGUID ,
                    dt.SSISConfigurationFrameWorkCatalog ,
                    dt.DtsConfigEnvironmentVariableName ,
                    dt.CDCInstanceName ,
                    dt.UseSSISLoggingFrameWork ,
                    dt.SSISIncrementalLoad
		-- MISC
                    ,
                    ssis.GetContainerVariables(dt.SourceTableCatalog,
                                               dt.DestinationTableCatalog,
                                               dt.DestinationTableName,
                                               dt.GroupName) ContainerVariables ,
                    case when dt.DestinationTableCatalog in ( select top 1
                                                              [NormEnvironmentName]
                                                             from
                                                              Metadata.EnvironmentVariables
															  union 
															  select top 1
                                                              [RawEnvironmentName]
                                                             from
                                                              Metadata.EnvironmentVariables
                                                           )
                         then CONCAT(dt.DestinationTableCatalog, dt.GroupName)
                         else dt.DestinationTableCatalog
                    end as BimlType ,
                    UseStageTable = dt.CreateStageTable ,
                    dt.StageSchemaName ,
                    dt.StageTableName ,
                    StageSourceTableCatalog = case dt.CreateStageTable
                                           when 1 then dt.SourceTableCatalog
                                           else null
                                         end ,
                    StageSourceSchemaName = case dt.CreateStageTable
                                              when 1 then dt.SourceSchemaName
                                              else null
                                            end
                  from
                    Metadata.DestinationTable dt
                  where
                    dt.CreateSSISPackage = 1
                    and dt.DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
                    and dt.SourceTableName = ISNULL(@SOURCE_TABLE_NAME,
                                                    dt.SourceTableName)
                    and exists ( select
                                    1
                                 from
                                    Metadata.SplitString(@DESTINATION_SCHEMA_NAMES,
                                                         ',') x
                                 where
                                    x.Item = dt.DestinationSchemaName )
                ) as t1
            ) as t2
        order by
            t2.SSISPackageName;
    end;