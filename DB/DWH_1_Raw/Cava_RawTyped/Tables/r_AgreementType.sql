CREATE TABLE [Cava_RawTyped].[r_AgreementType] (
    [AgreementType_key]        INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT           NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0) NULL,
    [SysModifiedUTC]           DATETIME2 (0) NOT NULL,
    [SysIsInferred]            BIT           NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0) NULL,
    [AgreementType_bkey]       INT           NOT NULL,
    [AgreementType]            NVARCHAR (50) NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_AgreementType] PRIMARY KEY CLUSTERED ([AgreementType_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_AgreementType]
    ON [Cava_RawTyped].[r_AgreementType]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

