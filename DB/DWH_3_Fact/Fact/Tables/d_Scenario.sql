CREATE TABLE [Fact].[d_Scenario] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [Scenario_key]             INT            NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Scenario_bkey]            NVARCHAR (250) NOT NULL,
    [ScenarioName]             NVARCHAR (250) NULL,
    [ScenarioCategoryCode]     NVARCHAR (250) NULL,
    [ScenarioCategoryName]     NVARCHAR (250) NULL,
    [ScenarioSubCategoryCode]  NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_d_Scenario] PRIMARY KEY CLUSTERED ([Scenario_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Scenario]
    ON [Fact].[d_Scenario]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

