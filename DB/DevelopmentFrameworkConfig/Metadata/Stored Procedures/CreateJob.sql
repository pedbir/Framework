-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	Creates job to execute SSIS packages based on meta data
-- Example:	
/*	
		EXECUTE [DevelopmentFrameworkConfig].[Metadata].[CreateJob] 
				@DestinationTableCatalog = 'DataWarehouse'
				, @FilterBySchema1 = 'Navision'
				, @FilterBySchema2 = 'Navision'
				, @RunJobAsLastStep = 'NameOfJobToRun'
				, @server_name = 'LOCALHOST'	
	
*/
-- =============================================
CREATE PROCEDURE [Metadata].[CreateJob] @DestinationTableCatalog NVARCHAR(128)
	,@RunJobAsLastStep NVARCHAR(128) = NULL
	,@RunJobAsLastStep2 NVARCHAR(128) = NULL
	,@RunJobAsLastStep3 NVARCHAR(128) = NULL
	,@FilterBySchema1 NVARCHAR(20) = NULL
	,@FilterBySchema2 NVARCHAR(20) = NULL
	,@SSISPackagePath NVARCHAR(255) = 'C:\SSIS\SSISPackages\'
	,@server_name NVARCHAR(50) = 'localhost'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQLScript VARCHAR(max)
		,@SSISPackageName NVARCHAR(128)
		,@RowCounter INT = 0
		,@JobName NVARCHAR(128)
		,@on_success_action_var CHAR(1) = '3'

	SET @JobName = 'MainRunBIMLPackages_' + @DestinationTableCatalog + ISNULL('_' + @FilterBySchema1, '') + ISNULL('_' + @FilterBySchema2, '')
	SET @SQLScript = '
	USE [msdb]
	IF  EXISTS (SELECT job_id FROM msdb.dbo.sysjobs_view WHERE name = N''' + @JobName + ''')
	EXEC msdb.dbo.sp_delete_job @job_name=N''' + @JobName + ''', @delete_unused_schedule=1

	DECLARE @jobId BINARY(16)
	EXEC  msdb.dbo.sp_add_job @job_name=N''' + @JobName + ''', 
			@enabled=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=2, 
			@notify_level_netsend=2, 
			@notify_level_page=2, 
			@delete_level=0, 
			@category_name=N''[Uncategorized (Local)]'', 
			@owner_login_name=N''sa'', @job_id = @jobId OUTPUT
	select @jobId
	EXEC msdb.dbo.sp_add_jobserver @job_name=N''' + @JobName + ''', @server_name = N''' + @server_name + '''
	'

	DECLARE cTemp CURSOR
	FOR
	SELECT SSISPackageName
	FROM DevelopmentFrameworkConfig.Metadata.DestinationTable
	WHERE DestinationTableCatalog = @DestinationTableCatalog
		AND CreateTable = 1
		AND CreateSSISPackage = 1
		AND (
			DestinationSchemaName = ISNULL(@FilterBySchema1, DestinationSchemaName)
			OR DestinationSchemaName = ISNULL(@FilterBySchema2, DestinationSchemaName)
			)
	ORDER BY DestinationSchemaName
		,SSISPackageName

	OPEN cTemp

	FETCH NEXT
	FROM cTemp
	INTO @SSISPackageName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @RowCounter = @RowCounter + 1
		SET @SQLScript = @SQLScript + 'USE [msdb]
			EXEC msdb.dbo.sp_add_jobstep @job_name=N''' + @JobName + ''', @step_name=N''Run SSIS package ' + @SSISPackageName + ''', 
					@step_id=' + cast(@RowCounter AS VARCHAR(10)) + ', 
					@cmdexec_success_code=0, 
					@on_success_action=3, 
					@on_fail_action=3, 
					@retry_attempts=0, 
					@retry_interval=0, 
					@os_run_priority=0, @subsystem=N''SSIS'', 
					@command=N''/FILE "' + @SSISPackagePath + @SSISPackageName + '.dtsx" /CHECKPOINTING OFF /REPORTING E'', 
					@database_name=N''master'', 
					@flags=0
			'

		FETCH NEXT
		FROM cTemp
		INTO @SSISPackageName
	END

	CLOSE cTemp

	DEALLOCATE cTemp

	EXECUTE (@SQLScript)

	IF (@RunJobAsLastStep IS NOT NULL)
	BEGIN
		IF (@RunJobAsLastStep2 IS NULL)
			SET @on_success_action_var = '1'
		SET @SQLScript = 'USE [msdb]
				EXEC msdb.dbo.sp_add_jobstep @job_name=N''' + @JobName + ''', @step_name=N''Run jobb ' + @RunJobAsLastStep + ''', 
						@step_id=' + cast(@RowCounter + 1 AS VARCHAR(10)) + ', 
						@cmdexec_success_code=0, 
						@on_success_action=' + @on_success_action_var + ', 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N''TSQL'', 
						@command=N''EXECUTE msdb.dbo.sp_start_job @job_name = ''''' + @RunJobAsLastStep + ''''''', 
						@database_name=N''msdb'', 
						@flags=0
						'

		EXECUTE (@SQLScript)

		PRINT @SQLScript
	END

	IF (@RunJobAsLastStep2 IS NOT NULL)
	BEGIN
		IF (@RunJobAsLastStep3 IS NULL)
			SET @on_success_action_var = '1'
		SET @SQLScript = 'USE [msdb]
				EXEC msdb.dbo.sp_add_jobstep @job_name=N''' + @JobName + ''', @step_name=N''Run jobb ' + @RunJobAsLastStep2 + ''', 
						@step_id=' + cast(@RowCounter + 2 AS VARCHAR(10)) + ', 
						@cmdexec_success_code=0, 
						@on_success_action=' + @on_success_action_var + ', 
						@on_success_step_id=0, 
						@on_fail_action=2, 
						@on_fail_step_id=0, 
						@retry_attempts=0, 
						@retry_interval=0, 
						@os_run_priority=0, @subsystem=N''TSQL'', 
						@command=N''EXECUTE msdb.dbo.sp_start_job @job_name = ''''' + @RunJobAsLastStep2 + ''''''', 
						@database_name=N''msdb'', 
						@flags=0
						'

		EXECUTE (@SQLScript)

		PRINT @SQLScript
	END

	SET @SQLScript = 'USE [msdb]
	EXEC msdb.dbo.sp_update_job @job_name=N''' + @JobName + ''', 
			@enabled=1, 
			@start_step_id=1, 
			@notify_level_eventlog=0, 
			@notify_level_email=2, 
			@notify_level_netsend=2, 
			@notify_level_page=2, 
			@delete_level=0, 
			@description=N'''', 
			@category_name=N''[Uncategorized (Local)]'', 
			@owner_login_name=N''sa'', 
			@notify_email_operator_name=N'''', 
			@notify_netsend_operator_name=N'''', 
			@notify_page_operator_name=N''''
	'

	EXECUTE (@SQLScript)
END