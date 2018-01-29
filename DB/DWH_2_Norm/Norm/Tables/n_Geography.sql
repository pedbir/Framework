CREATE TABLE [Norm].[n_Geography] (
    [Geography_key]               INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]         INT            NOT NULL,
    [SysDatetimeInsertedUTC]      DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]       DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]       DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]   DATETIME2 (0)  NULL,
    [SysModifiedUTC]              DATETIME2 (0)  NOT NULL,
    [SysIsInferred]               BIT            NOT NULL,
    [SysValidFromDateTime]        DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]    DATETIME2 (0)  NULL,
    [Geography_bkey]              NVARCHAR (100) NOT NULL,
    [GeographyName]               NVARCHAR (255) NULL,
    [SugarEnum_Municipality_bkey] NVARCHAR (121) NULL,
    [SugarEnum_State_bkey]        NVARCHAR (118) NULL,
    [SugarEnum_Region_bkey]       NVARCHAR (121) NULL,
    CONSTRAINT [PK_Norm_n_Geography] PRIMARY KEY CLUSTERED ([Geography_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Geography]
    ON [Norm].[n_Geography]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

