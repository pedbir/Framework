CREATE TABLE [Norm].[n_Subscription] (
    [Subscription_key]           INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]        INT           NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC]  DATETIME2 (0) NULL,
    [SysModifiedUTC]             DATETIME2 (0) NOT NULL,
    [SysIsInferred]              BIT           NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0) NULL,
    [Subscription_bkey]          INT           NOT NULL,
    [SubscriptionProduct_bkey]   NVARCHAR (50) NOT NULL,
    [ServiceProvider_bkey]       INT           NULL,
    [Access_bkey]                INT           NULL,
    [Calendar_Subscription_bkey] DATETIME      NULL,
    [Calendar_Purchase_bkey]     DATETIME      NULL,
    [ResoposibleSalesEntity]     NVARCHAR (50) NULL,
    [IsClosed]                   BIT           NULL,
    CONSTRAINT [PK_Norm_n_Subscription] PRIMARY KEY CLUSTERED ([Subscription_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Subscription]
    ON [Norm].[n_Subscription]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

