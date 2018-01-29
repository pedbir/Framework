CREATE TABLE [Fact].[d_Customer] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [Customer_key]             INT            NOT NULL,
    [CustomerName]             NVARCHAR (511) NULL,
    [Email]                    NVARCHAR (255) NULL,
    [MobilePhoneNo]            NVARCHAR (255) NULL,
    [PersonalIdentityNumber]   NVARCHAR (255) NULL,
    [OrganizationNumber]       NVARCHAR (255) NOT NULL,
    [Age]                      INT            NULL,
    [Gender]                   VARCHAR (7)    NULL,
    CONSTRAINT [PK_Fact_d_Customer] PRIMARY KEY CLUSTERED ([Customer_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Customer]
    ON [Fact].[d_Customer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

