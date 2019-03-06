CREATE TABLE [Norm].[n_CostCenter] (
    [CostCenter_key]            INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [CostCenter_bkey]           NVARCHAR (100) NOT NULL,
    [CostCenterCode]            NVARCHAR (100) NULL,
    [CostCenterName]            NVARCHAR (250) NULL,
    [LegalEntity_bkey]          NVARCHAR (15)  NOT NULL,
    [Status]                    NVARCHAR (3)   NULL,
    [UpdatedBy]                 NVARCHAR (50)  NULL,
    [CostCenterManagerCode]     NVARCHAR (100) NULL,
    [CostCenterManger]          NVARCHAR (100) NULL,
    [SecondLineApproverCode]    NVARCHAR (100) NULL,
    [SecondLineApprover]        NVARCHAR (100) NULL,
    [DepartmentCode]            NVARCHAR (100) NULL,
    [Department]                NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_CostCenter] PRIMARY KEY CLUSTERED ([CostCenter_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_CostCenter]
    ON [Norm].[n_CostCenter]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

