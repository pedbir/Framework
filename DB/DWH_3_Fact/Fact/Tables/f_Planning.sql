CREATE TABLE [Fact].[f_Planning] (
    [SysExecutionLog_key]    INT            NOT NULL,
    [SysDatetimeInsertedUTC] DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]         DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]  DATETIME2 (0)  NULL,
    [SysValidFromDateTime]   DATETIME2 (0)  NOT NULL,
    [Planning_key]           NVARCHAR (229) NOT NULL,
    [Calendar_key]           INT            NULL,
    [CustomerCategory_key]   INT            NOT NULL,
    [Scenario_bkey]          NVARCHAR (250) NULL,
    [Scenario_key]           INT            NOT NULL,
    [Phase_bkey]             NVARCHAR (250) NULL,
    [PlanningPeriod]         NVARCHAR (128) NULL,
    [Amount]                 NUMERIC (38)   NULL,
    CONSTRAINT [PK_Fact_f_Planning] PRIMARY KEY CLUSTERED ([Planning_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_Planning]
    ON [Fact].[f_Planning]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

