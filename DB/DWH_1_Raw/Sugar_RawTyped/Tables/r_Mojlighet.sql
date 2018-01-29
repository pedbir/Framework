CREATE TABLE [Sugar_RawTyped].[r_Mojlighet] (
    [Mojlighet_key]                     INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]               INT             NOT NULL,
    [SysDatetimeInsertedUTC]            DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]             DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]             DATETIME2 (0)   NULL,
    [SysModifiedUTC]                    DATETIME2 (0)   NOT NULL,
    [SysIsInferred]                     BIT             NOT NULL,
    [SysValidFromDateTime]              DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime]          DATETIME2 (0)   NULL,
    [Mojlighet_bkey]                    NVARCHAR (100)  NOT NULL,
    [Name]                              NVARCHAR (255)  NULL,
    [Deleted]                           INT             NULL,
    [Shippingaddresspostalcode]         NVARCHAR (20)   NULL,
    [Kundtypc]                          NVARCHAR (100)  NULL,
    [Netadminaddressidc]                INT             NULL,
    [Relevansc]                         NVARCHAR (100)  NULL,
    [Migreradc]                         NVARCHAR (100)  NULL,
    [Tjanstetypc]                       NVARCHAR (100)  NULL,
    [Installationsdatumnetadminc]       DATE            NULL,
    [Latitudec]                         DECIMAL (10, 6) NULL,
    [Longitudec]                        DECIMAL (10, 6) NULL,
    [Adressmasteridc]                   INT             NULL,
    [Kampanj6maninternetc]              NVARCHAR (100)  NULL,
    [Sexmangratiskampanjtillc]          DATE            NULL,
    [Shippingaddressstreetc]            NVARCHAR (255)  NULL,
    [Shippingaddressstreetnamec]        NVARCHAR (255)  NULL,
    [Shippingaddressstreetnoc]          NVARCHAR (10)   NULL,
    [Shippingaddressentrancec]          NVARCHAR (10)   NULL,
    [Shippingaddressapartnumberc]       NVARCHAR (10)   NULL,
    [Shippingaddressaltapartnoc]        NVARCHAR (20)   NULL,
    [Shippingaddresscityc]              NVARCHAR (255)  NULL,
    [Shippingaddresscountryc]           NVARCHAR (100)  NULL,
    [Fastighetsbeteckningc]             NVARCHAR (255)  NULL,
    [Aktivtjanstc]                      NVARCHAR (100)  NULL,
    [Forvarvadhpc]                      NVARCHAR (100)  NULL,
    [Ipomradeipmojligheteripomradeida]  NVARCHAR (100)  NULL,
    [ContactsIpMojligheter1ContactsIda] NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Mojlighet] PRIMARY KEY CLUSTERED ([Mojlighet_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Mojlighet]
    ON [Sugar_RawTyped].[r_Mojlighet]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
CREATE NONCLUSTERED INDEX [IX_ContactsIpMojligheter1ContactsIda]
    ON [Sugar_RawTyped].[r_Mojlighet]([ContactsIpMojligheter1ContactsIda] ASC, [SysValidFromDateTime] DESC);

