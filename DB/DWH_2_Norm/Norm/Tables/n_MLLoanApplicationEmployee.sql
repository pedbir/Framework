CREATE TABLE [Norm].[n_MLLoanApplicationEmployee] (
    [SysExecutionLog_key]            INT            NOT NULL,
    [SysDatetimeInsertedUTC]         DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]                 DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]           DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]       DATETIME2 (0)  NULL,
    [MLLoanApplicationEmployee_bkey] NVARCHAR (100) NOT NULL,
    [MLLoanApplication_bkey]         NVARCHAR (100) NULL,
    [CustomerSupportEmployee_bkey]   NVARCHAR (100) NULL,
    [EmployeeRoleID]                 NVARCHAR (100) NULL,
    [EmployeeRole]                   NVARCHAR (150) NULL,
    CONSTRAINT [PK_Norm_n_MLLoanApplicationEmployee] PRIMARY KEY CLUSTERED ([MLLoanApplicationEmployee_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_MLLoanApplicationEmployee]
    ON [Norm].[n_MLLoanApplicationEmployee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

