CREATE TABLE [Agresso_RawTyped].[rt_Kontoplan_01] (
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
    [Account]                  NVARCHAR (50)  NOT NULL,
    [Description]              NVARCHAR (300) NULL,
    [Account_grp]              NVARCHAR (50)  NULL,
    [Xaccount_grp]             NVARCHAR (200) NULL,
    [Account_type]             NVARCHAR (10)  NULL,
    [Status]                   NVARCHAR (3)   NULL,
    [UserId]                   NVARCHAR (50)  NULL,
    [Lastupdate]               DATETIME       NULL,
    [Client]                   NVARCHAR (15)  NOT NULL,
    CONSTRAINT [PK_AgressoKontoplan_01] PRIMARY KEY CLUSTERED ([Account] ASC, [Client] ASC, [SysSrcGenerationDateTime] DESC)
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_AgressoKontoplan_01]
    ON [Agresso_RawTyped].[rt_Kontoplan_01]([SysFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AgressoKontoplan_01]
    ON [Agresso_RawTyped].[rt_Kontoplan_01]([SysModifiedUTC] ASC);

