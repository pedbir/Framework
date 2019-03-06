CREATE TABLE [Fact].[d_FinanceVendor] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [FinanceVendor_key]        INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [FinanceVendor_bkey]       NVARCHAR (100) NOT NULL,
    [FinanceVendorCode]        NVARCHAR (100) NULL,
    [FinanceVendorName]        NVARCHAR (250) NULL,
    [Status]                   NVARCHAR (3)   NULL,
    [UpdatedBy]                NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Fact_d_FinanceVendor] PRIMARY KEY CLUSTERED ([FinanceVendor_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_FinanceVendor]
    ON [Fact].[d_FinanceVendor]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

