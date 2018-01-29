-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE PROCEDURE [Metadata].[CreateStoredProcedurePackage] @DestinationTableName NVARCHAR(128) = NULL
	,@DestinationTableCatalog NVARCHAR(128)
	,@DestinationSchemaName NVARCHAR(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DECLARE @TABLE_CATALOG NVARCHAR(128)
		,@TABLE_SCHEMA NVARCHAR(128)
		,@TABLE_NAME NVARCHAR(128)
		,@DestinationTableName2 NVARCHAR(128)
		,@StageSchemaName VARCHAR(128)
		,@StageTableName VARCHAR(128)
		,@StageTableCatalog VARCHAR(128)
		,@CreateStageTable BIT
		,@TABLE_SERVER NVARCHAR(128)
		,@SSISPackageName NVARCHAR(128)
		,@SSISPackageGUID NVARCHAR(128)
		,@CRLF NVARCHAR(10) = NCHAR(13)

	BEGIN TRANSACTION CreateTables

	-- Create SP Header
	BEGIN TRY
		DECLARE cTables CURSOR
		FOR
		SELECT SourceTableCatalog AS TABLE_CATALOG
			,SourceSchemaName AS TABLE_SCHEMA
			,SourceTableName AS TABLE_NAME
			,DestinationTableName AS RawTableName
			,DestinationSchemaName AS RawSchemaName
			,StageSchemaName
			,StageTableName
			,StageTableCatalog
			,CreateStageTable
			,SourceServer AS TABLE_SERVER
			,SSISPackageName
			,SSISPackageGUID
		FROM [Metadata].[DestinationTable]
		WHERE DestinationTableCatalog = @DestinationTableCatalog
			AND DestinationTableName = IsNull(@DestinationTableName, DestinationTableName)
			AND DestinationSchemaName = @DestinationSchemaName

		OPEN cTables

		FETCH NEXT
		FROM cTables
		INTO @TABLE_CATALOG
			,@TABLE_SCHEMA
			,@TABLE_NAME
			,@DestinationTableName2
			,@DestinationSchemaName
			,@StageSchemaName
			,@StageTableName
			,@StageTableCatalog
			,@CreateStageTable
			,@TABLE_SERVER
			,@SSISPackageName
			,@SSISPackageGUID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @UseAndExecStatment NVARCHAR(max)
				,@CreateProcedureStringHeader NVARCHAR(max)
				,@PackageVariableString NVARCHAR(max)
				,@CreateProcedureStringLogStart NVARCHAR(max)
				,@CreateProcedureStringLogic NVARCHAR(max)
				,@CreateProcedureStringLogEnd NVARCHAR(max)
				,@MergeStatement NVARCHAR(max)
				,@IndexMaintenanceStatement NVARCHAR(max)

			-- Create Header for procedure creating
			SET @CreateProcedureStringHeader = 'CREATE PROCEDURE [' + @DestinationSchemaName + '].[' + @SSISPackageName + '] AS ' + @CRLF
			SET @CreateProcedureStringHeader = @CreateProcedureStringHeader + 'BEGIN' + @CRLF
			SET @CreateProcedureStringHeader = @CreateProcedureStringHeader + '     SET NOCOUNT ON;' + @CRLF + @CRLF
			-- Create sql string for variable declaration
			SET @PackageVariableString = [Metadata].[GetPackageVariablesString]()
			-- Create sql string for getting SP meta data and Log the start of the ETL log
			SET @CreateProcedureStringLogStart = [Metadata].[GetLogStartPatternString](@SSISPackageName, @DestinationSchemaName, @SSISPackageGUID)
			-- Create sql string for the transportation of the data
			SET @MergeStatement = [Metadata].[GetSSASProcessingPatternString](@SSISPackageGUID)
			--                                                  set @MergeStatement = ''
			-- Create sql string for the index maintenance
			--                                                  set @IndexMaintenanceStatement = [Metadata].[GetIndexMaintenanceString](@DestinationTableCatalog, @DestinationSchemaName, @DestinationTableName2)
			SET @IndexMaintenanceStatement = ''
			-- Create sql string for the end of the ETL log
			SET @CreateProcedureStringLogEnd = [Metadata].[GetLogEndPatternString](@SSISPackageGUID)
			SET @UseAndExecStatment = N'USE [' + @DestinationTableCatalog + ']' + @CRLF
			SET @UseAndExecStatment = @UseAndExecStatment + 'IF EXISTS (SELECT o.* FROM sys.objects o inner join sys.schemas s on o.schema_id = s.schema_id WHERE o.type = ''P'' AND o.name = ''' + @SSISPackageName + ''' and s.name = ''' + @DestinationSchemaName + '''' + ')' + @CRLF
			SET @UseAndExecStatment = @UseAndExecStatment + '            DROP PROCEDURE [' + @DestinationSchemaName + '].[' + @SSISPackageName + ']' + @CRLF
			SET @UseAndExecStatment = @UseAndExecStatment + ' exec (@CreateProcedureStringHeader+@PackageVariableString+@CreateProcedureStringLogStart + @MergeStatement + @IndexMaintenanceStatement + @CreateProcedureStringLogEnd + '' END'')'

			EXEC sp_executesql @UseAndExecStatment
				,N'@CreateProcedureStringHeader nvarchar(max), @PackageVariableString nvarchar(max), @CreateProcedureStringLogStart nvarchar(max), @MergeStatement nvarchar(max), @IndexMaintenanceStatement nvarchar(max), @CreateProcedureStringLogEnd nvarchar(max)'
				,@CreateProcedureStringHeader = @CreateProcedureStringHeader
				,@PackageVariableString = @PackageVariableString
				,@CreateProcedureStringLogStart = @CreateProcedureStringLogStart
				,@MergeStatement = @MergeStatement
				,@IndexMaintenanceStatement = @IndexMaintenanceStatement
				,@CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd

			FETCH NEXT
			FROM cTables
			INTO @TABLE_CATALOG
				,@TABLE_SCHEMA
				,@TABLE_NAME
				,@DestinationTableName2
				,@DestinationSchemaName
				,@StageSchemaName
				,@StageTableName
				,@StageTableCatalog
				,@CreateStageTable
				,@TABLE_SERVER
				,@SSISPackageName
				,@SSISPackageGUID
		END

		CLOSE cTables

		DEALLOCATE cTables

		COMMIT TRANSACTION CreateTables
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION CreateTables

		DECLARE @ErrorMessage VARCHAR(max) = ERROR_MESSAGE()

		RAISERROR (
				@ErrorMessage
				,16
				,1
				)

		CLOSE cTables

		DEALLOCATE cTables
	END CATCH
END