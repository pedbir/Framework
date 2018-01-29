CREATE TABLE [Norm].[n_ServiceProvider] (
    [ServiceProvider_key]       INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NULL,
    [ServiceProvider_bkey]      INT           NOT NULL,
    [ServiceProvider]           NVARCHAR (50) NULL,
    CONSTRAINT [PK_Norm_n_ServiceProvider] PRIMARY KEY CLUSTERED ([ServiceProvider_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_ServiceProvider]
    ON [Norm].[n_ServiceProvider]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

