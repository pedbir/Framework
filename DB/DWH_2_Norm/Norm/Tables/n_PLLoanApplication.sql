CREATE TABLE [Norm].[n_PLLoanApplication] (
    [PLLoanApplication_key]                INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]                  INT            NOT NULL,
    [SysDatetimeInsertedUTC]               DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]                DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]                DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]            DATETIME2 (0)  NULL,
    [SysModifiedUTC]                       DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                        BIT            NOT NULL,
    [SysValidFromDateTime]                 DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]             DATETIME2 (0)  NULL,
    [PLLoanApplication_bkey]               INT            NOT NULL,
    [ApplicationSourceId]                  NVARCHAR (512) NULL,
    [ApplicationId]                        INT            NULL,
    [Calendar_Registration_bkey]           DATETIME       NULL,
    [Calendar_Decision_bkey]               DATETIME       NULL,
    [UcapLkp_LatestS1Decision_bkey]        NVARCHAR (100) NULL,
    [UcapLkp_CurrentDecision_bkey]         NVARCHAR (100) NULL,
    [UcapLkp_SelectedProduct_bkey]         NVARCHAR (100) NULL,
    [UcapLkp_RegistrationChannelType_bkey] NVARCHAR (100) NULL,
    [UcapLkp_RepaymentPeriodCategory_bkey] NVARCHAR (100) NULL,
    [UcapLkp_LoanPurposeType]              NVARCHAR (100) NULL,
    [UcapLkp_MediaChannelType_bkey]        NVARCHAR (100) NULL,
    [UcapLkp_DWHPosition_bkey]             NVARCHAR (100) NULL,
    [UcapLkp_DWHPositionStatus_bkey]       NVARCHAR (100) NULL,
    [AppliedAmount]                        MONEY          NULL,
    [GrantedAmount]                        MONEY          NULL,
    CONSTRAINT [PK_Norm_n_PLLoanApplication] PRIMARY KEY CLUSTERED ([PLLoanApplication_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_PLLoanApplication]
    ON [Norm].[n_PLLoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO


