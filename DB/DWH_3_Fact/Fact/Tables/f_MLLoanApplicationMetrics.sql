CREATE TABLE [Fact].[f_MLLoanApplicationMetrics] (
    [SysExecutionLog_key]               INT             NOT NULL,
    [SysDatetimeInsertedUTC]            DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]             DATETIME2 (0)   NULL,
    [SysModifiedUTC]                    DATETIME2 (0)   NOT NULL,
    [SysDatetimeDeletedUTC]             DATETIME2 (0)   NULL,
    [SysValidFromDateTime]              DATETIME2 (0)   NULL,
    [SysSrcGenerationDateTime]          DATETIME2 (0)   NULL,
    [MLLoanApplicationMetrics_key]      NVARCHAR (100)  NOT NULL,
    [MLLoanApplication_key]             INT             NULL,
    [MilestoneDate]                     DATETIME2 (3)   NULL,
    [ExportedToCerdoDate]               DATETIME        NULL,
    [MLLoanApplication_bkey]            NVARCHAR (100)  NULL,
    [ApplicationNumber]                 INT             NULL,
    [Calendar_MilestoneStart_key]       DATE            NULL,
    [Calendar_MilestoneEnd_key]         DATE            NULL,
    [Calendar_Contact_key]              DATE            NULL,
    [Calendar_ExportedToCerdoDate_bkey] DATE            NULL,
    [MLLoanApplicationStatus]           NVARCHAR (150)  NULL,
    [FinanceSegment_key]                INT             NULL,
    [MilestoneStatusName]               NVARCHAR (100)  NULL,
    [LoanApplicationSource]             NVARCHAR (100)  NULL,
    [PayoutAmount]                      MONEY           NULL,
    [ApplicationAmount]                 MONEY           NULL,
    [NoOfPayout]                        INT             NULL,
    [NoOfDeclined]                      INT             NULL,
    [NoOfApplication]                   INT             NULL,
    [Interest]                          NUMERIC (24, 8) NULL,
    [BaseRate]                          NUMERIC (24, 8) NULL,
    [InterestMargin]                    NUMERIC (24, 8) NULL,
    [ManualInterestMargin]              NUMERIC (24, 8) NULL,
    [RiskInterestRate]                  NUMERIC (18, 2) NULL,
    [InterestRateTotal]                 NUMERIC (18, 2) NULL,
    [IsPreAppLoanPromise]               INT             NULL,
    CONSTRAINT [PK_Fact_f_MLLoanApplicationMetrics] PRIMARY KEY CLUSTERED ([MLLoanApplicationMetrics_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);
















GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_MLLoanApplicationMetrics]
    ON [Fact].[f_MLLoanApplicationMetrics]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

