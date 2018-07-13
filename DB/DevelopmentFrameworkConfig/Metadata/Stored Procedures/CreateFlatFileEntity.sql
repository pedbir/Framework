CREATE PROC Metadata.CreateFlatFileEntity
    @SourceFileRootFolder VARCHAR(128)
    , @SourceSchemaName VARCHAR(128)
    , @SourceTableName VARCHAR(128)
    , @FilePattern VARCHAR(128)
    , @ColumnNamesInFirstDataRow BIT
    , @HeaderRowsToSkip SMALLINT
    , @DataRowsToSkip SMALLINT
    , @FlatFileType VARCHAR(20)
    , @HeaderRowDelimiter VARCHAR(128)
    , @RowDelimiter VARCHAR(128)
    , @ColumnDelimiter VARCHAR(128)
    , @TextQualifer VARCHAR(5)
    , @IsUnicode BIT
    , @CodePage VARCHAR(128)
    , @FileNameRegExDateTime NVARCHAR(100) = '(\d{4})-(\d{2})-(\d{2}) (\d{2})_(\d{2})_(\d{2})'
    , @FileNameDateTimePattern NVARCHAR(100) = 'yyyy-MM-dd hh_mm_ss'
    , @DestinationDatabaseName VARCHAR(50) = 'DWH_1_Raw'
    , @LinkedServerName VARCHAR(50) = 'localhost'
    , @SourceMetadataDatabaseName VARCHAR(50) = 'Test'
    , @Locale VARCHAR(50) = 'Lcid1033'  -- Lcid1053 Swedish
AS
	/*
	EXEC Metadata.CreateFlatFileEntity                                            
        		@SourceFileRootFolder			=	'C:/DW/se_credit_deposits/'                                          
        		,@SourceSchemaName				=	'Deposit_RawTyped'                                                            
        		,@SourceTableName				=	'rt_SeCreditDeposit_01'                                                 
        		,@FilePattern					=	'*Bluestep Inlåning - Databasereport Daily*.csv'                      
        		,@ColumnNamesInFirstDataRow		=	1                                                                    
        		,@HeaderRowsToSkip				=	4                                                                    
        		,@DataRowsToSkip				=	0                                                                    
        		,@FlatFileType					=	'Delimited'                                                          
        		,@HeaderRowDelimiter			=	'{CR}{LF}'                                                           
        		,@RowDelimiter					=	'{CR}{LF}'                                                           
        		,@ColumnDelimiter				=	','                                                                  
        		,@TextQualifer					=	'\'                                                                 
        		,@IsUnicode						=	0                                                                    
        		,@CodePage						=	'1252'                                                               
        		,@DestinationDatabaseName		=	'DWH_1_Raw'                                                          
        		,@SourceMetadataDatabaseName	=	'DWH_1_Raw'                                                               
        		,@Locale	                    =	'Lcid1033'                                                           
        		,@FileNameRegExDateTime         =	'(\d{4})-(\d{2})-(\d{2}) (\d{2})_(\d{2})_(\d{2})'              
        		,@FileNameDateTimePattern	    =	'yyyy-MM-dd hh_mm_ss'                                                
        		,@LinkedServerName				=	'localhost'        
	Locale
	https://www.varigence.com/Documentation/Api/Enum/Language
	*/

SET NOCOUNT ON;

BEGIN TRANSACTION;
BEGIN TRY


	DECLARE @ExecProcAnnotation NVARCHAR(MAX) = 'EXEC Metadata.CreateFlatFileEntity 
		@SourceFileRootFolder			=	'''+CAST(@SourceFileRootFolder			as nvarchar(50)) +'''  
		,@SourceSchemaName				=	'''+CAST(@SourceSchemaName				as nvarchar(50)) +'''  
		,@SourceTableName				=	'''+CAST(@SourceTableName				as nvarchar(50)) +'''  
		,@FilePattern					=	'''+CAST(@FilePattern					as nvarchar(50)) +'''  
		,@ColumnNamesInFirstDataRow		=	  '+CAST(@ColumnNamesInFirstDataRow		as nvarchar(50)) +'	   
		,@HeaderRowsToSkip				=	  '+CAST(@HeaderRowsToSkip				as nvarchar(50)) +'	   
		,@DataRowsToSkip				=	  '+CAST(@DataRowsToSkip				as nvarchar(50)) +'	   
		,@FlatFileType					=	'''+CAST(@FlatFileType					as nvarchar(50)) +'''  
		,@HeaderRowDelimiter			=	'''+CAST(@HeaderRowDelimiter			as nvarchar(50)) +'''  
		,@RowDelimiter					=	'''+CAST(@RowDelimiter					as nvarchar(50)) +'''  
		,@ColumnDelimiter				=	'''+CAST(@ColumnDelimiter				as nvarchar(50)) +'''  
		,@TextQualifer					=	'''+CAST(@TextQualifer					as nvarchar(50)) +'''  
		,@IsUnicode						=	  '+CAST(@IsUnicode						as nvarchar(50)) +'	   
		,@CodePage						=	'''+CAST(@CodePage						as nvarchar(50)) +'''  
		,@DestinationDatabaseName		=	'''+CAST(@DestinationDatabaseName		as nvarchar(50)) +'''  
		,@LinkedServerName				=	'''+CAST(@LinkedServerName				as nvarchar(50)) +'''  
		,@SourceMetadataDatabaseName	=	'''+CAST(@SourceMetadataDatabaseName	as nvarchar(50)) +'''  
		,@Locale						=	'''+CAST(@Locale						as nvarchar(50)) +'''  
		,@FileNameRegExDateTime			=	'''+CAST(@FileNameRegExDateTime			as nvarchar(50)) +'''  
		,@FileNameDateTimePattern		=	'''+CAST(@FileNameDateTimePattern		as nvarchar(50)) +'''  

	'	
	PRINT '-----------------------------------------' + CHAR(13) + '--Run Proc' + CHAR(13) + '-----------------------------------------' 
	PRINT @ExecProcAnnotation

	SELECT @SourceFileRootFolder = REPLACE(@SourceFileRootFolder, '/', '\') + IIF(RIGHT(REPLACE(@SourceFileRootFolder, '/', '\'), 1) = '\', '', '\' )

	DECLARE @DestinationTableName VARCHAR(250) = 'rt_' + REPLACE(@SourceTableName, 'rt_', '')
		,	@DestinationSchemaName VARCHAR(250) = REPLACE(@SourceSchemaName, '_RawTyped', '') + '_RawTyped'
		,   @SourceSchemaNameWitoutSuffix VARCHAR(250)= REPLACE(@SourceSchemaName, '_RawTyped', '')
		,   @SourceTableNameWithoutPrefix VARCHAR(250)=  REPLACE(@SourceTableName, 'rt_', '')
		,	@SQLString VARCHAR(MAX)

	DECLARE @DestinationTableFullNameWithBrackets VARCHAR(250) = QUOTENAME(@DestinationSchemaName) + '.' + QUOTENAME(@DestinationTableName)
		,	@DestinationViewFullNameWithBrackets VARCHAR(250) = QUOTENAME(@DestinationSchemaName) + '.' + QUOTENAME('v' + @DestinationTableName)

	-- Create metadata temp table for generating create table script
	SELECT * INTO #SourceMetadata FROM INFORMATION_SCHEMA.COLUMNS c WHERE 1=0
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@SourceMetadataDatabaseName+'.dbo.sp_executesql N''SELECT * FROM INFORMATION_SCHEMA.Columns WHERE COLUMN_NAME NOT LIKE ''''sys%'''' AND TABLE_SCHEMA = '''''+@SourceSchemaName+''''''+'AND TABLE_NAME = '''''+@SourceTableName+''''''+'''';	
	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Create #SourceMetadata table' + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	INSERT INTO #SourceMetadata EXECUTE (@SQLString);
	ALTER TABLE #SourceMetadata DROP COLUMN TABLE_CATALOG
	ALTER TABLE #SourceMetadata DROP COLUMN TABLE_SCHEMA
	ALTER TABLE #SourceMetadata DROP COLUMN TABLE_NAME
	SELECT * INTO #CreateTableMetadata FROM #SourceMetadata sm
	
	-- Create #index_columns table
	CREATE TABLE #index_columns(object_id int,index_id int, is_descending_key bit, is_included_column bit ,Columnname sysname NULL)  

	DECLARE @CreateIndexSQL NVARCHAR(max)=  
	'SELECT	ic.object_id
					,ic.index_id
					,ic.is_descending_key
					,ic.is_included_column
					,Columnname = c.name
	FROM	sys.index_columns ic WITH (NOWAIT)
	INNER JOIN sys.columns c WITH (NOWAIT) ON ic.object_id			= c.object_id AND ic.column_id = c.column_id
	INNER JOIN sys.key_constraints k WITH (NOWAIT) ON ic.object_id			= k.parent_object_id AND ic.index_id = k.unique_index_id
	WHERE ic.object_id = (
	SELECT	TOP 1 o.object_id
	FROM	sys.objects o WITH (NOWAIT)
	JOIN sys.schemas s WITH (NOWAIT) ON o.schema_id = s.schema_id
	WHERE s.name  = '''''+@SourceSchemaName+'''''
				AND o.name = '''''+@DestinationTableName+'''''
				AND o.type = ''''U''''
				AND o.is_ms_shipped = 0
				)
	AND c.name NOT LIKE ''''Sys%'''''
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@SourceMetadataDatabaseName+'.dbo.sp_executesql N'''+@CreateIndexSQL+'''';
	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Create #index_columns table' + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 

	INSERT INTO #index_columns EXECUTE (@SQLString);
	INSERT INTO #index_columns SELECT TOP 1 ic.object_id,ic.index_id, 1 AS is_descending_key,ic.is_included_column ,'SysSrcGenerationDateTime' AS Columnname FROM #index_columns ic


	INSERT INTO #CreateTableMetadata 
	VALUES
	( N'SysFileName'				, -100, NULL, 'NO', N'nvarchar', 250, 500, NULL, NULL, NULL, NULL, NULL, NULL, N'UNICODE', NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysDatetimeInsertedUTC'		, -90, NULL, 'NO', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysDatetimeUpdatedUTC'		, -80, NULL, 'YES', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysDatetimeDeletedUTC'		, -70, NULL, 'YES', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysSrcGenerationDateTime'	, -60, NULL, 'NO', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysModifiedUTC'				, -50, NULL, 'NO', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
	( N'SysExecutionLog_key'		, -40, NULL, 'NO', N'int', NULL, NULL, 10, 10, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL )
	
	-- Drop table and view and create schema	
	DECLARE @CreateTableSql NVARCHAR(max) = 
	'IF EXISTS (SELECT * from sys.objects WHERE object_id = OBJECT_ID(N'''''+ @DestinationTableFullNameWithBrackets +''''') AND type IN (N''''U''''))
	DROP TABLE '+ @DestinationTableFullNameWithBrackets + ''
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';
	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Drop table ' + @DestinationTableFullNameWithBrackets + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	EXECUTE (@SQLString);

	SET @CreateTableSql  =	N'IF EXISTS (SELECT * from sys.objects WHERE object_id = OBJECT_ID(N'''''+ @DestinationViewFullNameWithBrackets +N''''') AND type IN (N''''V''''))
	DROP VIEW '+ @DestinationViewFullNameWithBrackets 	
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';
	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Drop destination view ' + @DestinationViewFullNameWithBrackets  + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	EXECUTE (@SQLString);
	
	SET @CreateTableSql =N'IF NOT EXISTS (SELECT * from sys.schemas s WHERE name = N'''''+  @DestinationSchemaName +''''')
	EXEC(''''CREATE SCHEMA '+ @DestinationSchemaName+ ''''')'	
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';
	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Create Schema ' + @DestinationSchemaName  + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	EXECUTE (@SQLString);	
	
	-- Create Table, View and Index
	SET @CreateTableSql  = N'CREATE TABLE ' + @DestinationTableFullNameWithBrackets + N' (' +
		STUFF((
	SELECT  ',['+m.COLUMN_NAME+'] ' + 
			UPPER(data_type) + case data_type
				when 'sql_variant' then ''
				when 'text' then ''
				when 'ntext' then ''
				when 'xml' then ''
				when 'decimal' then '(' + cast(numeric_precision as varchar) + ', ' + cast(numeric_scale as varchar) + ')'
				WHEN 'datetime2' THEN '(' + cast(m.DATETIME_PRECISION as varchar)  + ')'
				else coalesce('('+case when character_maximum_length = -1 then 'MAX' else cast(character_maximum_length as varchar) end +')','') end 
			+ ' ' + case when IS_NULLABLE = 'No' then 'NOT ' else '' end  + 'NULL '
	FROM #CreateTableMetadata m
	ORDER BY m.ORDINAL_POSITION
	FOR XML PATH('')), 1,1,'') + CHAR(13) +
	ISNULL((SELECT CHAR(9) + ', CONSTRAINT [PK_' +@SourceSchemaNameWitoutSuffix  + @SourceTableNameWithoutPrefix +'] PRIMARY KEY (' + 
						(SELECT STUFF((
							 SELECT ', [' + i.Columnname + '] ' + CASE WHEN i.is_descending_key = 1 THEN 'DESC' ELSE 'ASC' END
							 FROM #index_columns i						                        
							 FOR XML PATH(N''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, ''))
				+ ')' + CHAR(13)), '')+ N')' + CHAR(13) + 
	'CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_'+@SourceSchemaNameWitoutSuffix  + @SourceTableNameWithoutPrefix +'] ON '+@DestinationTableFullNameWithBrackets+'([SysModifiedUTC] ASC)' + CHAR(13) + 
	'CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_'+@SourceSchemaNameWitoutSuffix + @SourceTableNameWithoutPrefix +'] ON '+@DestinationTableFullNameWithBrackets+'([SysFileName] ASC)' 

	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Create table and index ' + @DestinationTableFullNameWithBrackets + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	EXECUTE (@SQLString);	

	SET @CreateTableSql = N'CREATE VIEW '+@DestinationViewFullNameWithBrackets + CHAR(13) + N'AS' + CHAR(13) + N'SELECT ' + STUFF((SELECT  ',['+m.COLUMN_NAME+'] ' FROM #CreateTableMetadata m ORDER BY m.ORDINAL_POSITION FOR XML PATH('')), 1,1,'') + ' FROM    (SELECT * '+ ISNULL(', _isFirst = LAG(0,1,1) OVER (PARTITION BY ' + STUFF((SELECT ', [' + i.Columnname + '] ' FROM #index_columns i WHERE i.Columnname NOT LIKE 'Sys%' FOR XML PATH(N''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') + ' ORDER BY [SysSrcGenerationDateTime] DESC)', ', _isFirst = 1') +'  FROM '+ @DestinationTableFullNameWithBrackets + ') t WHERE t._isFirst = 1' 
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

	

	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Create View ' + @DestinationViewFullNameWithBrackets + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 
	EXECUTE (@SQLString);

	SET @CreateTableSql = N'
	IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceSchemaName + N'_ArchiveFolderPath'''')
		DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceSchemaName + N'_ArchiveFolderPath''''
	IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceSchemaName + N'_SourceFolderPath'''')
		DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceSchemaName + N'_SourceFolderPath''''
	IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceSchemaName + N'_ErrorFolderPath'''')
		DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceSchemaName + N'_ErrorFolderPath''''

	INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceSchemaName+N'_ArchiveFolderPath'''',N'''''+@SourceFileRootFolder+N'Archive'''',N''''' + N'\Package.Variables[User::'+ @SourceSchemaName+N'_ArchiveFolderPath].Properties[Value]' + N''''',N''''String'''')
	INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceSchemaName+N'_SourceFolderPath'''',N'''''+@SourceFileRootFolder+N'Data'''',N''''' + N'\Package.Variables[User::'+ @SourceSchemaName+N'_SourceFolderPath].Properties[Value]' + N''''',N''''String'''')
	INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceSchemaName+N'_ErrorFolderPath'''',N'''''+@SourceFileRootFolder+N'Error'''',N''''' + N'\Package.Variables[User::'+ @SourceSchemaName+N'_ErrorFolderPath].Properties[Value]' + N''''',N''''String'''')
	'
	SET @SQLString ='EXECUTE '+@LinkedServerName+'.DWH_0_Admin.dbo.sp_executesql N'''+@CreateTableSql+'''';

	PRINT CHAR(13) + '-----------------------------------------' + CHAR(13) + '-- Insert SSISConfigurations' + CHAR(13) + '-----------------------------------------' 
	PRINT @SQLString 	
	EXECUTE (@SQLString);

	SELECT	sm.COLUMN_NAME

					,BIML_DATATYPE					= dtt.Biml
					,LENGHT							= ISNULL(sm.CHARACTER_MAXIMUM_LENGTH, 0)
					,NUMERIC_PRECISION				= ISNULL(sm.NUMERIC_PRECISION, 0)
					,NUMERIC_SCALE					= ISNULL(sm.NUMERIC_SCALE, 0)
					,sm.ORDINAL_POSITION
					,DELIMITER						= LEAD(@ColumnDelimiter, 1, @RowDelimiter) OVER (ORDER BY sm.ORDINAL_POSITION)
					,SOURCETABLECATALOG				= @SourceFileRootFolder
					,SOURCESCHEMANAME				= @SourceSchemaName
					,SourceTableName				= @SourceTableName
					,FilePattern					= @FilePattern
					,ColumnNamesInFirstDataRow		= @ColumnNamesInFirstDataRow
					,HeaderRowsToSkip				= @HeaderRowsToSkip
					,DataRowsToSkip					= @DataRowsToSkip
					,FlatFileType					= @FlatFileType
					,HeaderRowDelimiter				= @HeaderRowDelimiter
					,RowDelimiter					= @RowDelimiter
					,ColumnDelimiter				= @ColumnDelimiter
					,TextQualifer					= IIF(@TextQualifer = '"', '&quot;', @TextQualifer)
					,IsUnicode						= @IsUnicode
					,CodePage						= @CodePage
					,DestinationFullTableName		= @DestinationTableFullNameWithBrackets
					,DestinationFullViewName		= @DestinationViewFullNameWithBrackets
					,DestinationDatabaseName		= @DestinationDatabaseName
					,Locale							= @Locale
					,FileNameRegExDateTime			= @FileNameRegExDateTime
					,FileNameDateTimePattern		= @FileNameDateTimePattern
					,ExecProc						= @ExecProcAnnotation
					,DestinationSchemaName			= @DestinationSchemaName
					,DestinationTableName			= @DestinationTableName
	FROM	#SourceMetadata										sm
	LEFT JOIN Metadata.DataTypeTranslation dtt ON dtt.SQLServer = sm.DATA_TYPE
	ORDER BY sm.ORDINAL_POSITION


END TRY
BEGIN CATCH
    SELECT 
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;


    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;

IF @@TRANCOUNT > 0
    COMMIT TRANSACTION;