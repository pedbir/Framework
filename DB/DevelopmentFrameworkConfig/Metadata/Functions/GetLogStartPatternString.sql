-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetLogStartPatternString] (
	@SSISPackageName NVARCHAR(128)
	,@DestinationSchemaName NVARCHAR(128)
	,@SSISPackageGUID NVARCHAR(128)
	)
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@CreateProcedureStringLogStart NVARCHAR(max)

	SET @CreateProcedureStringLogStart = '      -- Get stored procedure meta data for logging purposes' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '              declare @SPCreatedDate date' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @Executer nvarchar(128) = SYSTEM_USER' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @_LocaleID nvarchar(128) = convert(sysname, SERVERPROPERTY(''LCID''))' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @_ExecutionID nvarchar(128) = NEWID()' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @_ExecutionStartTime datetime = getdate()' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @_ExecutionUserName nvarchar(128) = SYSTEM_USER' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @_ProductVersion nvarchar(128) = convert(sysname, SERVERPROPERTY(''ProductVersion''))' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '              SELECT o.* into #SPMetadata FROM sys.objects o inner join sys.schemas s on o.schema_id = s.schema_id WHERE o.type = ''P'' AND o.name = ''' + @SSISPackageName + ''' and s.name = ''' + @DestinationSchemaName + '''' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '              select @SPCreatedDate = create_date from #SPMetadata' + @CRLF + @CRLF
	-- Create start log
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '              -- Create start log ' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '              EXECUTE DWH_0_Admin.Logging.LogPackageStart ' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           @PackageID = ''' + @SSISPackageGUID + '''' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @PackageName = ''' + @SSISPackageName + '''' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @VersionID = ''' + @SSISPackageGUID + '''' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @VersionMajor = 1' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @VersionMinor = 0' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @VersionBuild = 0' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @VersionComments = ''' + 'Package executed as a stored procedure' + '''' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @CreationDate = @SPCreatedDate' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @CreatorName = @Executer' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @CreatorComputerName = @@SERVERNAME' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @LocaleID = @_LocaleID' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @ExecutionID = @_ExecutionID' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @ExecutionStartTime = @_ExecutionStartTime' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @ExecutionUserName = @_ExecutionUserName' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @ExecutionMachineName = @@SERVERNAME' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @ProductVersion = @_ProductVersion' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @InteractiveMode = 0' + @CRLF
	SET @CreateProcedureStringLogStart = @CreateProcedureStringLogStart + '                                           , @SysExecutionLog_key = 0' + @CRLF + @CRLF

	RETURN @CreateProcedureStringLogStart
END