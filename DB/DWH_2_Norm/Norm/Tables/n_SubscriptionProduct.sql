CREATE TABLE [Norm].[n_SubscriptionProduct] (
    [SubscriptionProduct_key]   INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NULL,
    [SubscriptionProduct_bkey]  NVARCHAR (50) NOT NULL,
    [SubscriptionProduct]       NVARCHAR (50) NOT NULL,
    [SubscriptionProductType]   NVARCHAR (50) NOT NULL,
    [MonthlyPrice]              MONEY         NOT NULL,
    [StartPrice]                MONEY         NOT NULL,
    [Billable]                  NVARCHAR (5)  NULL,
    CONSTRAINT [PK_Norm_n_SubscriptionProduct] PRIMARY KEY CLUSTERED ([SubscriptionProduct_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_SubscriptionProduct]
    ON [Norm].[n_SubscriptionProduct]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

