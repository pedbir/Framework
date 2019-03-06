CREATE TABLE [Fact].[d_GLAccountLegalEntity] (
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [GLAccountLegalEntity_key]  INT            NOT NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [GLAccountLegalEntity_bkey] NVARCHAR (100) NOT NULL,
    [GLAccount_bkey]            NVARCHAR (50)  NULL,
    [LegalEntity_bkey]          NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_d_GLAccountLegalEntity] PRIMARY KEY CLUSTERED ([GLAccountLegalEntity_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_GLAccountLegalEntity]
    ON [Fact].[d_GLAccountLegalEntity]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

