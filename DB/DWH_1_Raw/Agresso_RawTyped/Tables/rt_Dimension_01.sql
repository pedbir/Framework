CREATE TABLE [Agresso_RawTyped].[rt_Dimension_01] (
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
    [Attributeid]              NVARCHAR (20)  NOT NULL,
    [Attname]                  NVARCHAR (100) NULL,
    [DimValue]                 NVARCHAR (100) NOT NULL,
    [DimDescription]           NVARCHAR (250) NULL,
    [Lastupdate]               DATETIME       NULL,
    [Periodfrom]               INT            NULL,
    [Periodto]                 INT            NULL,
    [Relvalue]                 NVARCHAR (100) NULL,
    [Status]                   NVARCHAR (3)   NULL,
    [Userid]                   NVARCHAR (50)  NULL,
    [Value1]                   INT            NULL,
    [Client]                   NVARCHAR (15)  NOT NULL,
    CONSTRAINT [PK_AgressoDimension_01] PRIMARY KEY CLUSTERED ([Attributeid] ASC, [DimValue] ASC, [Client] ASC, [SysSrcGenerationDateTime] DESC)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_AgressoDimension_01]
    ON [Agresso_RawTyped].[rt_Dimension_01]([SysFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AgressoDimension_01]
    ON [Agresso_RawTyped].[rt_Dimension_01]([SysModifiedUTC] ASC);

