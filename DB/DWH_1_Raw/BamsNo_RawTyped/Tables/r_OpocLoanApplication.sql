CREATE TABLE [BamsNo_RawTyped].[r_OpocLoanApplication] (
    [OpocLoanApplication_key]       INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]           INT            NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                 BIT            NOT NULL,
    [SysValidFromDateTime]          DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)  NULL,
    [OpocLoanApplication_bkey]      NVARCHAR (100) NOT NULL,
    [CurrentApplicationExportLogId] NVARCHAR (100) NULL,
    [ApplicationNumber]             INT            NULL,
    [Amount]                        INT            NULL,
    [ApplicationPurposeCODE]        NVARCHAR (100) NULL,
    [ApplicationPurpose]            NVARCHAR (150) NULL,
    [ApplicationRefusalCODE]        NVARCHAR (100) NULL,
    [ApplicationRefusal]            NVARCHAR (150) NULL,
    [ContactWayCODE]                NVARCHAR (100) NULL,
    [ContactWay]                    NVARCHAR (150) NULL,
    [MediaCode]                     NVARCHAR (100) NULL,
    [Media]                         NVARCHAR (150) NULL,
    [UpdatedByUserId]               NVARCHAR (100) NULL,
    [OPOCProductCode]               NVARCHAR (100) NULL,
    [OPOCProduct]                   NVARCHAR (150) NULL,
    [ExportDate]                    DATETIME       NULL,
    [ExportedByUserId]              NVARCHAR (100) NULL,
    CONSTRAINT [PK_BamsNo_RawTyped_r_OpocLoanApplication] PRIMARY KEY CLUSTERED ([OpocLoanApplication_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsNo_RawTyped_r_OpocLoanApplication]
    ON [BamsNo_RawTyped].[r_OpocLoanApplication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysSrcGenerationDateTime_BamsSe_RawTyped_r_OpocLoanApplication]
    ON [BamsNo_RawTyped].[r_OpocLoanApplication]([SysSrcGenerationDateTime] ASC) WITH (DATA_COMPRESSION = PAGE);

