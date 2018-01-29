CREATE TABLE [Fact].[d_Access] (
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [Access_key]               INT           NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [Access_bkey]              INT           NOT NULL,
    [Calendar_Installed_bkey]  DATETIME      NULL,
    [AccessCategory_Lvl1_bkey] INT           NOT NULL,
    [AccessCategory_Lvl2_bkey] INT           NOT NULL,
    [AccessCategory_Lvl3_bkey] INT           NOT NULL,
    [AccessCategory_Lvl4_bkey] INT           NOT NULL,
    [AccessCategory_Lvl5_bkey] INT           NOT NULL,
    CONSTRAINT [PK_Fact_d_Access] PRIMARY KEY CLUSTERED ([Access_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Access]
    ON [Fact].[d_Access]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

