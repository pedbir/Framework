CREATE TABLE [Fact].[f_DailyQueryMetrics] (
    [SysExecutionLog_key]    INT            NOT NULL,
    [SysDatetimeInsertedUTC] DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]         DATETIME2 (0)  NOT NULL,
    [DailyQueryMetrics_key]  NVARCHAR (100) NOT NULL,
    [Query_key]              NVARCHAR (100) NOT NULL,
    [Calendar_key]           DATE           NULL,
    [SysDatetimeDeletedUTC]  DATETIME2 (0)  NULL,
    [Fields_key]             INT            NULL,
    [User_key]               NVARCHAR (100) NULL,
    [NoOfQueries]            INT            NULL,
    CONSTRAINT [PK_Fact_f_DailyQueryMetrics] PRIMARY KEY CLUSTERED ([DailyQueryMetrics_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_DailyQueryMetrics]
    ON [Fact].[f_DailyQueryMetrics]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

