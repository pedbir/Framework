CREATE TABLE [Fact].[d_AllocationPrinciple] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [AllocationPrinciple_key]  INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [AllocationPrinciple_bkey] NVARCHAR (50)  NULL,
    [AllocationPrincipleName]  NVARCHAR (255) NULL,
    CONSTRAINT [PK_Fact_d_AllocationPrinciple] PRIMARY KEY CLUSTERED ([AllocationPrinciple_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_AllocationPrinciple]
    ON [Fact].[d_AllocationPrinciple]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

