CREATE TABLE [Norm].[n_FinanceSegment] (
    [FinanceSegment_key]               INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]              INT            NOT NULL,
    [SysDatetimeInsertedUTC]           DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]            DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]            DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]        DATETIME2 (0)  NULL,
    [SysModifiedUTC]                   DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                    BIT            NOT NULL,
    [SysValidFromDateTime]             DATETIME2 (3)  NOT NULL,
    [SysSrcGenerationDateTime]         DATETIME2 (0)  NULL,
    [FinanceSegment_bkey]              NVARCHAR (100) NOT NULL,
    [FinanceSegmentName]               NVARCHAR (250) NULL,
    [SourceSystemName]                 NVARCHAR (250) NULL,
    [SourceSystemID]                   INT            NULL,
    [FinanceSegmentGoldenCode]         NVARCHAR (100) NULL,
    [FinanceSegmentGoldenName]         NVARCHAR (250) NULL,
    [FinanceSegmentGoldenID]           INT            NULL,
    [FinanceSegmentGoldenCategoryCode] NVARCHAR (100) NULL,
    [FinanceSegmentGoldenCategoryName] NVARCHAR (250) NULL,
    CONSTRAINT [PK_Norm_n_FinanceSegment] PRIMARY KEY CLUSTERED ([FinanceSegment_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_FinanceSegment]
    ON [Norm].[n_FinanceSegment]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

