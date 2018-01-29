CREATE TABLE [Norm].[n_Scenario] (
    [Scenario_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [Scenario_bkey]             NVARCHAR (250) NOT NULL,
    [ScenarioName]              NVARCHAR (250) NULL,
    [ScenarioCategoryCode]      NVARCHAR (250) NULL,
    [ScenarioCategoryName]      NVARCHAR (250) NULL,
    [ScenarioSubCategoryCode]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_Scenario] PRIMARY KEY CLUSTERED ([Scenario_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Scenario]
    ON [Norm].[n_Scenario]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

