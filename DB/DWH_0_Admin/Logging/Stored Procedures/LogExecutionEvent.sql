

/*
**	Logs an SSIS package execution event
*/
create PROC [Logging].[LogExecutionEvent]
	--@PackageID uniqueidentifier,
	@ExecutionID uniqueidentifier,
	@EventDateTime datetime,
	@EventType varchar(15),
	@EventCode varchar(15),
	@EventDescription varchar(1000),
	@SourceID uniqueidentifier,
	@SourceName varchar(150)
AS

	INSERT INTO [Logging].[ExecutionEvent]
           ([ExecutionID]
           ,[EventDateTime]
           ,[EventType]
           ,[EventCode]
           ,[EventDescription]
           ,[SourceID]
           ,[SourceName])
     VALUES
           (@ExecutionID
           ,@EventDateTime
           ,@EventType
           ,@EventCode
           ,@EventDescription
           ,@SourceID
           ,@SourceName)
