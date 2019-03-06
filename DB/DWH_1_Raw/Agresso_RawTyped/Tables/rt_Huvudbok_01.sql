CREATE TABLE [Agresso_RawTyped].[rt_Huvudbok_01] (
    [SysFileName]              NVARCHAR (250)  NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)   NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)   NOT NULL,
    [SysModifiedUTC]           DATETIME2 (0)   NOT NULL,
    [SysExecutionLog_key]      INT             NOT NULL,
    [recno]                    INT             NULL,
    [section]                  NVARCHAR (3)    NULL,
    [Tab]                      NVARCHAR (3)    NULL,
    [Account]                  INT             NULL,
    [Client]                   NVARCHAR (15)   NOT NULL,
    [Lastupdate]               DATETIME        NULL,
    [Vouchertype]              NVARCHAR (6)    NULL,
    [Voucherno]                INT             NOT NULL,
    [Sequenceno]               INT             NOT NULL,
    [Voucherdate]              DATETIME        NULL,
    [PERIOD]                   INT             NULL,
    [Dim1]                     NVARCHAR (100)  NULL,
    [Dim2]                     NVARCHAR (100)  NULL,
    [Dim3]                     NVARCHAR (100)  NULL,
    [Dim4]                     NVARCHAR (100)  NULL,
    [Dim5]                     NVARCHAR (100)  NULL,
    [Dim6]                     NVARCHAR (100)  NULL,
    [Dim7]                     NVARCHAR (100)  NULL,
    [Taxcode]                  INT             NULL,
    [Description]              NVARCHAR (1000) NULL,
    [Amount]                   DECIMAL (18)    NULL,
    [Currency]                 NVARCHAR (20)   NULL,
    [Curamount]                DECIMAL (18)    NULL,
    [Extinvref]                NVARCHAR (250)  NULL,
    [Aparid]                   NVARCHAR (50)   NULL,
    [Apartype]                 NVARCHAR (10)   NULL,
    [Att1id]                   NVARCHAR (100)  NULL,
    [Att2id]                   NVARCHAR (100)  NULL,
    [Att3id]                   NVARCHAR (100)  NULL,
    [Att4id]                   NVARCHAR (100)  NULL,
    [Att5id]                   NVARCHAR (100)  NULL,
    [Att6id]                   NVARCHAR (100)  NULL,
    [Att7id]                   NVARCHAR (100)  NULL,
    CONSTRAINT [PK_AgressoHuvudbok_01] PRIMARY KEY CLUSTERED ([Client] ASC, [Voucherno] ASC, [Sequenceno] ASC, [SysSrcGenerationDateTime] DESC)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysFileName_AgressoHuvudbok_01]
    ON [Agresso_RawTyped].[rt_Huvudbok_01]([SysFileName] ASC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AgressoHuvudbok_01]
    ON [Agresso_RawTyped].[rt_Huvudbok_01]([SysModifiedUTC] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Huvudbok_01_AccountClient]
    ON [Agresso_RawTyped].[rt_Huvudbok_01]([Account] ASC, [Client] ASC);

