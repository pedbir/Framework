CREATE TABLE [Fact].[d_Employee] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [Employee_key]             INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Employee_bkey]            NVARCHAR (100) NOT NULL,
    [EmployeeName]             NVARCHAR (150) NOT NULL,
    [Title]                    NVARCHAR (50)  NOT NULL,
    [Department]               NVARCHAR (50)  NOT NULL,
    [EmployeeStatus]           NVARCHAR (100) NOT NULL,
    [EmployeeRoleCode]         VARCHAR (3)    NOT NULL,
    [EmployeeRoleName]         VARCHAR (29)   NOT NULL,
    CONSTRAINT [PK_Fact_d_Employee] PRIMARY KEY CLUSTERED ([Employee_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Employee]
    ON [Fact].[d_Employee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

