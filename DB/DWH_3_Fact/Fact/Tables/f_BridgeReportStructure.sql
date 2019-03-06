CREATE TABLE [Fact].[f_BridgeReportStructure] (
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [BridgeReportStructure_key] INT            NOT NULL,
    [GLAccountLegalEntity_bkey] NVARCHAR (100) NULL,
    [ReportStructure_bkey]      NVARCHAR (100) NULL,
    [GLAccountLegalEntity_key]  INT            NULL,
    [ReportStructure_key]       INT            NULL,
    CONSTRAINT [PK_Fact_f_BridgeReportStructure] PRIMARY KEY CLUSTERED ([BridgeReportStructure_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_BridgeReportStructure]
    ON [Fact].[f_BridgeReportStructure]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

