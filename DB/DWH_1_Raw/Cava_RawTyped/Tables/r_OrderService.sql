CREATE TABLE [Cava_RawTyped].[r_OrderService] (
    [OrderService_key]         INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [OrderService_bkey]        INT            NOT NULL,
    [OrderID]                  INT            NULL,
    [ServiceID]                INT            NULL,
    [Currency]                 NVARCHAR (3)   NULL,
    [NRCC]                     MONEY          NULL,
    [MRCC]                     MONEY          NULL,
    [InstallationReady]        DATETIME       NULL,
    [FirstInvoiceDate]         DATETIME       NULL,
    [LastInvoiceDate]          DATETIME       NULL,
    [TerminationNoticeDate]    DATETIME       NULL,
    [ReplaceNoticeDate]        DATETIME       NULL,
    [EndOfService]             DATETIME       NULL,
    [ServicestatusID]          INT            NULL,
    [SLA]                      NVARCHAR (50)  NULL,
    [Cap]                      INT            NULL,
    [UnitID]                   INT            NULL,
    [ConnectionID]             NVARCHAR (50)  NULL,
    [IsReneg]                  BIT            NULL,
    [SiteID]                   INT            NULL,
    [CustomerServiceName]      NVARCHAR (100) NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_OrderService] PRIMARY KEY CLUSTERED ([OrderService_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_OrderService]
    ON [Cava_RawTyped].[r_OrderService]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

