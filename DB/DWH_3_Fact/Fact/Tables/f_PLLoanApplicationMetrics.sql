CREATE TABLE [Fact].[f_PLLoanApplicationMetrics] (
    [SysExecutionLog_key]                 INT            NOT NULL,
    [SysDatetimeInsertedUTC]              DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]               DATETIME2 (0)  NULL,
    [SysModifiedUTC]                      DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]               DATETIME2 (0)  NULL,
    [SysValidFromDateTime]                DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]            DATETIME2 (0)  NULL,
    [PLLoanApplicationMetrics_key]        NVARCHAR (512) NOT NULL,
    [ApplicationNumber]                   NVARCHAR (512) NULL,
    [ApplicationId]                       INT            NULL,
    [Calendar_bkey]                       DATE           NULL,
    [UcapLkp_LatestS1Decision_key]        INT            NULL,
    [UcapLkp_CurrentDecision_key]         INT            NULL,
    [UcapLkp_SelectedProduct_key]         INT            NULL,
    [UcapLkp_RegistrationChannelType_key] INT            NULL,
    [UcapLkp_RepaymentPeriodCategory_key] INT            NULL,
    [UcapLkp_LoanPurposeType_key]         INT            NULL,
    [UcapLkp_MediaChannelType_key]        INT            NULL,
    [UcapLkp_DWHPosition_key]             INT            NULL,
    [UcapLkp_DWHPositionStatus_key]       INT            NULL,
    [FinanceSegment_bkey]                 NVARCHAR (100) NULL,
    [FinanceSegment_key]                  INT            NULL,
    [AppliedAmount]                       MONEY          NULL,
    [GrantedAmount]                       MONEY          NULL,
    CONSTRAINT [PK_Fact_f_PLLoanApplicationMetrics] PRIMARY KEY CLUSTERED ([PLLoanApplicationMetrics_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_PLLoanApplicationMetrics]
    ON [Fact].[f_PLLoanApplicationMetrics]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

