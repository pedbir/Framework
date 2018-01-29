CREATE TABLE [Norm].[n_Employee] (
    [Employee_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [Employee_bkey]             NVARCHAR (100) NOT NULL,
    [EmployeeName]              NVARCHAR (150) NULL,
    [Title]                     NVARCHAR (50)  NULL,
    [Department]                NVARCHAR (50)  NULL,
    [EmployeeStatus]            NVARCHAR (100) NULL,
    [Username]                  NVARCHAR (100) NULL,
    [EmployeeRoleName]          VARCHAR (29)   NULL,
    [EmployeeRoleCode]          VARCHAR (3)    NULL,
    CONSTRAINT [PK_Norm_n_Employee] PRIMARY KEY CLUSTERED ([Employee_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Employee]
    ON [Norm].[n_Employee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

