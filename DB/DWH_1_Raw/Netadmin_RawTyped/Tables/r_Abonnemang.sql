CREATE TABLE [Netadmin_RawTyped].[r_Abonnemang] (
    [Abonnemang_key]           INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [Abonnemang_bkey]          INT           NOT NULL,
    [abostartdat]              DATE          NULL,
    [aboinkopldat]             DATE          NULL,
    [aboadressdbid]            INT           NULL,
    [abotmpid]                 INT           NULL,
    [aboartnr]                 NVARCHAR (50) NULL,
    [abostartartnr]            NVARCHAR (50) NULL,
    [aboisp]                   INT           NULL,
    [aboansvarig]              NVARCHAR (50) NULL,
    CONSTRAINT [PK_Netadmin_RawTyped_r_Abonnemang] PRIMARY KEY CLUSTERED ([Abonnemang_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Netadmin_RawTyped_r_Abonnemang]
    ON [Netadmin_RawTyped].[r_Abonnemang]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

