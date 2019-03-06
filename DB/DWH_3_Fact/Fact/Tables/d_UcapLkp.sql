CREATE TABLE [Fact].[d_UcapLkp] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [UcapLkp_key]              INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [UcapLkp_bkey]             NVARCHAR (100) NOT NULL,
    [UcapLkpId]                NVARCHAR (100) NULL,
    [UcapLkpDomain]            VARCHAR (32)   NULL,
    [UcapLkpValue]             NVARCHAR (512) NULL,
    CONSTRAINT [PK_Fact_d_UcapLkp] PRIMARY KEY CLUSTERED ([UcapLkp_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_UcapLkp]
    ON [Fact].[d_UcapLkp]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

