CREATE TABLE [Agresso_RawTyped].[rt_Rapportstruktur_01] (
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
    [ID]                       INT            NOT NULL,
    [Account]                  NVARCHAR (50)  NOT NULL,
    [Ftg]                      NVARCHAR (50)  NULL,
    [Segment]                  NVARCHAR (50)  NULL,
    [Kst]                      NVARCHAR (50)  NULL,
    [Str0account]              NVARCHAR (50)  NULL,
    [Str1account]              NVARCHAR (50)  NULL,
    [Str2account]              NVARCHAR (50)  NULL,
    [Str3account]              NVARCHAR (50)  NULL,
    [LastUpdate]               DATETIME       NULL,
    [Percentage]               NVARCHAR (50)  NULL,
    [UserId]                   NVARCHAR (50)  NULL,
    CONSTRAINT [PK_AgressoRapportstruktur_01] PRIMARY KEY CLUSTERED ([ID] ASC, [SysSrcGenerationDateTime] DESC)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_AgressoRapportstruktur_01]
    ON [Agresso_RawTyped].[rt_Rapportstruktur_01]([SysFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AgressoRapportstruktur_01]
    ON [Agresso_RawTyped].[rt_Rapportstruktur_01]([SysModifiedUTC] ASC);

