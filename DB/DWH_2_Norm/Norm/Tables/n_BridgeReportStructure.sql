CREATE TABLE [Norm].[n_BridgeReportStructure] (
    [BridgeReportStructure_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]        INT            NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]             DATETIME2 (0)  NOT NULL,
    [SysIsInferred]              BIT            NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0)  NOT NULL,
    [BridgeReportStructure_bkey] INT            NOT NULL,
    [GLAccount_bkey]             NVARCHAR (100) NULL,
    [LegalEntity_bkey]           NVARCHAR (100) NULL,
    [GLAccountLegalEntity_bkey]  NVARCHAR (100) NULL,
    [ReportStructure_bkey]       NVARCHAR (100) NULL,
    [UserId]                     NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Norm_n_BridgeReportStructure] PRIMARY KEY CLUSTERED ([BridgeReportStructure_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_BridgeReportStructure]
    ON [Norm].[n_BridgeReportStructure]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

