CREATE TABLE [Fact].[f_PlanningSales] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [PlanningSales_key]        NVARCHAR (100) NOT NULL,
    [FinanceSegment_key]       INT            NULL,
    [FinanceSegment_bkey]      NVARCHAR (250) NULL,
    [PlanningMetricCode]       NVARCHAR (250) NULL,
    [PlanningMetric]           NVARCHAR (250) NULL,
    [PeriodCode]               NVARCHAR (128) NULL,
    [PlanningScenarioCode]     NVARCHAR (250) NULL,
    [PlanningScenario]         NVARCHAR (250) NULL,
    [Calendar_Period_key]      DATE           NULL,
    [PlanningAmount]           MONEY          NULL,
    [EnterUserName]            NVARCHAR (100) NULL,
    [LastChgUserName]          NVARCHAR (100) NULL,
    CONSTRAINT [PK_Fact_f_PlanningSales] PRIMARY KEY CLUSTERED ([PlanningSales_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_PlanningSales]
    ON [Fact].[f_PlanningSales]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

