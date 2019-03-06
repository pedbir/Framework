CREATE TABLE [Norm].[n_GLAccountLegalEntity] (
    [GLAccountLegalEntity_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [GLAccountLegalEntity_bkey] NVARCHAR (100) NOT NULL,
    [GLAccount_bkey]            NVARCHAR (100) NULL,
    [LegalEntity_bkey]          NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_GLAccountLegalEntity] PRIMARY KEY CLUSTERED ([GLAccountLegalEntity_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_GLAccountLegalEntity]
    ON [Norm].[n_GLAccountLegalEntity]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

