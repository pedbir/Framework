CREATE TABLE [Netadmin_RawTyped].[r_Isp] (
    [Isp_key]                  INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [Isp_bkey]                 INT           NOT NULL,
    [ispnamn]                  NVARCHAR (50) NULL,
    CONSTRAINT [PK_Netadmin_RawTyped_r_Isp] PRIMARY KEY CLUSTERED ([Isp_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Netadmin_RawTyped_r_Isp]
    ON [Netadmin_RawTyped].[r_Isp]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

