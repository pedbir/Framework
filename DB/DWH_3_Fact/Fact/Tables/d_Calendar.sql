CREATE TABLE [Fact].[d_Calendar] (
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [Calendar_key]             INT           NOT NULL,
    [Calendar_bkey]            DATETIME      NOT NULL,
    [CalendarYear]             INT           NULL,
    [YearMonth]                VARCHAR (7)   NULL,
    [YearWeek]                 VARCHAR (8)   NULL,
    [YearQuarter]              VARCHAR (8)   NULL,
    [CalendarQuarter]          INT           NULL,
    [MonthofYear]              INT           NULL,
    [MonthName]                VARCHAR (10)  NULL,
    [WeekOfYear]               INT           NULL,
    [DayofWeek]                INT           NULL,
    [DayName]                  CHAR (10)     NULL,
    [DayofMonth]               INT           NULL,
    CONSTRAINT [PK_Fact_d_Calendar] PRIMARY KEY CLUSTERED ([Calendar_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Calendar]
    ON [Fact].[d_Calendar]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];


GO


