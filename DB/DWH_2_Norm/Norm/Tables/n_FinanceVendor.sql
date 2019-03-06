CREATE TABLE [Norm].[n_FinanceVendor] (
    [FinanceVendor_key]         INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [FinanceVendor_bkey]        NVARCHAR (100) NOT NULL,
    [FinanceVendorCode]         NVARCHAR (100) NULL,
    [FinanceVendorName]         NVARCHAR (250) NULL,
    [LegalEntity_bkey]          NVARCHAR (15)  NOT NULL,
    [Status]                    NVARCHAR (3)   NULL,
    [UpdatedBy]                 NVARCHAR (50)  NULL,
    [CostCenter_bkey]           NVARCHAR (100) NULL,
    [FinanceSegment_bkey]       NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_FinanceVendor] PRIMARY KEY CLUSTERED ([FinanceVendor_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_FinanceVendor]
    ON [Norm].[n_FinanceVendor]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

