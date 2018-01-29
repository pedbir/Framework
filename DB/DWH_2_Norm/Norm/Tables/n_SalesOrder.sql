CREATE TABLE [Norm].[n_SalesOrder] (
    [SalesOrder_key]                  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]             INT            NOT NULL,
    [SysDatetimeInsertedUTC]          DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]           DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]           DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]       DATETIME2 (0)  NULL,
    [SysModifiedUTC]                  DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                   BIT            NOT NULL,
    [SysValidFromDateTime]            DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]        DATETIME2 (0)  NULL,
    [SalesOrder_bkey]                 NVARCHAR (100) NOT NULL,
    [SugarEnum_DeliveryStatus_bkey]   NVARCHAR (133) NULL,
    [SugarEnum_OrderType_bkey]        NVARCHAR (133) NULL,
    [SugarEnum_ConnectionType_bkey]   NVARCHAR (132) NULL,
    [SugarEnum_OrderSource_bkey]      NVARCHAR (135) NULL,
    [Opportunity_bkey]                NVARCHAR (100) NULL,
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
    [FirstName]                       NVARCHAR (255) NULL,
    [Surname]                         NVARCHAR (255) NULL,
    [Email]                           NVARCHAR (255) NULL,
    [MobilePhoneNo]                   NVARCHAR (255) NULL,
    [PersonalIdentityNumber]          NVARCHAR (255) NULL,
    [OrganizationNumber]              NVARCHAR (255) NOT NULL,
    [Age]                             INT            NULL,
    [Gender]                          VARCHAR (7)    NULL,
    CONSTRAINT [PK_Norm_n_SalesOrder] PRIMARY KEY CLUSTERED ([SalesOrder_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);














GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_SalesOrder]
    ON [Norm].[n_SalesOrder]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO



GO




