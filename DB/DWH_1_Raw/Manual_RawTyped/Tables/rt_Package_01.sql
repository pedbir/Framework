CREATE TABLE [Manual_RawTyped].[rt_Package_01] (
    [SysFileName]              NVARCHAR (250) NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [PackageID]                SMALLINT       NULL,
    [PackageGUID]              VARCHAR (36)   NULL,
    [PackageName]              VARCHAR (49)   NULL,
    [Amount]                   MONEY          NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_SysFileName]
    ON [Manual_RawTyped].[rt_Package_01]([SysFileName] ASC);

