CREATE TABLE [Norm].[n_GeneralLedger] (
    [GeneralLedger_key]             INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]           INT             NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)   NULL,
    [SysDatetimeReprocessedUTC]     DATETIME2 (0)   NULL,
    [SysModifiedUTC]                DATETIME2 (0)   NOT NULL,
    [SysIsInferred]                 BIT             NOT NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)   NOT NULL,
    [SysValidFromDateTime]          DATETIME2 (0)   NOT NULL,
    [GeneralLedger_bkey]            NVARCHAR (250)  NOT NULL,
    [Vouchertype]                   NVARCHAR (6)    NULL,
    [Voucherno]                     INT             NULL,
    [Sequenceno]                    INT             NULL,
    [GLAccount_bkey]                NVARCHAR (100)  NULL,
    [LegalEntity_bkey]              NVARCHAR (100)  NULL,
    [Calender_Voucherdate_bkey]     DATETIME        NULL,
    [Calender_ReportingPeriod_bkey] DATETIME        NULL,
    [CostCenter_bkey]               NVARCHAR (100)  NULL,
    [Project_bkey]                  NVARCHAR (100)  NULL,
    [FinanceProduct_bkey]           NVARCHAR (100)  NULL,
    [FinanceAnalysis_bkey]          NVARCHAR (100)  NULL,
    [FinanceCounterparty_bkey]      NVARCHAR (100)  NULL,
    [FinanceSegment_bkey]           NVARCHAR (100)  NULL,
    [FinanceCustomer_bkey]          NVARCHAR (100)  NULL,
    [FinanceVendor_bkey]            NVARCHAR (100)  NULL,
    [GLAccountLegalEntity_bkey]     NVARCHAR (100)  NULL,
    [Currency_bkey]                 NVARCHAR (20)   NULL,
    [GLDescription]                 NVARCHAR (1000) NULL,
    [ExtInvoiceRef]                 NVARCHAR (250)  NULL,
    [AmountLCY]                     DECIMAL (18)    NULL,
    [AmountTCY]                     DECIMAL (18)    NULL,
    CONSTRAINT [PK_Norm_n_GeneralLedger] PRIMARY KEY CLUSTERED ([GeneralLedger_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);












GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_GeneralLedger]
    ON [Norm].[n_GeneralLedger]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

