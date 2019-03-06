CREATE TABLE [Norm].[n_FinanceCounterparty] (
    [FinanceCounterparty_key]   INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [FinanceCounterparty_bkey]  NVARCHAR (100) NOT NULL,
    [FinanceCounterpartyCode]   NVARCHAR (100) NULL,
    [FinanceCounterpartyName]   NVARCHAR (250) NULL,
    [LegalEntity_bkey]          NVARCHAR (15)  NOT NULL,
    [Status]                    NVARCHAR (3)   NULL,
    [UpdatedBy]                 NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Norm_n_FinanceCounterparty] PRIMARY KEY CLUSTERED ([FinanceCounterparty_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_FinanceCounterparty]
    ON [Norm].[n_FinanceCounterparty]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

