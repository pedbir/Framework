CREATE TABLE [Norm].[n_UcapLkp] (
    [UcapLkp_key]               INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [UcapLkp_bkey]              NVARCHAR (100) NOT NULL,
    [UcapLkpId]                 NVARCHAR (100) NULL,
    [UcapLkpDomain]             VARCHAR (32)   NULL,
    [UcapLkpValue]              NVARCHAR (512) NULL,
    CONSTRAINT [PK_Norm_n_UcapLkp] PRIMARY KEY CLUSTERED ([UcapLkp_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_UcapLkp]
    ON [Norm].[n_UcapLkp]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];





