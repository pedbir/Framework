CREATE TABLE [Norm].[n_Access] (
    [Access_key]                INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NULL,
    [Access_bkey]               INT           NOT NULL,
    [Calendar_Installed_bkey]   DATETIME      NULL,
    [AccessCategory_Lvl1_bkey]  INT           NOT NULL,
    [AccessCategory_Lvl2_bkey]  INT           NOT NULL,
    [AccessCategory_Lvl3_bkey]  INT           NOT NULL,
    [AccessCategory_Lvl4_bkey]  INT           NOT NULL,
    [AccessCategory_Lvl5_bkey]  INT           NOT NULL,
    CONSTRAINT [PK_Norm_n_Access] PRIMARY KEY CLUSTERED ([Access_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Access]
    ON [Norm].[n_Access]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

