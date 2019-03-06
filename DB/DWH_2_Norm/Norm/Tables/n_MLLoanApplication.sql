CREATE TABLE [Norm].[n_MLLoanApplication] (
    [MLLoanApplication_key]             INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]               INT             NOT NULL,
    [SysDatetimeInsertedUTC]            DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]             DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]             DATETIME2 (0)   NULL,
    [SysDatetimeReprocessedUTC]         DATETIME2 (0)   NULL,
    [SysModifiedUTC]                    DATETIME2 (0)   NOT NULL,
    [SysIsInferred]                     BIT             NOT NULL,
    [SysValidFromDateTime]              DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime]          DATETIME2 (0)   NULL,
    [MLLoanApplication_bkey]            NVARCHAR (100)  NOT NULL,
    [ApplicationNumber]                 INT             NULL,
    [Amount]                            INT             NULL,
    [Calendar_PaidOutDate_bkey]         DATETIME        NULL,
    [Calendar_ExportedToCerdoDate_bkey] DATETIME        NULL,
    [Interest]                          NUMERIC (24, 8) NULL,
    [ApplicationLoanObjectId]           NVARCHAR (100)  NULL,
    [ApplicationLoanObject]             NVARCHAR (150)  NULL,
    [ApplicationPurposeId]              NVARCHAR (100)  NULL,
    [ApplicationPurpose]                NVARCHAR (150)  NULL,
    [ApplicationRefusalId]              NVARCHAR (100)  NULL,
    [ApplicationRefusal]                NVARCHAR (150)  NULL,
    [CustomerSupportEmployee_bkey]      NVARCHAR (100)  NULL,
    [FinanceSegment_bkey]               NVARCHAR (100)  NULL,
    [ContactWayId]                      NVARCHAR (100)  NULL,
    [ContactWay]                        NVARCHAR (150)  NULL,
    [MediaCode]                         NVARCHAR (100)  NULL,
    [Media]                             NVARCHAR (250)  NULL,
    [MediaCategoryCode]                 NVARCHAR (100)  NULL,
    [MediaCategoryName]                 NVARCHAR (250)  NULL,
    [MediaTypeCode]                     NVARCHAR (100)  NULL,
    [MediaType]                         NVARCHAR (250)  NULL,
    [ExportedToCerdoDate]               DATETIME        NULL,
    [BaseRate]                          NUMERIC (24, 8) NULL,
    [InterestMargin]                    NUMERIC (24, 8) NULL,
    [ManualInterestMargin]              NUMERIC (24, 8) NULL,
    [InterestBondCODE]                  NVARCHAR (100)  NULL,
    [InterestBond]                      NVARCHAR (150)  NULL,
    [ApplicationLoanTypeCODE]           NVARCHAR (100)  NULL,
    [ApplicationLoanType]               NVARCHAR (150)  NULL,
    [PriceLevel]                        NVARCHAR (50)   NULL,
    [Calendar_ContactDate_bkey]         DATETIME        NULL,
    [LoanApplicationSource]             NVARCHAR (100)  NULL,
    [RiskInterestRate]                  NUMERIC (18, 2) NULL,
    [RiskInterestDuration]              INT             NULL,
    [RiskInterestAmount]                INT             NULL,
    [InterestRateTotal]                 NUMERIC (18, 2) NULL,
    [LockRiskInterestRate]              INT             NULL,
    [CampaignCODE]                      NVARCHAR (100)  NULL,
    [CampaignName]                      NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Norm_n_MLLoanApplication] PRIMARY KEY CLUSTERED ([MLLoanApplication_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);
















GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_MLLoanApplication]
    ON [Norm].[n_MLLoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

