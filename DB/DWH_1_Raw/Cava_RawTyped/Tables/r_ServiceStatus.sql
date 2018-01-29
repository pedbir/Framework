CREATE TABLE [Cava_RawTyped].[r_ServiceStatus] (
    [ServiceStatus_key]        INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [ServiceStatus_bkey]       INT           NOT NULL,
    [Servicestatus]            NVARCHAR (50) NULL,
    [RegardAsActive]           BIT           NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_ServiceStatus] PRIMARY KEY CLUSTERED ([ServiceStatus_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_ServiceStatus]
    ON [Cava_RawTyped].[r_ServiceStatus]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

