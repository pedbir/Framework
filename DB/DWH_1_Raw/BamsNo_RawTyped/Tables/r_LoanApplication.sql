CREATE TABLE [BamsNo_RawTyped].[r_LoanApplication] (
    [LoanApplication_key]       INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT             NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)   NULL,
    [SysModifiedUTC]            DATETIME2 (0)   NOT NULL,
    [SysIsInferred]             BIT             NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)   NULL,
    [LoanApplication_bkey]      NVARCHAR (100)  NOT NULL,
    [ApplicationNumber]         INT             NULL,
    [Amount]                    INT             NULL,
    [PaidOutDate]               DATETIME        NULL,
    [Interest]                  NUMERIC (18, 2) NULL,
    [ApplicationLoanObjectCODE] NVARCHAR (100)  NULL,
    [ApplicationLoanObject]     NVARCHAR (150)  NULL,
    [ApplicationPurposeCODE]    NVARCHAR (100)  NULL,
    [ApplicationPurpose]        NVARCHAR (150)  NULL,
    [ApplicationRefusalCODE]    NVARCHAR (100)  NULL,
    [ApplicationRefusal]        NVARCHAR (150)  NULL,
    [ContactWayCODE]            NVARCHAR (100)  NULL,
    [ContactWay]                NVARCHAR (150)  NULL,
    [MediaCode]                 NVARCHAR (100)  NULL,
    [Media]                     NVARCHAR (150)  NULL,
    [CreateDate]                DATETIME        NULL,
    [UpdateDate]                DATETIME        NULL,
    [UpdatedByUser]             NVARCHAR (100)  NULL,
    [ExportedToCerdoDate]       DATETIME        NULL,
    [BaseRate]                  NUMERIC (18, 2) NULL,
    [InterestMargin]            NUMERIC (18, 2) NULL,
    [ManualInterestMargin]      NUMERIC (18, 2) NULL,
    [InterestBondCODE]          NVARCHAR (100)  NULL,
    [InterestBond]              NVARCHAR (150)  NULL,
    [ApplicationLoanTypeCODE]   NVARCHAR (100)  NULL,
    [ApplicationLoanType]       NVARCHAR (150)  NULL,
    [PriceLevel]                NVARCHAR (50)   NULL,
    [RiskInterestRate]          NUMERIC (18, 2) NULL,
    [RiskInterestDuration]      INT             NULL,
    [RiskInterestAmount]        INT             NULL,
    [InterestRateTotal]         NUMERIC (18, 2) NULL,
    [LockRiskInterestRate]      INT             NULL,
    [CampaignCODE]              NVARCHAR (100)  NULL,
    [CampaignName]              NVARCHAR (100)  NULL,
    CONSTRAINT [PK_BamsNo_RawTyped_r_LoanApplication] PRIMARY KEY CLUSTERED ([LoanApplication_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);












GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsNo_RawTyped_r_LoanApplication]
    ON [BamsNo_RawTyped].[r_LoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);



