CREATE TABLE [Norm].[n_Address] (
    [Address_key]               INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT             NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)   NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)   NULL,
    [SysModifiedUTC]            DATETIME2 (0)   NOT NULL,
    [SysIsInferred]             BIT             NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (3)   NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)   NULL,
    [Address_bkey]              NVARCHAR (100)  NOT NULL,
    [SysSource]                 VARCHAR (13)    NULL,
    [StreetName]                NVARCHAR (255)  NULL,
    [StreetNumber]              NVARCHAR (50)   NULL,
    [PostalCode]                NVARCHAR (20)   NULL,
    [PostalCity]                NVARCHAR (255)  NULL,
    [CountryCode]               NVARCHAR (100)  NULL,
    [Latitude]                  DECIMAL (11, 6) NULL,
    [Longitude]                 DECIMAL (11, 6) NULL,
    [Estate_bkey]               INT             NULL,
    CONSTRAINT [PK_Norm_n_Address] PRIMARY KEY CLUSTERED ([Address_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Address]
    ON [Norm].[n_Address]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

