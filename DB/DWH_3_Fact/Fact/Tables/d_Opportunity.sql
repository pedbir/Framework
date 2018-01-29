CREATE TABLE [Fact].[d_Opportunity] (
    [SysExecutionLog_key]        INT            NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]             DATETIME2 (0)  NOT NULL,
    [Opportunity_key]            INT            NOT NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0)  NULL,
    [SysIsInferred]              BIT            NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0)  NULL,
    [Opportunity_bkey]           NVARCHAR (100) NOT NULL,
    [OpportunityName]            NVARCHAR (255) NULL,
    [Area_key]                   INT            NOT NULL,
    [Access_key]                 INT            NOT NULL,
    [SalesOrder_key]             INT            NOT NULL,
    [SugarEnum_BusinessType_key] INT            NOT NULL,
    [Fastighetsbeteckningc]      NVARCHAR (255) NULL,
    [AcquiredAccess]             VARCHAR (7)    NOT NULL,
    [CustomerCategory_key]       INT            NOT NULL,
    [Address_key]                INT            NULL,
    CONSTRAINT [PK_Fact_d_Opportunity] PRIMARY KEY CLUSTERED ([Opportunity_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Opportunity]
    ON [Fact].[d_Opportunity]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

