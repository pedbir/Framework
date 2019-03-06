CREATE TABLE [Fact].[d_Currency] (
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [Currency_key]             INT           NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [Currency_bkey]            NVARCHAR (3)  NULL,
    [CurrencyName]             NVARCHAR (15) NULL,
    CONSTRAINT [PK_Fact_d_Currency] PRIMARY KEY CLUSTERED ([Currency_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Currency]
    ON [Fact].[d_Currency]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

