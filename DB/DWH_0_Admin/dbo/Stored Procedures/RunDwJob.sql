
CREATE PROC RunDwJob @job_name NVARCHAR(100)
AS
set XACT_ABORT on 
set NOCOUNT ON

-- EXEC RunDwJob 'Test'

DECLARE @ActiveJobs NVARCHAR(100) = (SELECT STUFF((   SELECT    ', ' + sj.name
                                                      FROM      msdb..sysjobactivity aj
                                                      JOIN      msdb..sysjobs        sj
                                                        ON sj.job_id = aj.job_id
                                                      WHERE     aj.stop_execution_date IS NULL -- job hasn't stopped running
                                                        AND     aj.start_execution_date IS NOT NULL -- job is currently running   
                                                        AND     NOT EXISTS ( -- make sure this is the most recent run
                                                                               SELECT   1
                                                                               FROM     msdb..sysjobactivity new
                                                                               WHERE    new.job_id            = aj.job_id
                                                                                 AND    new.start_execution_date > aj.start_execution_date)
                                                      FOR XML PATH(''))
                                                  , 1
                                                  , 1
                                                  , ''))


IF LEN(ISNULL(@ActiveJobs, '')) > 0
BEGIN
	SELECT ISNULL(@ActiveJobs, '') + ' is in progress. Please wait until all jobs has completed before you trigger a new load.' AS response
	RETURN
END

IF @job_name <> ''
	EXEC msdb.dbo.sp_start_job  @job_name


SELECT ' Loading of ' + @job_name + ' in Progress...' AS response