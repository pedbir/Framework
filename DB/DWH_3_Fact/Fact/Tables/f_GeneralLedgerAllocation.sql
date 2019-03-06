CREATE TABLE [Fact].[f_GeneralLedgerAllocation] (
    [SysExecutionLog_key]           INT            NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]          DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)  NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)  NULL,
    [GeneralLedgerAllocation_key]   NVARCHAR (50)  NOT NULL,
    [AllocationPrinciple_bkey]      NVARCHAR (50)  NOT NULL,
    [GLAccount_bkey]                NVARCHAR (100) NULL,
    [LegalEntity_bkey]              NVARCHAR (100) NULL,
    [Calender_ReportingPeriod_bkey] DATETIME       NULL,
    [CostCenter_bkey]               NVARCHAR (100) NULL,
    [Project_bkey]                  NVARCHAR (100) NULL,
    [FinanceProduct_bkey]           NVARCHAR (100) NULL,
    [FinanceAnalysis_bkey]          NVARCHAR (100) NULL,
    [FinanceCounterparty_bkey]      NVARCHAR (100) NULL,
    [FinanceSegment_bkey]           NVARCHAR (100) NULL,
    [FinanceCustomer_bkey]          NVARCHAR (100) NULL,
    [FinanceVendor_bkey]            NVARCHAR (100) NULL,
    [GLAccount_key]                 INT            NULL,
    [LegalEntity_key]               INT            NULL,
    [CostCenter_key]                INT            NULL,
    [Project_key]                   INT            NULL,
    [FinanceProduct_key]            INT            NULL,
    [FinanceAnalysis_key]           INT            NULL,
    [FinanceCounterparty_key]       INT            NULL,
    [FinanceSegment_key]            INT            NULL,
    [FinanceCustomer_key]           INT            NULL,
    [FinanceVendor_key]             INT            NULL,
    [Currency_key]                  INT            NULL,
    [AllocationPrinciple_key]       INT            NULL,
    [AmountLCY]                     FLOAT (53)     NULL,
    [AmountTCY]                     FLOAT (53)     NULL,
    [GLAccountLegalEntity_key]      INT            NULL,
    CONSTRAINT [PK_Fact_f_GeneralLedgerAllocation] PRIMARY KEY CLUSTERED ([GeneralLedgerAllocation_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_GeneralLedgerAllocation]
    ON [Fact].[f_GeneralLedgerAllocation]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

