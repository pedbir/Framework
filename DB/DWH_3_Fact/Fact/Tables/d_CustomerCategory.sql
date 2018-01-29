CREATE TABLE [Fact].[d_CustomerCategory] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [CustomerCategory_key]     INT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [CustomerCategory_bkey]    INT            NOT NULL,
    [CustomerCategoryCode]     NVARCHAR (250) NOT NULL,
    [CustomerCategory]         NVARCHAR (250) NULL,
    [SalesHierarchy]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_d_CustomerCategory] PRIMARY KEY CLUSTERED ([CustomerCategory_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_CustomerCategory]
    ON [Fact].[d_CustomerCategory]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

