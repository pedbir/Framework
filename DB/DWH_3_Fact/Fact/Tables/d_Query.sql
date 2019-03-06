CREATE TABLE [Fact].[d_Query] (
    [SysExecutionLog_key]      INT             NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)   NULL,
    [SysModifiedUTC]           DATETIME2 (0)   NOT NULL,
    [Query_key]                NVARCHAR (100)  NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)   NULL,
    [SysValidFromDateTime]     DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)   NULL,
    [SqlQuery]                 NVARCHAR (1500) NULL,
    [DatabaseName]             NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Fact_d_Query] PRIMARY KEY CLUSTERED ([Query_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Query]
    ON [Fact].[d_Query]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

