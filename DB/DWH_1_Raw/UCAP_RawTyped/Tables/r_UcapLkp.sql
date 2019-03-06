CREATE TABLE [UCAP_RawTyped].[r_UcapLkp] (
    [UcapLkp_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [UcapLkp_bkey]             NVARCHAR (100) NOT NULL,
    [UcapLkpId]                NVARCHAR (100) NULL,
    [UcapLkpDomain]            VARCHAR (32)   NOT NULL,
    [UcapLkpValue]             NVARCHAR (512) NULL,
    CONSTRAINT [PK_UCAP_RawTyped_r_UcapLkp] PRIMARY KEY CLUSTERED ([UcapLkp_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_UCAP_RawTyped_r_UcapLkp]
    ON [UCAP_RawTyped].[r_UcapLkp]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

