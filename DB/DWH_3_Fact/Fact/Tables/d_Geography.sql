CREATE TABLE [Fact].[d_Geography] (
    [SysExecutionLog_key]        INT            NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]             DATETIME2 (0)  NOT NULL,
    [Geography_key]              INT            NOT NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0)  NULL,
    [SysIsInferred]              BIT            NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0)  NULL,
    [Geography_bkey]             NVARCHAR (100) NOT NULL,
    [GeographyName]              NVARCHAR (255) NULL,
    [SugarEnum_Municipality_key] INT            NOT NULL,
    [SugarEnum_State_key]        INT            NOT NULL,
    [SugarEnum_Region_key]       INT            NOT NULL,
    CONSTRAINT [PK_Fact_d_Geography] PRIMARY KEY CLUSTERED ([Geography_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Geography]
    ON [Fact].[d_Geography]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

