CREATE TABLE [Fact].[d_SalesOrder] (
    [SysExecutionLog_key]             INT            NOT NULL,
    [SysDatetimeInsertedUTC]          DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]           DATETIME2 (0)  NULL,
    [SysModifiedUTC]                  DATETIME2 (0)  NOT NULL,
    [SalesOrder_key]                  INT            NOT NULL,
    [SysDatetimeDeletedUTC]           DATETIME2 (0)  NULL,
    [SysIsInferred]                   BIT            NOT NULL,
    [SysValidFromDateTime]            DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]        DATETIME2 (0)  NULL,
    [SalesOrder_bkey]                 NVARCHAR (100) NOT NULL,
    [Opportunity_key]                 INT            NOT NULL,
    [SugarEnum_DeliveryStatus_key]    INT            NOT NULL,
    [SugarEnum_OrderType_key]         INT            NOT NULL,
    [SugarEnum_ConnectionType_key]    INT            NOT NULL,
    [SugarEnum_OrderSource_key]       INT            NOT NULL,
    [PlannedInstallationDate]         DATETIME2 (7)  NULL,
    [ProductBundleYN]                 NVARCHAR (100) NULL,
    [ProductBundleName]               NVARCHAR (255) NOT NULL,
    [Campaign6MonthInternet]          NVARCHAR (20)  NULL,
    [ConnectionFeeSEK]                MONEY          NOT NULL,
    [RotDeductionSEK]                 MONEY          NOT NULL,
    [RutDeductionSEK]                 MONEY          NOT NULL,
    [DiscountSEK]                     MONEY          NOT NULL,
    [ExtraFeeSEK]                     MONEY          NOT NULL,
    [ProductBundlePriceAdjustmentSEK] MONEY          NULL,
    [TotalRevenueSEK]                 MONEY          NULL,
    CONSTRAINT [PK_Fact_d_SalesOrder] PRIMARY KEY CLUSTERED ([SalesOrder_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_SalesOrder]
    ON [Fact].[d_SalesOrder]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

