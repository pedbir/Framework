CREATE TABLE [Fact].[d_FinanceSegment] (
    [SysExecutionLog_key]              INT            NOT NULL,
    [SysDatetimeInsertedUTC]           DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]            DATETIME2 (0)  NULL,
    [SysModifiedUTC]                   DATETIME2 (0)  NOT NULL,
    [FinanceSegment_key]               INT            NOT NULL,
    [SysDatetimeDeletedUTC]            DATETIME2 (0)  NULL,
    [SysIsInferred]                    BIT            NOT NULL,
    [SysValidFromDateTime]             DATETIME2 (3)  NOT NULL,
    [SysSrcGenerationDateTime]         DATETIME2 (0)  NULL,
    [FinanceSegment_bkey]              NVARCHAR (100) NOT NULL,
    [FinanceSegmentGoldenCode]         NVARCHAR (100) NULL,
    [FinanceSegmentGoldenName]         NVARCHAR (250) NULL,
    [FinanceSegmentGoldenID]           INT            NULL,
    [FinanceSegmentGoldenCategoryCode] NVARCHAR (100) NULL,
    [FinanceSegmentGoldenCategoryName] NVARCHAR (250) NULL,
    CONSTRAINT [PK_Fact_d_FinanceSegment] PRIMARY KEY CLUSTERED ([FinanceSegment_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_FinanceSegment]
    ON [Fact].[d_FinanceSegment]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

