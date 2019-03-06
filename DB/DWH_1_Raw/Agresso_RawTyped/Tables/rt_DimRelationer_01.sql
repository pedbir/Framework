CREATE TABLE [Agresso_RawTyped].[rt_DimRelationer_01] (
    [SysFileName]              NVARCHAR (250) NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [Recno]                    INT            NULL,
    [Section]                  NVARCHAR (3)   NULL,
    [Tab]                      NVARCHAR (3)   NULL,
    [Relatedattr]              NVARCHAR (100) NOT NULL,
    [Relvalue]                 NVARCHAR (100) NULL,
    [Attname]                  NVARCHAR (100) NULL,
    [Attvalue]                 NVARCHAR (100) NOT NULL,
    [Client]                   NVARCHAR (15)  NOT NULL,
    CONSTRAINT [PK_AgressoDimRelationer_01] PRIMARY KEY CLUSTERED ([Relatedattr] ASC, [Attvalue] ASC, [Client] ASC, [SysSrcGenerationDateTime] DESC)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_AgressoDimRelationer_01]
    ON [Agresso_RawTyped].[rt_DimRelationer_01]([SysFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AgressoDimRelationer_01]
    ON [Agresso_RawTyped].[rt_DimRelationer_01]([SysModifiedUTC] ASC);

