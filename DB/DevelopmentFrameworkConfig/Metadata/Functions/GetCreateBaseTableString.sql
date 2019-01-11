-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Returns a string with a create table statement, expressed in t-sql.
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetCreateBaseTableString] (
	@SourceTableCatalog VARCHAR(128)
	,@SourceSchemaName VARCHAR(128)
	,@SourceTableName VARCHAR(128)
	,@SourceServer VARCHAR(128) = NULL
	,@DestinationTableCatalog VARCHAR(128)
	,@DestinationSchemaName VARCHAR(128)
	,@DestinationTableName VARCHAR(128)
	,@CompressionType VARCHAR(50) = 'NONE'
	,@NewTableCatalog VARCHAR(128) = NULL
	,@NewSchemaName VARCHAR(128) = NULL
	,@NewTablename VARCHAR(128) = NULL
	,@IsPartitioned BIT = 0
	,@PartitionSchemeName NVARCHAR(128)
	,@PartitionKeyColumnName NVARCHAR(128)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @CreateString VARCHAR(max)
		,@COLUMN_NAME VARCHAR(100)
		,@DATA_TYPE VARCHAR(100)
		,@CHARACTER_MAXIMUM_LENGTH INT
		,@ORDINAL_POSITION INT
		,@NUMERIC_PRECISION INT
		,@NUMERIC_SCALE INT
		,@ColumnNamePrimaryKey VARCHAR(100)
		,@IS_NULLABLE VARCHAR(3)
		,@ColumnNameNettoColumn VARCHAR(100)
		,@ColumnNameNettoColumnDataType VARCHAR(100)
		,@ColumnNamePrimaryKeyDataType VARCHAR(100)
		,@IsIdentity BIT
		,@TableColumnSpecification NVARCHAR(1000)
		,@TableCatalogName VARCHAR(128)
		,@SchemaName VARCHAR(128)
		,@TableName VARCHAR(128)
		,@DATETIME_PRECISION INT
		,@pk_index_storage_location VARCHAR(128)

	SET @TableCatalogName = CASE 
			WHEN @NewTableCatalog IS NULL
				THEN @DestinationTableCatalog
			ELSE @NewTableCatalog
			END
	SET @SchemaName = CASE 
			WHEN @NewSchemaName IS NULL
				THEN @DestinationSchemaName
			ELSE @NewSchemaName
			END
	SET @TableName = CASE 
			WHEN @NewTableName IS NULL
				THEN @DestinationTableName
			ELSE @NewTableName
			END
	SET @CreateString = 'IF EXISTS (SELECT * FROM ' + @TableCatalogName + '.sys.objects 
				WHERE object_id = OBJECT_ID(N''' + '[' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + ']'') 
					AND type in (N''U''))
					DROP TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + ']' + CHAR(10) + 'CREATE TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + ']('

	IF (
			SELECT COUNT(*)
			FROM [Metadata].[SourceField]
			WHERE TABLE_CATALOG = @SourceTableCatalog
				AND TABLE_SCHEMA = @SourceSchemaName
				AND TABLE_NAME = @SourceTableName
			) < 1
		DECLARE @err AS INT = CAST('Source table has no source fields' AS INT)

	-- Build up the create string from meta data
	DECLARE cColumns CURSOR
	FOR
	SELECT ax.COLUMN_NAME
		,ax.DATA_TYPE
		,ax.CHARACTER_MAXIMUM_LENGTH
		,ax.ORDINAL_POSITION + 100000 AS ORDINAL_POSITION
		,ax.NUMERIC_PRECISION
		,ax.NUMERIC_SCALE
		,IS_NULLABLE = IIF(ax.COLUMN_NAME LIKE '%key' OR ax.COLUMN_NAME LIKE 'Sys%', ax.IS_NULLABLE, 'YES')
		,0 AS IsIdentity
		,NULL AS TableColumnSpecification
		,ax.DATETIME_PRECISION
	FROM [Metadata].[SourceField] AS ax
	LEFT OUTER JOIN [Metadata].[DestinationFieldExtended] e ON ax.DestinationTableCatalog = e.DestinationTableCatalog
		AND ax.COLUMN_NAME = e.COLUMN_NAME
		AND IsNull(e.SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
	WHERE ax.TABLE_NAME = @SourceTableName
		AND ax.TABLE_SCHEMA = @SourceSchemaName
		AND ax.DestinationTableCatalog = @DestinationTableCatalog
		AND e.COLUMN_NAME IS NULL
		AND ax.COLUMN_NAME NOT LIKE 'Checksum%'
		AND ax.TABLE_CATALOG = @SourceTableCatalog
		AND (
			@SourceServer IS NULL
			OR ax.TABLE_SERVER = @SourceServer
			)
	
	UNION
	
	-- Extended columns -> Group "All"
	SELECT [COLUMN_NAME]
		,[DATA_TYPE]
		,[CHARACTER_MAXIMUM_LENGTH]
		,[ORDINAL_POSITION]
		,[NUMERIC_PRECISION]
		,[NUMERIC_SCALE]
		,[IS_NULLABLE]
		,IsIdentity
		,TableColumnSpecification
		,a.DATETIME_PRECISION
	FROM [Metadata].[DestinationFieldExtended] a
	WHERE [DestinationTableCatalog] = isnull(@NewTableCatalog, @DestinationTableCatalog)
		AND IsNull(ApplicableTable, @DestinationTableName) = @DestinationTableName
		AND IsNull(SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
		AND IsNull(GroupName, 'All') = 'All'
	
	UNION
	
	-- Extended columns -> The group extensions for the current table
	SELECT [COLUMN_NAME]
		,[DATA_TYPE]
		,[CHARACTER_MAXIMUM_LENGTH]
		,[ORDINAL_POSITION]
		,[NUMERIC_PRECISION]
		,[NUMERIC_SCALE]
		,[IS_NULLABLE]
		,IsIdentity
		,TableColumnSpecification
		,dfe.DATETIME_PRECISION
	FROM [Metadata].[DestinationFieldExtended] AS dfe
	INNER JOIN [Metadata].DestinationTable AS dt ON dfe.DestinationTableCatalog = dt.DestinationTableCatalog
		--and dfe.GroupName = dt.GroupName
		AND dt.DestinationTableName = @DestinationTableName
		AND dt.GroupName = dfe.GroupName
	WHERE dfe.[DestinationTableCatalog] = @DestinationTableCatalog
		AND IsNull(ApplicableTable, @DestinationTableName) = @DestinationTableName
		AND IsNull(dfe.SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
		AND IsNull(dfe.GroupName, 'All') <> 'All'
	ORDER BY ORDINAL_POSITION

	OPEN cColumns

	FETCH NEXT
	FROM cColumns
	INTO @COLUMN_NAME
		,@DATA_TYPE
		,@CHARACTER_MAXIMUM_LENGTH
		,@ORDINAL_POSITION
		,@NUMERIC_PRECISION
		,@NUMERIC_SCALE
		,@IS_NULLABLE
		,@IsIdentity
		,@TableColumnSpecification
		,@DATETIME_PRECISION

	DECLARE @columnString VARCHAR(max) = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @columnString = @columnString + CHAR(10) + (
				CASE 
					WHEN @ORDINAL_POSITION != 1
						THEN ', '
					ELSE ''
					END
				) + '[' + @COLUMN_NAME + ']' + (
				CASE 
					WHEN @TableColumnSpecification IS NOT NULL
						THEN ' AS ' + @TableColumnSpecification
					ELSE (
							' ' + CASE @DATA_TYPE
								WHEN 'image'
									THEN 'varbinary(max)'
								WHEN 'ntext'
									THEN 'nvarchar(max)'
								WHEN 'text'
									THEN 'varchar(max)'
								WHEN 'timestamp'
									THEN 'varbinary(8)'
								ELSE @DATA_TYPE
								END + (
								CASE 
									WHEN @CHARACTER_MAXIMUM_LENGTH = - 1
										AND @DATA_TYPE NOT LIKE '%text'
										AND @DATA_TYPE NOT LIKE '%image'
										THEN '(max)'
									WHEN @CHARACTER_MAXIMUM_LENGTH IS NOT NULL
										AND @DATA_TYPE NOT LIKE '%text'
										AND @DATA_TYPE NOT LIKE '%image'
										THEN '(' + LTRIM(STR(@CHARACTER_MAXIMUM_LENGTH)) + ')'
									WHEN @NUMERIC_PRECISION IS NOT NULL
										AND @DATA_TYPE NOT LIKE '%int'
										AND @DATA_TYPE NOT LIKE '%money'
										AND @DATA_TYPE NOT LIKE '%float'
										THEN '(' + LTRIM(STR(@NUMERIC_PRECISION)) + ', ' + LTRIM(STR(@NUMERIC_SCALE)) + ')'
									WHEN @DATETIME_PRECISION IS NOT NULL
										AND (
											@DATA_TYPE LIKE 'datetime2'
											OR @DATA_TYPE LIKE 'time'
											)
										THEN '(' + LTRIM(STR(@DATETIME_PRECISION)) + ')'
									ELSE ''
									END
								) + (
								CASE 
									WHEN @IsIdentity = 1
										THEN ' IDENTITY(1,1)'
									ELSE ''
									END
								) + (
								CASE 
									WHEN @IS_NULLABLE = 'NO'
										THEN ' NOT NULL'
									ELSE ' NULL'
									END
								)
							)
					END
				)

		FETCH NEXT
		FROM cColumns
		INTO @COLUMN_NAME
			,@DATA_TYPE
			,@CHARACTER_MAXIMUM_LENGTH
			,@ORDINAL_POSITION
			,@NUMERIC_PRECISION
			,@NUMERIC_SCALE
			,@IS_NULLABLE
			,@IsIdentity
			,@TableColumnSpecification
			,@DATETIME_PRECISION
	END

	CLOSE cColumns

	DEALLOCATE cColumns

	-- Get PK storage location
	SELECT @pk_index_storage_location = max(fp.IndexStorageLocation)
	FROM [Metadata].[TableKeyDefinition] fp
	WHERE TableCatalog = @DestinationTableCatalog
		AND SchemaName = @DestinationSchemaName
		AND TableName = @DestinationTableName
		AND KeyType = 'PK'
		AND fp.IndexStorageLocation != 'DefaultLocation'

	-- added for partitioning
	SET @CreateString = @CreateString + right(@columnString, len(@columnString) - 2) + ')' + (
			CASE 
				WHEN @IsPartitioned = 1
					THEN ' ON ' + @PartitionSchemeName + '(' + @PartitionKeyColumnName + ')'
				WHEN @pk_index_storage_location IS NOT NULL
					THEN ' ON [' + @pk_index_storage_location + ']'
				ELSE ' ON [PRIMARY]'
				END
			) + (
			CASE 
				WHEN @CompressionType <> 'NONE'
					THEN 'WITH (DATA_COMPRESSION = ' + @CompressionType + ')'
				ELSE ''
				END
			)

	RETURN @CreateString
END