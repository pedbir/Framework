CREATE TABLE [Fact].[d_FinanceAnalysis] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [FinanceAnalysis_key]      INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [FinanceAnalysis_bkey]     NVARCHAR (100) NOT NULL,
    [FinanceAnalysisCode]      NVARCHAR (100) NULL,
    [FinanceAnalysisName]      NVARCHAR (250) NULL,
    [Status]                   NVARCHAR (3)   NULL,
    [UpdatedBy]                NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Fact_d_FinanceAnalysis] PRIMARY KEY CLUSTERED ([FinanceAnalysis_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_FinanceAnalysis]
    ON [Fact].[d_FinanceAnalysis]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

