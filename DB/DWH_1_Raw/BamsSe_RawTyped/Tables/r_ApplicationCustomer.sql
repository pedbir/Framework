CREATE TABLE [BamsSe_RawTyped].[r_ApplicationCustomer] (
    [ApplicationCustomer_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [ApplicationCustomer_bkey] NVARCHAR (100) NOT NULL,
    [CustomerId]               NVARCHAR (100) NULL,
    [ApplicationId]            NVARCHAR (100) NULL,
    [IsMainApplicant]          BIT            NULL,
    CONSTRAINT [PK_BamsSe_RawTyped_r_ApplicationCustomer] PRIMARY KEY CLUSTERED ([ApplicationCustomer_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsSe_RawTyped_r_ApplicationCustomer]
    ON [BamsSe_RawTyped].[r_ApplicationCustomer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
CREATE NONCLUSTERED INDEX [NCIDX_IsMainApplicant_BamsSe_RawTyped_r_ApplicationCustomer]
    ON [BamsSe_RawTyped].[r_ApplicationCustomer]([IsMainApplicant] ASC, [ApplicationId] ASC, [SysValidFromDateTime] DESC)
    INCLUDE([CustomerId]) WITH (DATA_COMPRESSION = PAGE);



