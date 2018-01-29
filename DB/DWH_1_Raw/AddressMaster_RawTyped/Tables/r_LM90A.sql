CREATE TABLE [AddressMaster_RawTyped].[r_LM90A] (
    [LM90A_key]                INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT             NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)   NULL,
    [SysModifiedUTC]           DATETIME2 (0)   NOT NULL,
    [SysIsInferred]            BIT             NOT NULL						 DEFAULT 0,
    [SysValidFromDateTime]     DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)   NULL,
    [LM90A_bkey]               INT             NOT NULL,
    [AdrOmrade]                NVARCHAR (50)   NULL,
    [AdrPlats]                 NVARCHAR (50)   NULL,
    [PostNr]                   NVARCHAR (20)   NULL,
    [PostOrt]                  NVARCHAR (50)   NULL,
    [LandsKod]                 NVARCHAR (50)   NULL,
    [Latitud]                  DECIMAL (11, 6) NULL,
    [Longitud]                 DECIMAL (11, 6) NULL,
    [FNR]                      NVARCHAR (9)    NULL,
    CONSTRAINT [PK_AddressMaster_RawTyped_r_LM90A] PRIMARY KEY CLUSTERED ([LM90A_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_AddressMaster_RawTyped_r_LM90A]
    ON [AddressMaster_RawTyped].[r_LM90A]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

