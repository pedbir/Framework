CREATE TABLE [Norm].[n_Planning] (
    [Planning_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [Planning_bkey]             INT            NOT NULL,
    [Scenario_bkey]             NVARCHAR (250) NULL,
    [Phase_bkey]                NVARCHAR (250) NULL,
    [CustomerCategory_bkey]     INT            NULL,
    [P01]                       NUMERIC (38)   NULL,
    [P02]                       NUMERIC (38)   NULL,
    [P03]                       NUMERIC (38)   NULL,
    [P04]                       NUMERIC (38)   NULL,
    [P05]                       NUMERIC (38)   NULL,
    [P06]                       NUMERIC (38)   NULL,
    [P07]                       NUMERIC (38)   NULL,
    [P08]                       NUMERIC (38)   NULL,
    [P09]                       NUMERIC (38)   NULL,
    [P10]                       NUMERIC (38)   NULL,
    [P11]                       NUMERIC (38)   NULL,
    [P12]                       NUMERIC (38)   NULL,
    CONSTRAINT [PK_Norm_n_Planning] PRIMARY KEY CLUSTERED ([Planning_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Planning]
    ON [Norm].[n_Planning]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

