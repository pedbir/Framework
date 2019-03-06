CREATE TABLE [Fact].[f_GeneralLedger] (
    [SysExecutionLog_key]           INT             NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)   NULL,
    [SysModifiedUTC]                DATETIME2 (0)   NOT NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)   NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)   NOT NULL,
    [SysValidFromDateTime]          DATETIME2 (0)   NOT NULL,
    [GeneralLedger_key]             NVARCHAR (250)  NOT NULL,
    [Vouchertype]                   NVARCHAR (6)    NULL,
    [Voucherno]                     INT             NULL,
    [Sequenceno]                    INT             NULL,
    [GLDescription]                 NVARCHAR (1000) NULL,
    [ExtInvoiceRef]                 NVARCHAR (250)  NULL,
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
    [Currency_bkey]                 NVARCHAR (20)   NULL,
    [GLAccountLegalEntity_bkey]     NVARCHAR (100)  NULL,
    [GLAccount_key]                 INT             NULL,
    [LegalEntity_key]               INT             NULL,
    [CostCenter_key]                INT             NULL,
    [Project_key]                   INT             NULL,
    [FinanceProduct_key]            INT             NULL,
    [FinanceAnalysis_key]           INT             NULL,
    [FinanceCounterparty_key]       INT             NULL,
    [FinanceSegment_key]            INT             NULL,
    [FinanceCustomer_key]           INT             NULL,
    [FinanceVendor_key]             INT             NULL,
    [GLAccountLegalEntity_key]      INT             NULL,
    [Currency_key]                  INT             NULL,
    [AmountLCY]                     DECIMAL (18)    NULL,
    [AmountTCY]                     DECIMAL (18)    NULL,
    [AllocationPrinciple_key]       INT             NULL,
    CONSTRAINT [PK_Fact_f_GeneralLedger] PRIMARY KEY CLUSTERED ([GeneralLedger_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_GeneralLedger]
    ON [Fact].[f_GeneralLedger]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

