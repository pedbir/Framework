CREATE TABLE [Norm].[n_MLLoanApplicationCustomer] (
    [SysExecutionLog_key]            INT            NOT NULL,
    [SysDatetimeInsertedUTC]         DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]                 DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]           DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]       DATETIME2 (0)  NULL,
    [MLLoanApplicationCustomer_bkey] NVARCHAR (100) NOT NULL,
    [MLLoanCustomer_bkey]            NVARCHAR (100) NULL,
    [MLLoanApplication_bkey]         NVARCHAR (100) NULL,
    [IsMainApplicant]                BIT            NULL,
    [CustomerSource]                 NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Norm_n_MLLoanApplicationCustomer] PRIMARY KEY CLUSTERED ([MLLoanApplicationCustomer_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
) ON [Norm_Data];






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_MLLoanApplicationCustomer]
    ON [Norm].[n_MLLoanApplicationCustomer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO
CREATE NONCLUSTERED INDEX [NCIDX_IsMainApplicant_Norm_n_MLLoanApplicationCustomer]
    ON [Norm].[n_MLLoanApplicationCustomer]([MLLoanApplication_bkey] ASC, [IsMainApplicant] ASC, [SysValidFromDateTime] DESC)
    INCLUDE([SysModifiedUTC], [MLLoanCustomer_bkey]) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

