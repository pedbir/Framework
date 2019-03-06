CREATE TABLE [Fact].[d_CostCenter] (
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [CostCenter_key]            INT            NOT NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [CostCenter_bkey]           NVARCHAR (100) NOT NULL,
    [CostCenterCode]            NVARCHAR (100) NULL,
    [CostCenter]                NVARCHAR (250) NULL,
    [Status]                    NVARCHAR (3)   NULL,
    [UpdatedBy]                 NVARCHAR (50)  NULL,
    [CostCenterManagerCode]     NVARCHAR (100) NULL,
    [CostCenterManger]          NVARCHAR (100) NULL,
    [SecondLineApproverCode]    NVARCHAR (100) NULL,
    [SecondLineApprover]        NVARCHAR (100) NULL,
    [DepartmentCode]            NVARCHAR (100) NULL,
    [Department]                NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_d_CostCenter] PRIMARY KEY CLUSTERED ([CostCenter_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_CostCenter]
    ON [Fact].[d_CostCenter]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

