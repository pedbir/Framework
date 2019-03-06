CREATE TABLE [Fact].[d_Fields] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [Fields_key]               INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [Fields_bkey]              INT            NOT NULL,
    [TableName]                NVARCHAR (100) NULL,
    [ColumnName]               NVARCHAR (100) NULL,
    [Category]                 NVARCHAR (5)   NULL,
    CONSTRAINT [PK_Fact_d_Fields] PRIMARY KEY CLUSTERED ([Fields_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Fields]
    ON [Fact].[d_Fields]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

