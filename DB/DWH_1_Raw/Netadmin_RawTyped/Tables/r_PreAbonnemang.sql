CREATE TABLE [Netadmin_RawTyped].[r_PreAbonnemang] (
    [PreAbonnemang_key]        INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [PreAbonnemang_bkey]       INT           NOT NULL,
    [Preinkopldat]             DATE          NULL,
    [Preurkopldat]             DATE          NULL,
    [Preadrid]                 INT           NULL,
    [Pretmpid]                 INT           NULL,
    [Preartnr]                 NVARCHAR (50) NULL,
    [Prestartartnr]            NVARCHAR (50) NULL,
    [aboisp]                   INT           NULL,
    [abostartdat]              DATE          NULL,
    [aboansvarig]              NVARCHAR (50) NULL,
    CONSTRAINT [PK_Netadmin_RawTyped_r_PreAbonnemang] PRIMARY KEY CLUSTERED ([PreAbonnemang_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Netadmin_RawTyped_r_PreAbonnemang]
    ON [Netadmin_RawTyped].[r_PreAbonnemang]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

