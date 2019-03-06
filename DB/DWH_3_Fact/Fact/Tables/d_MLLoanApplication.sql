CREATE TABLE [Fact].[d_MLLoanApplication] (
    [SysExecutionLog_key]                INT            NOT NULL,
    [SysDatetimeInsertedUTC]             DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]              DATETIME2 (0)  NULL,
    [SysModifiedUTC]                     DATETIME2 (0)  NOT NULL,
    [MLLoanApplication_key]              INT            NOT NULL,
    [SysDatetimeDeletedUTC]              DATETIME2 (0)  NULL,
    [SysIsInferred]                      BIT            NOT NULL,
    [SysValidFromDateTime]               DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]           DATETIME2 (0)  NULL,
    [MLLoanApplication_bkey]             NVARCHAR (100) NOT NULL,
    [ApplicationNumber]                  INT            NULL,
    [ApplicationLoanObjectId]            NVARCHAR (100) NULL,
    [ApplicationLoanObject]              NVARCHAR (150) NULL,
    [ApplicationPurposeId]               NVARCHAR (100) NULL,
    [ApplicationPurpose]                 NVARCHAR (150) NULL,
    [ApplicationRefusalId]               NVARCHAR (100) NULL,
    [ApplicationRefusal]                 NVARCHAR (150) NULL,
    [FinanceSegment_bkey]                NVARCHAR (100) NOT NULL,
    [ContactWayId]                       NVARCHAR (100) NULL,
    [ContactWay]                         NVARCHAR (150) NULL,
    [MediaCode]                          NVARCHAR (100) NULL,
    [Media]                              NVARCHAR (250) NULL,
    [MediaCategoryCode]                  NVARCHAR (100) NULL,
    [MediaCategoryName]                  NVARCHAR (250) NULL,
    [MediaTypeCode]                      NVARCHAR (100) NULL,
    [MediaType]                          NVARCHAR (250) NULL,
    [InterestBondCODE]                   NVARCHAR (100) NULL,
    [InterestBond]                       NVARCHAR (150) NULL,
    [ApplicationLoanTypeCODE]            NVARCHAR (100) NULL,
    [ApplicationLoanType]                NVARCHAR (150) NULL,
    [PriceLevel]                         NVARCHAR (50)  NULL,
    [ExportedToCerdoDate]                DATETIME       NULL,
    [PaidOutDate]                        DATETIME       NULL,
    [ContactDate]                        DATETIME       NULL,
    [LoanApplicationSource]              NVARCHAR (100) NULL,
    [IsDeclined]                         INT            NULL,
    [IsPayoutPlanned]                    INT            NULL,
    [CustomerSupportEmployee_CS_key]     INT            NULL,
    [CustomerSupportEmployee_CSG_key]    INT            NULL,
    [CustomerSupportEmployee_Credit_key] INT            NULL,
    [CampaignCODE]                       NVARCHAR (100) NULL,
    [CampaignName]                       NVARCHAR (100) NULL,
    [CustomerMainApplicant_key]          INT            NOT NULL,
    [CustomerCoApplicant_key]            INT            NOT NULL,
    CONSTRAINT [PK_Fact_d_MLLoanApplication] PRIMARY KEY CLUSTERED ([MLLoanApplication_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
) ON [Fact_Data];
















GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_MLLoanApplication]
    ON [Fact].[d_MLLoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];


GO


