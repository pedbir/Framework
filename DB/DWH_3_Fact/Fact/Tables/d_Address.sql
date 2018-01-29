CREATE TABLE [Fact].[d_Address] (
    [SysExecutionLog_key]      INT             NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)   NULL,
    [SysModifiedUTC]           DATETIME2 (0)   NOT NULL,
    [Address_key]              INT             NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)   NULL,
    [SysValidFromDateTime]     DATETIME2 (3)   NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)   NULL,
    [Address_bkey]             NVARCHAR (100)  NOT NULL,
    [StreetName]               NVARCHAR (255)  NULL,
    [StreetNumber]             NVARCHAR (50)   NULL,
    [PostalCode]               NVARCHAR (20)   NULL,
    [PostalCity]               NVARCHAR (255)  NULL,
    [CountryCode]              NVARCHAR (100)  NULL,
    [Latitude]                 DECIMAL (11, 6) NULL,
    [Longitude]                DECIMAL (11, 6) NULL,
    [Estate_bkey]              INT             NULL,
    CONSTRAINT [PK_Fact_d_Address] PRIMARY KEY CLUSTERED ([Address_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Address]
    ON [Fact].[d_Address]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

