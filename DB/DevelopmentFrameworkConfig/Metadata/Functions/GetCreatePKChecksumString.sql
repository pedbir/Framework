-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetCreatePKChecksumString] (
	@SourceTableCatalog VARCHAR(128)
	,@SourceSchemaName VARCHAR(128)
	,@SourceTableName VARCHAR(128)
	,@DestinationTableCatalog VARCHAR(128)
	,@DestinationSchemaName VARCHAR(128)
	,@DestinationTableName VARCHAR(128)
	,@CreateCheckSumColumns BIT
	,@NewTableCatalog VARCHAR(128) = NULL
	,@NewSchemaName VARCHAR(128) = NULL
	,@NewTablename VARCHAR(128) = NULL
	,@IsPartitioned BIT = 0
	,@PartitionSchemeName NVARCHAR(128)
	,@PartitionKeyColumnName NVARCHAR(128)
	,@CompressionType NVARCHAR(50)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @CreateString VARCHAR(max) = ''
		,@COLUMN_NAME VARCHAR(100)
		,@DATA_TYPE VARCHAR(100)
		,@CHARACTER_MAXIMUM_LENGTH INT
		,@PrimaryKeyString VARCHAR(max)
		,@ChecksumPrimaryKeyString VARCHAR(max)
		,@ChecksumAllNettoColumns VARCHAR(max)
		,@ColumnNamePrimaryKey VARCHAR(100)
		,@ColumnNameNettoColumn VARCHAR(100)
		,@ColumnNameNettoColumnDataType VARCHAR(100)
		,@ColumnNamePrimaryKeyDataType VARCHAR(100)
		,@TableCatalogName VARCHAR(128)
		,@SchemaName VARCHAR(128)
		,@TableName VARCHAR(128)
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

	-- Create "Primary Keys" and "Checksum column" on the newly created table
	DECLARE cPrimaryKeyCursor CURSOR
	FOR
	SELECT COLUMN_NAME
		,DATA_TYPE
	FROM [Metadata].[TableKeyDefinition]
	WHERE TableCatalog = @DestinationTableCatalog
		AND SchemaName = @DestinationSchemaName
		AND TableName = @DestinationTableName
		AND KeyType = 'PK'
	ORDER BY KeyColumnOrder

	DECLARE @NrOfPrimaryKeyColumns INT

	SET @PrimaryKeyString = 'ALTER TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + '] ADD CONSTRAINT
											PK_' + @SchemaName + '_' + @TableName + ' PRIMARY KEY ' + (
			CASE 
				WHEN @IsPartitioned = 1
					THEN 'CLUSTERED'
				ELSE 'CLUSTERED'
				END
			) + ' 
											('
	SET @ChecksumPrimaryKeyString = 'ALTER TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + '] ADD
										ChecksumPrimaryKey  AS CONVERT(VARCHAR(40), HASHBYTES(''SHA1'','

	OPEN cPrimaryKeyCursor

	FETCH NEXT
	FROM cPrimaryKeyCursor
	INTO @ColumnNamePrimaryKey
		,@ColumnNamePrimaryKeyDataType

	SET @NrOfPrimaryKeyColumns = 0

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @NrOfPrimaryKeyColumns = @NrOfPrimaryKeyColumns + 1
		SET @PrimaryKeyString = @PrimaryKeyString + (
				CASE 
					WHEN @NrOfPrimaryKeyColumns > 1
						THEN ', '
					ELSE ''
					END
				) + @ColumnNamePrimaryKey
		SET @ChecksumPrimaryKeyString = @ChecksumPrimaryKeyString + (
				CASE 
					WHEN @NrOfPrimaryKeyColumns > 1
						THEN '+'
					ELSE ''
					END
				) + + (
				CASE 
					WHEN @ColumnNamePrimaryKeyDataType LIKE '%date%'
						THEN 'CONVERT(char(8), ' + @ColumnNamePrimaryKey + ', 112)'
					WHEN @ColumnNamePrimaryKeyDataType LIKE '%image%'
						THEN 'IsNull(CAST(CONVERT(varbinary, ' + @ColumnNamePrimaryKey + ') as varchar(max)), '''')'
					ELSE 'cast(' + @ColumnNamePrimaryKey + ' as varchar(max))'
					END
				)

		FETCH NEXT
		FROM cPrimaryKeyCursor
		INTO @ColumnNamePrimaryKey
			,@ColumnNamePrimaryKeyDataType
	END

	CLOSE cPrimaryKeyCursor

	DEALLOCATE cPrimaryKeyCursor

	SELECT @pk_index_storage_location = max(fp.IndexStorageLocation)
	FROM [Metadata].[TableKeyDefinition] fp
	WHERE TableCatalog = @DestinationTableCatalog
		AND SchemaName = @DestinationSchemaName
		AND TableName = @DestinationTableName
		AND KeyType = 'PK'
		AND fp.IndexStorageLocation != 'DefaultLocation'

	-- Get index fill factor
	DECLARE @pk_index_fill_factor VARCHAR(180)

	SELECT @pk_index_fill_factor = ISNULL(',  FILLFACTOR = ' + cast(max(fp.IndexFillFactor) AS VARCHAR(5)), '')
	FROM [Metadata].[TableKeyDefinition] fp
	WHERE TableCatalog = @DestinationTableCatalog
		AND SchemaName = @DestinationSchemaName
		AND TableName = @DestinationTableName
		AND KeyType = 'PK'

	SET @PrimaryKeyString = @PrimaryKeyString + '
				) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = ' + @CompressionType + @pk_index_fill_factor + ') ' + (
			CASE 
				WHEN @IsPartitioned = 1
					THEN ' ON ' + @PartitionSchemeName + '(' + @PartitionKeyColumnName + ')'
				WHEN @pk_index_storage_location IS NOT NULL
					THEN ' ON [' + @pk_index_storage_location + ']'
				ELSE ' ON [PRIMARY]'
				END
			)
	SET @ChecksumPrimaryKeyString = @ChecksumPrimaryKeyString + '), 1)'

	IF (@NrOfPrimaryKeyColumns > 0)
		SET @CreateString = @PrimaryKeyString + CHAR(10)

	IF @CreateCheckSumColumns = 1
	BEGIN
		-- Create "Checksum column" for all non PK columns
		DECLARE @SrcTableName NVARCHAR(50)

		SELECT @SrcTableName = SourceTableName
		FROM [Metadata].[DestinationTable] AS b
		WHERE b.DestinationTableCatalog = @DestinationTableCatalog
			AND b.DestinationTableName = @DestinationTableName
			AND b.DestinationSchemaName = @DestinationSchemaName

		-- when the current table act as the destination
		DECLARE cAllNettoColumnsCursor_dst CURSOR
		FOR
		SELECT c.COLUMN_NAME
			,c.DATA_TYPE
			,s.ORDINAL_POSITION
		FROM (
			SELECT a.COLUMN_NAME
				,a.DATA_TYPE --, a.ORDINAL_POSITION
			FROM [Metadata].[SourceField] AS a
			INNER JOIN [Metadata].[DestinationTable] AS b ON b.DestinationTableCatalog = @DestinationTableCatalog
				AND b.DestinationTableName = @DestinationTableName
				AND b.DestinationSchemaName = @DestinationSchemaName
				AND a.TABLE_CATALOG = b.SourceTableCatalog
				AND a.TABLE_SCHEMA = b.SourceSchemaName
				AND a.TABLE_NAME = b.SourceTableName
				AND a.DestinationTableCatalog = b.DestinationTableCatalog
			
			EXCEPT
			
			SELECT COLUMN_NAME
				,DATA_TYPE --, KeyColumnOrder as ORDINAL_POSITION
			FROM [Metadata].[TableKeyDefinition]
			WHERE TableCatalog = @DestinationTableCatalog
				AND SchemaName = @DestinationSchemaName
				AND TableName = @DestinationTableName
				AND KeyType = 'PK'
			
			EXCEPT
			
			SELECT COLUMN_NAME
				,DATA_TYPE
			FROM [Metadata].[DestinationFieldExtended]
			WHERE DestinationTableCatalog = @DestinationTableCatalog
				AND IsNull(SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
				AND ISNULL(ApplicableTable, @DestinationTableName) = @DestinationTableName
			
			INTERSECT
			
			SELECT a.COLUMN_NAME
				,a.DATA_TYPE
			FROM [Metadata].[SourceField] AS a
			WHERE TABLE_CATALOG = @SourceTableCatalog
				AND TABLE_SCHEMA = @SourceSchemaName
				AND TABLE_NAME = @SourceTableName
				AND DestinationTableCatalog = @DestinationTableCatalog
			) AS c
		INNER JOIN [Metadata].[SourceField] AS s ON s.DestinationTableCatalog = @DestinationTableCatalog
			AND c.COLUMN_NAME = s.COLUMN_NAME
			AND s.TABLE_NAME = @SrcTableName
			AND s.TABLE_CATALOG = @SourceTableCatalog
			AND s.TABLE_SCHEMA = @SourceSchemaName
		ORDER BY s.ORDINAL_POSITION

		DECLARE @NrOfNettoColumns_dst INT
		DECLARE @KeyColumnOrder_dst SMALLINT

		SET @ChecksumAllNettoColumns = 'ALTER TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + '] ADD
											CheckSumNonPKColumns_dst AS CONVERT(VARCHAR(40), HASHBYTES(''SHA1'','

		OPEN cAllNettoColumnsCursor_dst

		FETCH NEXT
		FROM cAllNettoColumnsCursor_dst
		INTO @ColumnNameNettoColumn
			,@ColumnNameNettoColumnDataType
			,@KeyColumnOrder_dst

		SET @NrOfNettoColumns_dst = 0

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NrOfNettoColumns_dst = @NrOfNettoColumns_dst + 1
			SET @ChecksumAllNettoColumns = @ChecksumAllNettoColumns + (
					CASE 
						WHEN @NrOfNettoColumns_dst > 1
							THEN '+'
						ELSE ''
						END
					) + (
					CASE 
						WHEN @ColumnNameNettoColumnDataType LIKE '%date%'
							THEN 'CONVERT(char(8), isnull(' + @ColumnNameNettoColumn + ', convert(datetime, ''1900-01-01'', 20)), 112)'
						WHEN @ColumnNameNettoColumnDataType = '%image%'
							THEN 'IsNull(CAST(CONVERT(varbinary, ' + @ColumnNameNettoColumn + ') as varchar(max)), '''')'
						ELSE 'isnull(cast(' + @ColumnNameNettoColumn + ' as varchar(max)), '''')'
						END
					)

			FETCH NEXT
			FROM cAllNettoColumnsCursor_dst
			INTO @ColumnNameNettoColumn
				,@ColumnNameNettoColumnDataType
				,@KeyColumnOrder_dst
		END

		CLOSE cAllNettoColumnsCursor_dst

		DEALLOCATE cAllNettoColumnsCursor_dst

		SET @ChecksumAllNettoColumns = @ChecksumAllNettoColumns + '), 1) '

		IF (@NrOfNettoColumns_dst > 0)
			SET @CreateString = @CreateString + @ChecksumAllNettoColumns + CHAR(10)

		-- ... and when the current table act as the source
		DECLARE cAllNettoColumnsCursor_src CURSOR
		FOR
		SELECT c.COLUMN_NAME
			,c.DATA_TYPE
			,s.ORDINAL_POSITION
		FROM (
			SELECT a.COLUMN_NAME
				,a.DATA_TYPE --, a.ORDINAL_POSITION
			FROM [Metadata].[SourceField] AS a
			INNER JOIN [Metadata].[DestinationTable] AS b ON b.DestinationTableCatalog = @DestinationTableCatalog
				AND b.DestinationTableName = @DestinationTableName
				AND b.DestinationSchemaName = @DestinationSchemaName
				AND a.TABLE_CATALOG = b.SourceTableCatalog
				AND a.TABLE_SCHEMA = b.SourceSchemaName
				AND a.TABLE_NAME = b.SourceTableName
				AND a.DestinationTableCatalog = b.DestinationTableCatalog
			
			EXCEPT
			
			SELECT COLUMN_NAME
				,DATA_TYPE
			FROM [Metadata].[TableKeyDefinition]
			WHERE TableCatalog = @DestinationTableCatalog
				AND SchemaName = @DestinationSchemaName
				AND TableName = @DestinationTableName
				AND KeyType = 'PK'
			) AS c
		INNER JOIN [Metadata].[SourceField] AS s ON s.DestinationTableCatalog = @DestinationTableCatalog
			AND c.COLUMN_NAME = s.COLUMN_NAME
			AND s.TABLE_NAME = @SrcTableName
			AND s.TABLE_CATALOG = @SourceTableCatalog
			AND s.TABLE_SCHEMA = @SourceSchemaName
		
		UNION
		
		-- Adding identity column, general
		SELECT COLUMN_NAME
			,DATA_TYPE
			,ORDINAL_POSITION
		FROM [Metadata].[DestinationFieldExtended]
		WHERE DestinationTableCatalog = @DestinationTableCatalog
			AND IsNull(SourceTableCatalog, @SourceTableCatalog) = @SourceTableCatalog
			AND IncludeInChecksum_src = 1
			AND ApplicableTable IS NULL
		
		UNION
		
		-- Adding identity column, current group
		SELECT COLUMN_NAME
			,DATA_TYPE
			,ORDINAL_POSITION
		FROM [Metadata].[DestinationFieldExtended]
		WHERE DestinationTableCatalog = @DestinationTableCatalog
			AND IncludeInChecksum_src = 1
			AND ApplicableTable = @DestinationTableName
		ORDER BY s.ORDINAL_POSITION

		DECLARE @NrOfNettoColumns_src INT
		DECLARE @KeyColumnOrder_src SMALLINT

		SET @ChecksumAllNettoColumns = 'ALTER TABLE [' + @TableCatalogName + '].[' + @SchemaName + '].[' + @TableName + '] ADD
											CheckSumNonPKColumns_src AS CONVERT(VARCHAR(40), HASHBYTES(''SHA1'','

		OPEN cAllNettoColumnsCursor_src

		FETCH NEXT
		FROM cAllNettoColumnsCursor_src
		INTO @ColumnNameNettoColumn
			,@ColumnNameNettoColumnDataType
			,@KeyColumnOrder_src

		SET @NrOfNettoColumns_src = 0

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @NrOfNettoColumns_src = @NrOfNettoColumns_src + 1
			SET @ChecksumAllNettoColumns = @ChecksumAllNettoColumns + (
					CASE 
						WHEN @NrOfNettoColumns_src > 1
							THEN '+'
						ELSE ''
						END
					) + (
					CASE 
						WHEN @ColumnNameNettoColumnDataType LIKE '%date%'
							THEN 'CONVERT(char(8), isnull(' + @ColumnNameNettoColumn + ', convert(datetime, ''1900-01-01'', 20)), 112)'
						WHEN @ColumnNameNettoColumnDataType LIKE '%image%'
							THEN 'IsNull(CAST(CONVERT(varbinary, ' + @ColumnNameNettoColumn + ') as varchar(max)), '''')'
						ELSE 'isnull(cast(' + @ColumnNameNettoColumn + ' as varchar(max)), '''')'
						END
					)

			FETCH NEXT
			FROM cAllNettoColumnsCursor_src
			INTO @ColumnNameNettoColumn
				,@ColumnNameNettoColumnDataType
				,@KeyColumnOrder_src
		END

		CLOSE cAllNettoColumnsCursor_src

		DEALLOCATE cAllNettoColumnsCursor_src

		SET @ChecksumAllNettoColumns = @ChecksumAllNettoColumns + '), 1) '

		IF (@NrOfNettoColumns_src > 0)
			SET @CreateString = @CreateString + @ChecksumAllNettoColumns + CHAR(10)
	END

	RETURN @CreateString
END