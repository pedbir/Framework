CREATE TABLE [NBS_RawTyped].[r_NetadminArticle] (
    [NetadminArticle_key]      INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [NetadminArticle_bkey]     NVARCHAR (50) NOT NULL,
    [Service]                  NVARCHAR (50) NULL,
    [ServiceType]              NVARCHAR (50) NULL,
    [MonthlyPrice]             MONEY         NULL,
    [StartPrice]               MONEY         NULL,
    [NoBill]                   INT           NULL,
    CONSTRAINT [PK_NBS_RawTyped_r_NetadminArticle] PRIMARY KEY CLUSTERED ([NetadminArticle_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_NBS_RawTyped_r_NetadminArticle]
    ON [NBS_RawTyped].[r_NetadminArticle]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

