CREATE TABLE [Norm].[n_MLLoanApplicationMilestone] (
    [SysExecutionLog_key]             INT            NOT NULL,
    [SysDatetimeInsertedUTC]          DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]           DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]           DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]       DATETIME2 (0)  NULL,
    [SysModifiedUTC]                  DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]            DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]        DATETIME2 (0)  NULL,
    [MLLoanApplicationMilestone_bkey] NVARCHAR (100) NOT NULL,
    [MLLoanApplication_bkey]          NVARCHAR (100) NULL,
    [ApplicationNumber]               INT            NULL,
    [MLLoanApplicationStatus]         NVARCHAR (150) NULL,
    [CustomerSupportEmployee_bkey]    NVARCHAR (100) NULL,
    [Calendar_Milestone_bkey]         DATETIME       NULL,
    [Calendar_Contact_bkey]           DATETIME       NULL,
    [MilestoneDate]                   DATETIME2 (3)  NULL,
    [IsContact]                       INT            NULL,
    [IsLead]                          INT            NULL,
    [IsQLead]                         INT            NULL,
    [IsApplication]                   INT            NULL,
    [IsPayout]                        INT            NULL,
    [IsPreAppLoanPromise]             INT            NULL,
    [IsDeclined]                      INT            NULL,
    [LoanApplicationSource]           NVARCHAR (100) NULL,
    [FinanceSegment_bkey]             NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_MLLoanApplicationMilestone] PRIMARY KEY CLUSTERED ([MLLoanApplicationMilestone_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);












GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_MLLoanApplicationMilestone]
    ON [Norm].[n_MLLoanApplicationMilestone]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO



GO



GO



GO



GO



GO



GO


