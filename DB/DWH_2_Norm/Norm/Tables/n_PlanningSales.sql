CREATE TABLE [Norm].[n_PlanningSales] (
    [PlanningSales_key]         INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [PlanningSales_bkey]        NVARCHAR (100) NOT NULL,
    [FinanceSegment_bkey]       NVARCHAR (250) NULL,
    [PlanningMetricCode]        NVARCHAR (250) NULL,
    [PlanningMetric]            NVARCHAR (250) NULL,
    [PlanningScenarioCode]      NVARCHAR (250) NULL,
    [PlanningScenario]          NVARCHAR (250) NULL,
    [PeriodCode]                NVARCHAR (128) NULL,
    [Calendar_Period_bkey]      DATETIME       NULL,
    [PlanningAmount]            MONEY          NULL,
    [EnterUserName]             NVARCHAR (100) NULL,
    [LastChgUserName]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_PlanningSales] PRIMARY KEY CLUSTERED ([PlanningSales_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_PlanningSales]
    ON [Norm].[n_PlanningSales]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

