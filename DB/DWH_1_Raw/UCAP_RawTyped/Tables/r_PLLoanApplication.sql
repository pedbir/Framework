CREATE TABLE [UCAP_RawTyped].[r_PLLoanApplication] (
    [PLLoanApplication_key]     INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [PLLoanApplication_bkey]    INT            NOT NULL,
    [ApplicationSourceId]       NVARCHAR (512) NULL,
    [ApplicationId]             INT            NULL,
    [RegistrationDate]          DATETIME       NULL,
    [DecisionDate]              DATETIME       NULL,
    [LatestS1DecisionId]        NVARCHAR (100) NULL,
    [CurrentDecisionId]         NVARCHAR (255) NULL,
    [SelectedProductId]         INT            NULL,
    [RegistrationChannelTypeId] NVARCHAR (50)  NULL,
    [RepaymentPeriodCategoryId] NVARCHAR (50)  NULL,
    [LoanPurposeTypeId]         NVARCHAR (50)  NULL,
    [MediaChannelTypeId]        NVARCHAR (50)  NULL,
    [DWHPositionId]             INT            NULL,
    [AppliedAmount]             MONEY          NULL,
    [GrantedAmount]             MONEY          NULL,
    CONSTRAINT [PK_Ucap_RawTyped_r_PLLoanApplication] PRIMARY KEY CLUSTERED ([PLLoanApplication_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Ucap_RawTyped_r_PLLoanApplication]
    ON [UCAP_RawTyped].[r_PLLoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

