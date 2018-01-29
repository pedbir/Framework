CREATE TABLE [Sugar_RawTyped].[r_Leveransobjekt] (
    [Leveransobjekt_key]                             INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]                            INT            NOT NULL,
    [SysDatetimeInsertedUTC]                         DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]                          DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]                          DATETIME2 (0)  NULL,
    [SysModifiedUTC]                                 DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                                  BIT            NOT NULL,
    [SysValidFromDateTime]                           DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]                       DATETIME2 (0)  NULL,
    [Leveransobjekt_bkey]                            NVARCHAR (100) NOT NULL,
    [Name]                                           NVARCHAR (255) NULL,
    [Deleted]                                        INT            NULL,
    [Fastighetsbeteckningc]                          NVARCHAR (255) NULL,
    [Byggnationsstatusc]                             NVARCHAR (100) NULL,
    [Iikbeslutc]                                     NVARCHAR (100) NULL,
    [Stadsnatc]                                      NVARCHAR (100) NULL,
    [Kommunc]                                        NVARCHAR (100) NULL,
    [Regionc]                                        NVARCHAR (100) NULL,
    [Typavortc]                                      NVARCHAR (100) NULL,
    [Planeradbyggstartc]                             DATE           NULL,
    [Planeradbyggavslutc]                            DATE           NULL,
    [Planeradstartkundinstallc]                      DATE           NULL,
    [Projektidifsc]                                  NVARCHAR (255) NULL,
    [Entreprenorddc]                                 NVARCHAR (100) NULL,
    [Ansvarigsaljorganisationc]                      NVARCHAR (100) NULL,
    [Ansvarigbyggorganisationc]                      NVARCHAR (100) NULL,
    [Affarstypc]                                     NVARCHAR (255) NULL,
    [Klarrapporteradcavac]                           NVARCHAR (100) NULL,
    [Ipgeografiipleveransobjektipgeografiida]        NVARCHAR (100) NULL,
    [Opportunitiesipleveransobjekt1opportunitiesida] NVARCHAR (100) NULL,
    [Contactsipleveransobjekt2contactsida]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Leveransobjekt] PRIMARY KEY CLUSTERED ([Leveransobjekt_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Leveransobjekt]
    ON [Sugar_RawTyped].[r_Leveransobjekt]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

