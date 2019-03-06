CREATE TABLE [BamsSe_RawTyped].[r_Media] (
    [Media_key]                INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Media_bkey]               NVARCHAR (100) NOT NULL,
    [Name]                     NVARCHAR (250) NULL,
    [MediaCategoryCode]        NVARCHAR (100) NULL,
    [MediaCategoryName]        NVARCHAR (250) NULL,
    [MediaTypeCode]            NVARCHAR (100) NULL,
    [MediaType]                NVARCHAR (250) NULL,
    CONSTRAINT [PK_BamsSe_RawTyped_r_Media] PRIMARY KEY CLUSTERED ([Media_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsSe_RawTyped_r_Media]
    ON [BamsSe_RawTyped].[r_Media]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

