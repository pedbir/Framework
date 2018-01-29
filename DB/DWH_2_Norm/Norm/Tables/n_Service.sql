CREATE TABLE [Norm].[n_Service] (
    [Service_key]               INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NULL,
    [Service_bkey]              INT           NOT NULL,
    [ServiceNameShort]          NVARCHAR (50) NULL,
    [ServiceName]               NVARCHAR (50) NULL,
    CONSTRAINT [PK_Norm_n_Service] PRIMARY KEY CLUSTERED ([Service_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Service]
    ON [Norm].[n_Service]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

