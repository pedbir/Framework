CREATE TABLE [IFS_RawTyped].[r_ProjectCost] (
    [ProjectCost_key]          INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [ProjectCost_bkey]         NVARCHAR (250) NOT NULL,
    [ProjectID]                NVARCHAR (100) NULL,
    [ControlCategory]          NVARCHAR (100) NULL,
    [Estimated]                MONEY          NULL,
    [Baseline]                 MONEY          NULL,
    [Used]                     MONEY          NULL,
    [Áctual]                   MONEY          NULL,
    CONSTRAINT [PK_IFS_RawTyped_r_ProjectCost] PRIMARY KEY CLUSTERED ([ProjectCost_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_IFS_RawTyped_r_ProjectCost]
    ON [IFS_RawTyped].[r_ProjectCost]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

