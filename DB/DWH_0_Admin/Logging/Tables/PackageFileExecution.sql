CREATE TABLE [Logging].[PackageFileExecution] (
    [PackageFileExecutionID] INT              IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]    INT              NOT NULL,
    [SysFileName]            NVARCHAR (250)   NOT NULL,
    [ExecutionEnd]           DATETIME         NOT NULL,
    [PackageId]              UNIQUEIDENTIFIER NULL,
    [PackageVersionId]       UNIQUEIDENTIFIER NULL,
    [ExecutionID]            UNIQUEIDENTIFIER NOT NULL,
    [Status]                 NVARCHAR (15)    NULL,
    [RowsRead]               INT              NULL,
    [RowsInserted]           INT              NULL,
    [RowsUpdated]            INT              NULL,
    [RowsDeleted]            INT              NULL,
    [RowsIgnored]            INT              NULL,
    [RowsError]              INT              NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Logging_PackageFileExecution_ExecutionID]
    ON [Logging].[PackageFileExecution]([ExecutionID] ASC)
    INCLUDE([RowsRead], [RowsInserted], [RowsUpdated], [RowsDeleted], [RowsIgnored], [RowsError]);


GO
CREATE UNIQUE CLUSTERED INDEX [UCI_Logging_PackageFileExecution]
    ON [Logging].[PackageFileExecution]([SysExecutionLog_key] DESC, [SysFileName] DESC, [ExecutionEnd] DESC);

