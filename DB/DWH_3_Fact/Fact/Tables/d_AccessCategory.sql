CREATE TABLE [Fact].[d_AccessCategory] (
    [SysExecutionLog_key]    INT            NOT NULL,
    [SysDatetimeInsertedUTC] DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]         DATETIME2 (0)  NOT NULL,
    [AccessCategory_key]     INT            NOT NULL,
    [SysDatetimeDeletedUTC]  DATETIME2 (0)  NULL,
    [SysIsInferred]          BIT            NOT NULL,
    [SysValidFromDateTime]   DATETIME2 (0)  NOT NULL,
    [AccessCategory_bkey]    INT            NOT NULL,
    [AccessCategory]         NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_d_AccessCategory] PRIMARY KEY CLUSTERED ([AccessCategory_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_AccessCategory]
    ON [Fact].[d_AccessCategory]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

