CREATE TABLE [Fact].[b_MLLoanApplicationEmployee] (
    [SysExecutionLog_key]           INT            NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)  NULL,
    [SysValidFromDateTime]          DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)  NULL,
    [MLLoanApplicationEmployee_key] NVARCHAR (100) NOT NULL,
    [MLLoanApplication_bkey]        NVARCHAR (100) NULL,
    [CustomerSupportEmployee_bkey]  NVARCHAR (100) NULL,
    [EmployeeRoleID]                NVARCHAR (100) NULL,
    [MLLoanApplication_key]         INT            NULL,
    [CustomerSupportEmployee_key]   INT            NULL,
    [EmployeeRole]                  NVARCHAR (150) NULL,
    CONSTRAINT [PK_Fact_b_MLLoanApplicationEmployee] PRIMARY KEY CLUSTERED ([MLLoanApplicationEmployee_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_b_MLLoanApplicationEmployee]
    ON [Fact].[b_MLLoanApplicationEmployee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

