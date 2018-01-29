-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetMergePatternString] (
	@SourceTableCatalog NVARCHAR(128)
	,@SourceSchemaName NVARCHAR(128)
	,@SourceTableName NVARCHAR(128)
	,@DestinationTableCatalog NVARCHAR(128)
	,@DestinationSchemaName NVARCHAR(128)
	,@DestinationTableName NVARCHAR(128)
	)
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@TAB NVARCHAR(1) = NCHAR(9)
		,@MergeStatement NVARCHAR(max)
		,@MergeCondition NVARCHAR(max) = ''
		,@InsertColumns NVARCHAR(max) = ''
		,@InsertValues NVARCHAR(max) = ''
		,@MatchCondition NVARCHAR(max) = ''
		,@UpdateFields NVARCHAR(max) = ''

	SELECT @InsertColumns = @InsertColumns + ', ' + sf.COLUMN_NAME
		,@InsertValues = @InsertValues + ', ' + sf.COLUMN_NAME
		,@MatchCondition = @MatchCondition + ' OR ' + CASE 
			WHEN sf.DATA_TYPE LIKE '%char'
				THEN 'Isnull(convert(nvarchar(max), dst.[' + sf.COLUMN_NAME + ']),'''') != Isnull(convert(nvarchar(max), src.[' + sf.COLUMN_NAME + ']),'''')'
			ELSE 'dst.[' + sf.COLUMN_NAME + '] != src.[' + sf.COLUMN_NAME + ']'
			END
		,@UpdateFields = @UpdateFields + ', [' + sf.COLUMN_NAME + '] = src.[' + sf.COLUMN_NAME + ']'
	FROM [Metadata].[DestinationTable] dt
	INNER JOIN [Metadata].[SourceField] sf ON dt.SourceTableCatalog = sf.TABLE_CATALOG
		AND dt.SourceSchemaName = sf.TABLE_SCHEMA
		AND dt.SourceTableName = sf.TABLE_NAME
	WHERE dt.DestinationTableCatalog = @DestinationTableCatalog
		AND dt.DestinationSchemaName = @DestinationSchemaName
		AND dt.DestinationTableName = @DestinationTableName
	ORDER BY ORDINAL_POSITION

	SELECT @MergeCondition = @MergeCondition + ' AND [dst].[' + pk.COLUMN_NAME + '] = src.[' + pk.COLUMN_NAME + ']'
	FROM [Metadata].[DestinationTable] dt
	INNER JOIN [Metadata].[TableKeyDefinition] pk ON dt.DestinationTableCatalog = pk.TableCatalog
		AND dt.DestinationSchemaName = pk.SchemaName
		AND dt.DestinationTableName = pk.TableName
		AND pk.KeyType = 'PK'
	WHERE dt.DestinationTableCatalog = @DestinationTableCatalog
		AND dt.DestinationSchemaName = @DestinationSchemaName
		AND dt.DestinationTableName = @DestinationTableName
	ORDER BY pk.KeyColumnOrder

	SET @InsertColumns = right(@InsertColumns, len(@InsertColumns) - 2)
	SET @InsertValues = right(@InsertValues, len(@InsertValues) - 2)
	SET @MatchCondition = right(@MatchCondition, len(@MatchCondition) - 4)
	SET @UpdateFields = right(@UpdateFields, len(@UpdateFields) - 2)
	SET @MergeCondition = right(@MergeCondition, len(@MergeCondition) - 4)
	SET @MergeStatement = @TAB + '-- Logic merge statement' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'DECLARE @tab as table ([action] varchar(25));' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'MERGE [' + @DestinationSchemaName + '].[' + @DestinationTableName + '] as dst USING [' + @SourceTableCatalog + '].[' + @SourceSchemaName + '].[' + @SourceTableName + '] as src ON ' + @MergeCondition + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'WHEN NOT MATCHED BY TARGET' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'THEN' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             INSERT (' + @InsertColumns + ',SysDateTimeInsertedUTC,SysExecutionLog_key)' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             VALUES (' + @InsertValues + ',getutcdate(),0)' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'WHEN MATCHED AND (' + @MatchCondition + ' OR dst.SysDatetimeDeletedUTC IS NOT NULL)' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'THEN' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             UPDATE SET ' + @UpdateFields + ',SysModifiedUTC = getutcdate(),SysDatetimeUpdatedUTC = getutcdate(),SysExecutionLog_key = 0,SysDatetimeDeletedUTC = NULL' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'WHEN NOT MATCHED BY SOURCE' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'THEN' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             DELETE' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'OUTPUT $action INTO @tab (action);' + @CRLF + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + ';WITH RowCnt AS (' + @CRLF + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             SELECT Coalesce(SUM(CASE WHEN [action] = ''INSERT'' THEN 1 ELSE 0 END), 0) As InsertCount,' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                               Coalesce(SUM(CASE WHEN [action] = ''UPDATE'' THEN 1 ELSE 0 END), 0) As UpdateCount,' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                               (SELECT COUNT(*) FROM [' + @SourceTableCatalog + '].[' + @SourceSchemaName + '].[' + @SourceTableName + '] as src ) As ReadCount' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                             FROM @tab' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + '                                                                                         )' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'SELECT @InsertCount = InsertCount, @UpdateCount = UpdateCount, @ReadCount = ReadCount, @IgnoreCount = ReadCount - InsertCount - UpdateCount' + @CRLF
	SET @MergeStatement = @MergeStatement + @TAB + 'FROM RowCnt;' + @CRLF + @CRLF

	RETURN @MergeStatement
END