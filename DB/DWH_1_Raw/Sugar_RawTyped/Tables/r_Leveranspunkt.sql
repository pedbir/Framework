CREATE TABLE [Sugar_RawTyped].[r_Leveranspunkt] (
    [Leveranspunkt_key]                                    INT             IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]                                  INT             NOT NULL,
    [SysDatetimeInsertedUTC]                               DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]                                DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]                                DATETIME2 (0)   NULL,
    [SysModifiedUTC]                                       DATETIME2 (0)   NOT NULL,
    [SysIsInferred]                                        BIT             NOT NULL,
    [SysValidFromDateTime]                                 DATETIME2 (0)   NOT NULL,
    [SysSrcGenerationDateTime]                             DATETIME2 (0)   NULL,
    [Leveranspunkt_bkey]                                   NVARCHAR (100)  NOT NULL,
    [Name]                                                 NVARCHAR (255)  NULL,
    [Deleted]                                              INT             NULL,
    [Netadminaddressidc]                                   NVARCHAR (255)  NULL,
    [Relevansc]                                            NVARCHAR (100)  NULL,
    [Migreradc]                                            NVARCHAR (100)  NULL,
    [Tjanstetypc]                                          NVARCHAR (100)  NULL,
    [Installationsdatumnetadminc]                          DATE            NULL,
    [Latitudec]                                            DECIMAL (10, 6) NULL,
    [Longitudec]                                           DECIMAL (10, 6) NULL,
    [Adressmasteridc]                                      INT             NULL,
    [Kampanj6maninternetc]                                 NVARCHAR (100)  NULL,
    [Sexmangratiskampanjtillc]                             DATE            NULL,
    [Bostadsnatfinnsc]                                     NVARCHAR (100)  NULL,
    [Shippingaddressstreetc]                               NVARCHAR (255)  NULL,
    [Shippingaddresspostalcodec]                           NVARCHAR (20)   NULL,
    [Shippingaddressstreetnamec]                           NVARCHAR (255)  NULL,
    [Shippingaddressstreetnoc]                             NVARCHAR (20)   NULL,
    [Shippingaddressentrancec]                             NVARCHAR (20)   NULL,
    [Shippingaddressapartnumberc]                          NVARCHAR (20)   NULL,
    [Shippingaddressaltapartnoc]                           NVARCHAR (20)   NULL,
    [Shippingaddresscityc]                                 NVARCHAR (100)  NULL,
    [Shippingaddresscountryc]                              NVARCHAR (100)  NULL,
    [Fastighetsbeteckningc]                                NVARCHAR (255)  NULL,
    [Aktivtjanstc]                                         NVARCHAR (100)  NULL,
    [Gruppanslutningc]                                     NVARCHAR (255)  NULL,
    [Ipleveransobjektipleveranspunkteripleveransobjektida] NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Leveranspunkt] PRIMARY KEY CLUSTERED ([Leveranspunkt_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Leveranspunkt]
    ON [Sugar_RawTyped].[r_Leveranspunkt]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

