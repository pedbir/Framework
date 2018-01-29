CREATE TABLE [Netadmin_RawTyped].[r_Adress] (
    [Adress_key]               INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Adress_bkey]              INT            NOT NULL,
    [adrkomid]                 INT            NULL,
    [adrgatid]                 INT            NULL,
    [adrnrid]                  INT            NULL,
    [adrupgid]                 INT            NULL,
    [adrpostid]                INT            NULL,
    [adrortid]                 INT            NULL,
    [ipo_installed_date]       DATE           NULL,
    [adrkodid1]                INT            NULL,
    [adrkodid2]                INT            NULL,
    [adrkodid3]                INT            NULL,
    [adrkodid4]                INT            NULL,
    [adrkodid5]                INT            NULL,
    [adridentitet]             NVARCHAR (100) NULL,
    CONSTRAINT [PK_Netadmin_RawTyped_r_Adress] PRIMARY KEY CLUSTERED ([Adress_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Netadmin_RawTyped_r_Adress]
    ON [Netadmin_RawTyped].[r_Adress]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

