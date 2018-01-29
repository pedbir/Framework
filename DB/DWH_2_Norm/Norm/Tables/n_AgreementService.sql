CREATE TABLE [Norm].[n_AgreementService] (
    [AgreementService_key]      INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NULL,
    [AgreementService_bkey]     INT           NOT NULL,
    [Agreement_bkey]            INT           NOT NULL,
    [Service_bkey]              INT           NOT NULL,
    [ServiceStatus_bkey]        INT           NOT NULL,
    [Unit_bkey]                 INT           NOT NULL,
    [Site_bkey]                 INT           NOT NULL,
    [Connection_bkey]           NVARCHAR (50) NOT NULL,
    [FirstInvoiceDate]          DATETIME      NULL,
    [InstallationReadyDate]     DATETIME      NULL,
    [LastInvoiceDate]           DATETIME      NULL,
    [TerminationNoticeDate]     DATETIME      NULL,
    [ReplaceNoticeDate]         DATETIME      NULL,
    [Currency]                  NVARCHAR (3)  NULL,
    [MRC]                       MONEY         NOT NULL,
    [NRC]                       MONEY         NOT NULL,
    [Quantity]                  INT           NOT NULL,
    [IsReneg]                   BIT           NOT NULL,
    CONSTRAINT [PK_Norm_n_AgreementService] PRIMARY KEY CLUSTERED ([AgreementService_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_AgreementService]
    ON [Norm].[n_AgreementService]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

