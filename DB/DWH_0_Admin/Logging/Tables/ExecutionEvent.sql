CREATE TABLE [Logging].[ExecutionEvent] (
    [ExecutionID]      UNIQUEIDENTIFIER NOT NULL,
    [SourceID]         UNIQUEIDENTIFIER NOT NULL,
    [SourceName]       VARCHAR (150)    NULL,
    [EventType]        VARCHAR (15)     NOT NULL,
    [EventCode]        VARCHAR (15)     NULL,
    [EventDateTime]    DATETIME         CONSTRAINT [DF_PackageLog_EventDateTime] DEFAULT (getdate()) NOT NULL,
    [EventDescription] VARCHAR (1000)   NULL,
    CONSTRAINT [FK_ExecutionEvent_Execution] FOREIGN KEY ([ExecutionID]) REFERENCES [Logging].[PackageExecution] ([ExecutionID])
);

