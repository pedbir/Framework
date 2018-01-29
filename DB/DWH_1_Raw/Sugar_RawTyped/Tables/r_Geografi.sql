CREATE TABLE [Sugar_RawTyped].[r_Geografi] (
    [Geografi_key]             INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Geografi_bkey]            NVARCHAR (100) NOT NULL,
    [Name]                     NVARCHAR (255) NULL,
    [Deleted]                  INT            NULL,
    [Kommunc]                  NVARCHAR (100) NULL,
    [Lanc]                     NVARCHAR (100) NULL,
    [Regionc]                  NVARCHAR (100) NULL,
    [Stadc]                    NVARCHAR (255) NULL,
    [Stadsnatc]                NVARCHAR (100) NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Geografi] PRIMARY KEY CLUSTERED ([Geografi_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Geografi]
    ON [Sugar_RawTyped].[r_Geografi]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

