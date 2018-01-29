CREATE TABLE [Audit].[DataError] (
    [DataError_key]       INT            IDENTITY (1, 1) NOT NULL,
    [DateTimeErrorUTC]    DATETIME       NOT NULL,
    [PackageName]         NVARCHAR (100) NOT NULL,
    [SysExecutionLog_key] INT            NOT NULL,
    [SourceTableName]     NVARCHAR (100) NOT NULL,
    [ErrorDescription]    NVARCHAR (255) NOT NULL,
    [RowData]             XML            NULL,
    [FlatFileData]        NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Audit_DataError] PRIMARY KEY CLUSTERED ([DataError_key] ASC)
);



