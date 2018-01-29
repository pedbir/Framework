CREATE TABLE [Fact].[f_Subscription] (
    [SysExecutionLog_key]            INT           NOT NULL,
    [SysDatetimeInsertedUTC]         DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]          DATETIME2 (0) NULL,
    [SysModifiedUTC]                 DATETIME2 (0) NOT NULL,
    [Subscription_key]               INT           NOT NULL,
    [SysDatetimeDeletedUTC]          DATETIME2 (0) NULL,
    [SysValidFromDateTime]           DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]       DATETIME2 (0) NULL,
    [Subscription_bkey]              INT           NOT NULL,
    [SubscriptionProduct_bkey]       NVARCHAR (50) NOT NULL,
    [ServiceProvider_bkey]           INT           NULL,
    [Access_bkey]                    INT           NULL,
    [SubscriptionProduct_key]        INT           NOT NULL,
    [ServiceProvider_key]            INT           NOT NULL,
    [Access_key]                     INT           NOT NULL,
    [Opportunity_key]                INT           NOT NULL,
    [Address_key]                    INT           NOT NULL,
    [Area_key]                       INT           NOT NULL,
    [Calendar_Purchase_bkey]         DATETIME      NULL,
    [ResoposibleSalesEntity]         NVARCHAR (50) NULL,
    [Calendar_FromSubscription_bkey] DATETIME      NULL,
    [Calendar_ToSubscription_bkey]   DATETIME      NULL,
    CONSTRAINT [PK_f_Subscription] PRIMARY KEY CLUSTERED ([Subscription_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_Subscription]
    ON [Fact].[f_Subscription]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];


GO
CREATE NONCLUSTERED INDEX [IX_f_Subscription_Calendar_bkey]
    ON [Fact].[f_Subscription]([Calendar_FromSubscription_bkey] ASC, [Calendar_ToSubscription_bkey] ASC)
    INCLUDE([Subscription_key])
    ON [Fact_Data];

