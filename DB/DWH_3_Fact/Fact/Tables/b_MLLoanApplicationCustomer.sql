CREATE TABLE [Fact].[b_MLLoanApplicationCustomer] (
    [SysExecutionLog_key]           INT            NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)  NULL,
    [SysValidFromDateTime]          DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)  NULL,
    [MLLoanApplicationCustomer_key] NVARCHAR (100) NOT NULL,
    [MLLoanApplication_bkey]        NVARCHAR (100) NULL,
    [MLLoanCustomer_bkey]           NVARCHAR (100) NULL,
    [MLLoanApplication_key]         INT            NULL,
    [MLLoanCustomer_key]            INT            NULL,
    [IsMainApplicant]               BIT            NULL,
    [CustomerSource]                NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Fact_b_MLLoanApplicationCustomer] PRIMARY KEY CLUSTERED ([MLLoanApplicationCustomer_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_b_MLLoanApplicationCustomer]
    ON [Fact].[b_MLLoanApplicationCustomer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

