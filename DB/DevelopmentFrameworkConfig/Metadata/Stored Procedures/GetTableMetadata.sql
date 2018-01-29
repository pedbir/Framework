-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Gets metadata for given database
-- Example:	
-- 		EXECUTE [DevelopmentFrameworkConfig].[Metadata].[GetTableMetadata] @TABLE_CATALOG = 'DW'
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[GetTableMetadata] @TABLE_CATALOG VARCHAR(max)
	,@TABLE_SCHEMA VARCHAR(max) = NULL
	,@TABLE_NAME VARCHAR(max) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQLScript VARCHAR(max)

	SET @SQLScript = 
		'select	isct.TABLE_TYPE as Table_Type
			, isc.TABLE_SCHEMA as Table_Schema
			, isc.TABLE_NAME as Table_Name
			, isc.COLUMN_NAME as Column_Name
			, dn.DescriptionDefinition as ColumnDisplayName
			, PrimaryKey = case
								when pk.ColumnName is not null then ''YES''
								else ''NO''
							end
			, fk.REFERENCED_TABLE_NAME as ForeignKeyTo
			, xp.DescriptionDefinition as Column_Description
			, isc.DATA_TYPE 
				+ ISNULL(''('' + cast(CHARACTER_MAXIMUM_LENGTH as varchar(10)) + '')'', '''') 
				+ ISNULL(''('' + cast(NUMERIC_PRECISION as varchar(10)) + '', '' + cast(case when isc.DATA_TYPE like ''%int%'' then null else NUMERIC_SCALE end as varchar(10)) + '')'', '''') 			
				as Data_Type
			, Data_Type_Extension = (case
										when isc.IS_NULLABLE = ''YES'' then ''NULL''
										else ''NOT NULL''
									end) + ISNULL('' DEFAULT'' + isc.COLUMN_DEFAULT, '''')
			, ev.DescriptionDefinition as Column_Example_Value
			, ss.DescriptionDefinition as SourceSystem
			, ssc.DescriptionDefinition as SourceSchema
			, son.DescriptionDefinition as SourceObjectName
			, sfn.DescriptionDefinition as SourceFieldName
			, sdt.DescriptionDefinition as SourceDataType
			, etl.DescriptionDefinition as ETLRules
			, com.DescriptionDefinition as Comment
	from ' 
		+ @TABLE_CATALOG + '.INFORMATION_SCHEMA.COLUMNS as isc
		inner join ' + @TABLE_CATALOG + '.INFORMATION_SCHEMA.TABLES isct on isc.TABLE_CATALOG = isct.TABLE_CATALOG
										and isc.TABLE_SCHEMA = isct.TABLE_SCHEMA
										and isc.TABLE_NAME = isct.TABLE_NAME
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + 
		'.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as xp on isc.COLUMN_NAME = xp.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = xp.TableName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = xp.SchemaName collate Latin1_General_CI_AI
									and xp.DescriptionType = ''ColumnDescription''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + 
		'.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as ev on isc.COLUMN_NAME = ev.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = ev.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = ev.TableName collate Latin1_General_CI_AI
									and ev.DescriptionType = ''ExampleValue''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + 
		'.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as dn on isc.COLUMN_NAME = dn.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = dn.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = dn.TableName collate Latin1_General_CI_AI
									and dn.DescriptionType = ''DisplayName''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + 
		'.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as ss on isc.COLUMN_NAME = ss.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = ss.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = ss.TableName collate Latin1_General_CI_AI
									and ss.DescriptionType = ''SourceSystem''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG 
		+ '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + 
		'.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as ssc on isc.COLUMN_NAME = ssc.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = ssc.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = ssc.TableName collate Latin1_General_CI_AI
									and ssc.DescriptionType = ''SourceSchema''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + 
		'.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as son on isc.COLUMN_NAME = son.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = son.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = son.TableName collate Latin1_General_CI_AI
									and son.DescriptionType = ''SourceObjectName''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + 
		'.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as sfn on isc.COLUMN_NAME = sfn.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = sfn.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = sfn.TableName collate Latin1_General_CI_AI
									and sfn.DescriptionType = ''SourceFieldName''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + 
		'.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as sdt on isc.COLUMN_NAME = sdt.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = sdt.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = sdt.TableName collate Latin1_General_CI_AI
									and sdt.DescriptionType = ''SourceDataType''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
							FROM ' + 
		@TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + 
		'.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as etl on isc.COLUMN_NAME = etl.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = etl.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = etl.TableName collate Latin1_General_CI_AI
									and etl.DescriptionType = ''ETLRules''
		left outer join (	SELECT SCH.name AS SchemaName
								,TBL.name AS TableName
								,COL.name AS ColumnName
								,SEP.name AS DescriptionType
								,SEP.value AS DescriptionDefinition
								, TBL.*
							FROM ' + @TABLE_CATALOG + '.sys.extended_properties SEP
								INNER JOIN ' + @TABLE_CATALOG + '.sys.columns COL ON SEP.major_id = COL.object_id 
										AND SEP.minor_id = COL.column_id 
								INNER JOIN (select object_id, name, schema_id from ' + @TABLE_CATALOG + '.sys.tables
											union select object_id, name, schema_id from ' + @TABLE_CATALOG + 
		'.sys.views
											) TBL ON SEP.major_id = TBL.object_id 
								INNER JOIN ' + @TABLE_CATALOG + '.sys.schemas SCH ON TBL.schema_id = SCH.schema_id
							WHERE SEP.class = 1 AND (SEP.value <> ''1'' AND SEP.value <> 1)
						) as com on isc.COLUMN_NAME = com.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_SCHEMA = com.SchemaName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = com.TableName collate Latin1_General_CI_AI
									and com.DescriptionType = ''Comment''
		left outer join (	select ccu.COLUMN_NAME as ColumnName, ccu.TABLE_NAME as TableName
							FROM ' + @TABLE_CATALOG + '.INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc         
								inner join ' + @TABLE_CATALOG + '.INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu ON tc.CONSTRAINT_NAME = ccu.Constraint_name
								inner join ' + @TABLE_CATALOG + 
		'.INFORMATION_SCHEMA.COLUMNS col on  ccu.TABLE_CATALOG = col.TABLE_CATALOG
																			and ccu.TABLE_SCHEMA = col.TABLE_SCHEMA
																			and ccu.TABLE_NAME = col.TABLE_NAME
																			and ccu.COLUMN_NAME = col.COLUMN_NAME

							WHERE tc.CONSTRAINT_TYPE = ''Primary Key'') as pk on isc.COLUMN_NAME = pk.ColumnName collate Latin1_General_CI_AI
									and isc.TABLE_NAME = pk.TableName collate Latin1_General_CI_AI
		left outer join (SELECT KCU1.TABLE_NAME AS FK_TABLE_NAME      
								,KCU1.COLUMN_NAME AS FK_COLUMN_NAME      
								,KCU1.ORDINAL_POSITION AS FK_ORDINAL_POSITION      
								,KCU2.CONSTRAINT_NAME AS REFERENCED_CONSTRAINT_NAME      
								,KCU2.TABLE_NAME AS REFERENCED_TABLE_NAME      
								,KCU2.COLUMN_NAME AS REFERENCED_COLUMN_NAME      
								,KCU2.ORDINAL_POSITION AS REFERENCED_ORDINAL_POSITION  
						FROM ' + @TABLE_CATALOG + '.INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC   
							LEFT JOIN ' + @TABLE_CATALOG + 
		'.INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG       
										AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA      
										AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME   
							LEFT JOIN ' + @TABLE_CATALOG + '.INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU2 ON KCU2.CONSTRAINT_CATALOG = RC.UNIQUE_CONSTRAINT_CATALOG       
										AND KCU2.CONSTRAINT_SCHEMA = RC.UNIQUE_CONSTRAINT_SCHEMA      
										AND KCU2.CONSTRAINT_NAME = RC.UNIQUE_CONSTRAINT_NAME      
										AND KCU2.ORDINAL_POSITION = KCU1.ORDINAL_POSITION ) as fk on isc.COLUMN_NAME = fk.FK_COLUMN_NAME collate Latin1_General_CI_AI
																			and isc.TABLE_NAME = fk.FK_TABLE_NAME collate Latin1_General_CI_AI
	where	isc.TABLE_CATALOG = ''' + @TABLE_CATALOG + '''
			and isc.TABLE_SCHEMA = ' + isnull('''' + @TABLE_SCHEMA + '''', 'isc.TABLE_SCHEMA') + '
			and isc.TABLE_NAME = ' + isnull('''' + @TABLE_NAME + '''', 'isc.TABLE_NAME') + 
		'
	order by isc.TABLE_SCHEMA, isc.TABLE_NAME, isc.ORDINAL_POSITION
	'

	EXECUTE (@SQLScript)
END