CREATE TABLE [Cava_RawTyped].[r_Order] (
    [Order_key]                    INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]          INT            NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)  NULL,
    [SysModifiedUTC]               DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                BIT            NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)  NULL,
    [Order_bkey]                   INT            NOT NULL,
    [CustomerID]                   INT            NULL,
    [CompanyID]                    INT            NULL,
    [TypeID]                       INT            NULL,
    [OrderNumber]                  NVARCHAR (50)  NULL,
    [NRCC]                         MONEY          NULL,
    [MRCC]                         MONEY          NULL,
    [Currency]                     NVARCHAR (3)   NULL,
    [InitialTerm]                  INT            NULL,
    [ArrivalDate]                  DATETIME       NULL,
    [InstallationReady]            DATETIME       NULL,
    [OrderEstimatedMRC]            MONEY          NULL,
    [TotalMRCofReplacedOrder]      MONEY          NULL,
    [Salesuser]                    NVARCHAR (255) NULL,
    [OrderadminID]                 INT            NULL,
    [AdditionalRenegotiatedMonths] NVARCHAR (50)  NULL,
    [ReasonID]                     INT            NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_Order] PRIMARY KEY CLUSTERED ([Order_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_Order]
    ON [Cava_RawTyped].[r_Order]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

