

CREATE PROCEDURE [dbo].[LoadBatchLogUpdate]
	@SysExecutionLog_key int	
AS
declare @status nvarchar(20)

UPDATE 
	Logging.LoadBatchLog
SET
	EndTime = GetDate(),
	Duration = DateDiff(s, StartTime, GetDate())
WHERE SysExecutionLog_key = @SysExecutionLog_key
