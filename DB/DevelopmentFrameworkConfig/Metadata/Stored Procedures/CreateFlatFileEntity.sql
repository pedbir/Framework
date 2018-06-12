
CREATE PROC Metadata.CreateFlatFileEntity
	@SourceFileRootFolder VARCHAR(128)
	,@SourceFileType VARCHAR(128)
	,@SourceTableName VARCHAR(128)
	,@FilePattern VARCHAR(128)
	,@ColumnNamesInFirstDataRow BIT
	,@HeaderRowsToSkip SMALLINT
	,@DataRowsToSkip SMALLINT
	,@FlatFileType VARCHAR(20)
	,@HeaderRowDelimiter VARCHAR(128)
	,@RowDelimiter VARCHAR(128)
	,@ColumnDelimiter VARCHAR(128)
	,@TextQualifer VARCHAR(5)
	,@IsUnicode BIT
	,@CodePage VARCHAR(128)
	,@DestinationDatabaseName VARCHAR(50) = 'DWH_1_Raw'
	,@LinkedServerName VARCHAR(50) = 'localhost'
	,@SourceMetadataDatabaseName VARCHAR(50) = 'Test'
	,@Locale VARCHAR(50) = 'Lcid1033' -- Lcid1053 Swedish
AS
SET NOCOUNT ON;
/*
EXEC Metadata.CreateFlatFileEntity 
	@SourceFileRootFolder			=	'C:\DW\Manual\'
	,@SourceFileType				=	'Manual'
	,@SourceTableName				=	'Package_01'
	,@FilePattern					=	'Package_01*.csv'
	,@ColumnNamesInFirstDataRow		=	1
	,@HeaderRowsToSkip				=	0
	,@DataRowsToSkip				=	0
	,@FlatFileType					=	'Delimited'
	,@HeaderRowDelimiter			=	'{CR}{LF}'
	,@RowDelimiter					=	'{CR}{LF}'
	,@ColumnDelimiter				=	','
	,@TextQualifer					=	'"'
	,@IsUnicode						=	0
	,@CodePage						=	'1252'
	,@DestinationDatabaseName		=	'DWH_1_Raw'
	,@LinkedServerName				=	'localhost'
	,@SourceMetadataDatabaseName	=	'Test'
	,@Locale VARCHAR(50) = 'Lcid1033' 

Locale
https://www.varigence.com/Documentation/Api/Enum/Language
*/

SET @SourceFileRootFolder = REPLACE(@SourceFileRootFolder, '/', '\')

DECLARE @DestinationTableName VARCHAR(50) = QUOTENAME(REPLACE(@SourceFileType, '_RawTyped', '') + '_RawTyped') + '.' + QUOTENAME('rt_' + @SourceTableName)
DECLARE @DestinationViewName VARCHAR(50) = QUOTENAME(REPLACE(@SourceFileType, '_RawTyped', '') + '_RawTyped') + '.' + QUOTENAME('vrt_' + @SourceTableName)
SELECT * INTO #SourceMetadata FROM INFORMATION_SCHEMA.COLUMNS c WHERE 1=0

DECLARE @SQLString VARCHAR(MAX) ='EXECUTE '+@LinkedServerName+'.'+@SourceMetadataDatabaseName+'.dbo.sp_executesql
		N''SELECT * FROM INFORMATION_SCHEMA.Columns WHERE COLUMN_NAME NOT LIKE ''''sys%'''' AND TABLE_SCHEMA = '''''+@SourceFileType+''''''+'AND TABLE_NAME = '''''+@SourceTableName+''''''+'''';
PRINT @SQLString;
INSERT INTO #SourceMetadata EXECUTE (@SQLString);

ALTER TABLE #SourceMetadata DROP COLUMN TABLE_CATALOG
ALTER TABLE #SourceMetadata DROP COLUMN TABLE_SCHEMA
ALTER TABLE #SourceMetadata DROP COLUMN TABLE_NAME


SELECT * INTO #CreateTableMetadata FROM #SourceMetadata sm
UPDATE #CreateTableMetadata SET ORDINAL_POSITION = ORDINAL_POSITION + 6

INSERT INTO #CreateTableMetadata 
VALUES
( N'SysFileName', 1, NULL, 'NO', N'nvarchar', 250, 500, NULL, NULL, NULL, NULL, NULL, NULL, N'UNICODE', NULL, NULL, N'SQL_Latin1_General_CP1_CI_AS', NULL, NULL, NULL ), 
( N'SysDatetimeInsertedUTC', 2, NULL, 'NO', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
( N'SysDatetimeUpdatedUTC', 3, NULL, 'YES', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
( N'SysDatetimeDeletedUTC', 4, NULL, 'YES', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
( N'SysModifiedUTC', 5, NULL, 'NO', N'datetime2', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL ), 
( N'SysExecutionLog_key', 6, NULL, 'NO', N'int', NULL, NULL, 10, 10, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL )


DECLARE @CreateTableSql NVARCHAR(max) = 
'IF EXISTS (SELECT * from sys.objects WHERE object_id = OBJECT_ID(N'''''+ @DestinationTableName +''''') AND type IN (N''''U''''))
DROP TABLE '+ @DestinationTableName + '
'

SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

PRINT @SQLString 
EXECUTE (@SQLString);

SET @CreateTableSql = 
N'IF NOT EXISTS (SELECT * from sys.schemas s WHERE name = N'''''+ @SourceFileType +N'_RawTyped'''')
BEGIN
 EXEC(''''CREATE SCHEMA '+ @SourceFileType + N'_RawTyped'''')
END 
'

SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

PRINT @SQLString 
EXECUTE (@SQLString);

SET @CreateTableSql  = N'CREATE TABLE ' + @DestinationTableName + N' (' +
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
FOR XML PATH('')), 1,1,'') + N')'

SET @CreateTableSql = @CreateTableSql + CHAR(13) +
N'IF EXISTS (SELECT * from sys.objects WHERE object_id = OBJECT_ID(N'''''+ @DestinationViewName +N''''') AND type IN (N''''V''''))
DROP VIEW '+ @DestinationViewName + N'
'

SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

PRINT @SQLString 
EXECUTE (@SQLString);

SET @CreateTableSql = N'CREATE VIEW '+@DestinationViewName + CHAR(13) + N'AS' + CHAR(13) + N'SELECT * FROM '+ @DestinationTableName + N''
SET @SQLString ='EXECUTE '+@LinkedServerName+'.'+@DestinationDatabaseName+'.dbo.sp_executesql N'''+@CreateTableSql+'''';

PRINT @SQLString 
EXECUTE (@SQLString);

SET @CreateTableSql = N'
IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceFileType + N'_ArchiveFolderPath'''')
	DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceFileType + N'_ArchiveFolderPath''''
IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceFileType + N'_SourceFolderPath'''')
	DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceFileType + N'_SourceFolderPath''''
IF EXISTS (SELECT TOP 1 * FROM dbo.SSISConfigurations sc WHERE sc.ConfigurationFilter = '''''+ @SourceFileType + N'_ErrorFolderPath'''')
	DELETE dbo.SSISConfigurations WHERE ConfigurationFilter = '''''+ @SourceFileType + N'_ErrorFolderPath''''

INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceFileType+N'_ArchiveFolderPath'''',N'''''+@SourceFileRootFolder+N'Archive'''',N''''' + N'\Package.Variables[User::'+ @SourceFileType+N'_ArchiveFolderPath].Properties[Value]' + N''''',N''''String'''')
INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceFileType+N'_SourceFolderPath'''',N'''''+@SourceFileRootFolder+N'Source'''',N''''' + N'\Package.Variables[User::'+ @SourceFileType+N'_SourceFolderPath].Properties[Value]' + N''''',N''''String'''')
INSERT INTO dbo.SSISConfigurations (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType) VALUES (N'''''+@SourceFileType+N'_ErrorFolderPath'''',N'''''+@SourceFileRootFolder+N'Error'''',N''''' + N'\Package.Variables[User::'+ @SourceFileType+N'_ErrorFolderPath].Properties[Value]' + N''''',N''''String'''')
'
SET @SQLString ='EXECUTE '+@LinkedServerName+'.DWH_0_Admin.dbo.sp_executesql N'''+@CreateTableSql+'''';

PRINT @SQLString 
EXEC (@SQLString)

SELECT	sm.COLUMN_NAME

				,BIML_DATATYPE					= dtt.Biml
				,LENGHT							= ISNULL(sm.CHARACTER_MAXIMUM_LENGTH, 0)
				,NUMERIC_PRECISION				= ISNULL(sm.NUMERIC_PRECISION, 0)
				,NUMERIC_SCALE					= ISNULL(sm.NUMERIC_SCALE, 0)
				,sm.ORDINAL_POSITION
				,DELIMITER						= LEAD(@ColumnDelimiter, 1, @RowDelimiter) OVER (ORDER BY sm.ORDINAL_POSITION)
				,SOURCETABLECATALOG				= @SourceFileRootFolder
				,SOURCESCHEMANAME				= @SourceFileType
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
				,DestinationTableName			= @DestinationTableName
				,DestinationViewName			= @DestinationViewName
				,DestinationDatabaseName		= @DestinationDatabaseName
				,Locale							= @Locale
FROM	#SourceMetadata										sm
LEFT JOIN Metadata.DataTypeTranslation dtt ON dtt.SQLServer = sm.DATA_TYPE
ORDER BY sm.ORDINAL_POSITION