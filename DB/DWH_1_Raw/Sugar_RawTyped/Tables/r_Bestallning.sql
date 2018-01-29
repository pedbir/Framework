CREATE TABLE [Sugar_RawTyped].[r_Bestallning] (
    [Bestallning_key]                            INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]                        INT            NOT NULL,
    [SysDatetimeInsertedUTC]                     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]                      DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]                      DATETIME2 (0)  NULL,
    [SysModifiedUTC]                             DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                              BIT            NOT NULL,
    [SysValidFromDateTime]                       DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]                   DATETIME2 (0)  NULL,
    [Bestallning_bkey]                           NVARCHAR (100) NOT NULL,
    [Name]                                       NVARCHAR (255) NULL,
    [Deleted]                                    INT            NULL,
    [BillingAddressStreet]                       NVARCHAR (150) NULL,
    [BllingAddressPostalcode]                    NVARCHAR (20)  NULL,
    [BillingAddressCity]                         NVARCHAR (100) NULL,
    [StatusLeveransC]                            NVARCHAR (100) NULL,
    [Statusfaktureringc]                         NVARCHAR (100) NULL,
    [Bestallningstypc]                           NVARCHAR (100) NULL,
    [Anslutningstypc]                            NVARCHAR (100) NULL,
    [Kallabestallningc]                          NVARCHAR (100) NULL,
    [Anslutningsavgiftc]                         MONEY          NULL,
    [Rotavdragc]                                 MONEY          NULL,
    [Rutavdragc]                                 MONEY          NULL,
    [Kompensationc]                              MONEY          NULL,
    [Extrakostnadc]                              MONEY          NULL,
    [Planeradkundinstallationc]                  DATETIME2 (7)  NULL,
    [Bokadkundinstallationc]                     DATETIME2 (7)  NULL,
    [Tomtschaktutforddatumc]                     DATE           NULL,
    [Installationc]                              DATE           NULL,
    [Tjanstebundlingc]                           NVARCHAR (100) NULL,
    [Prisjusteringbundlingc]                     MONEY          NULL,
    [Tjanstebundlingnamnc]                       NVARCHAR (255) NULL,
    [Netadmintjanstskapaddatumc]                 DATE           NULL,
    [Installationsdatumnetadminc]                DATE           NULL,
    [Kampanj6maninternetc]                       NVARCHAR (20)  NULL,
    [Fornamnc]                                   NVARCHAR (255) NULL,
    [Efternamnc]                                 NVARCHAR (255) NULL,
    [Epostadressc]                               NVARCHAR (255) NULL,
    [Mobiltelc]                                  NVARCHAR (255) NULL,
    [Hemtelc]                                    NVARCHAR (255) NULL,
    [Personnummerc]                              NVARCHAR (255) NULL,
    [Orgnummerc]                                 NVARCHAR (255) NULL,
    [Ipmojligheteripbestallningipmojligheterida] NVARCHAR (100) NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Bestallning] PRIMARY KEY CLUSTERED ([Bestallning_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Bestallning]
    ON [Sugar_RawTyped].[r_Bestallning]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

