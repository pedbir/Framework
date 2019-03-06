CREATE TABLE [Norm].[n_DailyQueries] (
    [DailyQueries_key]          INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT             NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)   NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)   NULL,
    [SysModifiedUTC]            DATETIME2 (0)   NOT NULL,
    [SysIsInferred]             BIT             NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)   NULL,
    [DailyQueries_bkey]         NVARCHAR (100)  NOT NULL,
    [SqlQuery]                  NVARCHAR (1500) NULL,
    [Calendar_bkey]             DATETIME        NULL,
    [LoginName]                 NVARCHAR (100)  NULL,
    [HostName]                  NVARCHAR (256)  NULL,
    [ServerName]                NVARCHAR (256)  NULL,
    [DatabaseName]              NVARCHAR (100)  NULL,
    [ApplicationName]           NVARCHAR (256)  NULL,
    [EventClass]                INT             NULL,
    [Fields_bkey]               INT             NOT NULL,
    CONSTRAINT [PK_Norm_n_DailyQueries] PRIMARY KEY CLUSTERED ([DailyQueries_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_DailyQueries]
    ON [Norm].[n_DailyQueries]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

