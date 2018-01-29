CREATE TABLE [Cava_RawTyped].[r_Service] (
    [Service_key]              INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [Service_bkey]             INT           NOT NULL,
    [Name]                     NVARCHAR (50) NULL,
    [ServiceSwe]               NVARCHAR (50) NULL,
    [ServiceEng]               NVARCHAR (50) NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_Service] PRIMARY KEY CLUSTERED ([Service_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_Service]
    ON [Cava_RawTyped].[r_Service]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

