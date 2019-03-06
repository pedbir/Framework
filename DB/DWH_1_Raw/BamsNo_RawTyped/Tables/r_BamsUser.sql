CREATE TABLE [BamsNo_RawTyped].[r_BamsUser] (
    [BamsUser_key]             INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [BamsUser_bkey]            NVARCHAR (100) NOT NULL,
    [UserName]                 NVARCHAR (100) NULL,
    [FirstName]                NVARCHAR (50)  NULL,
    [SurName]                  NVARCHAR (50)  NULL,
    [ACTIVE]                   BIT            NULL,
    [PrimaryEmailAddress]      NVARCHAR (256) NULL,
    CONSTRAINT [PK_BamsNo_RawTyped_r_BamsUser] PRIMARY KEY CLUSTERED ([BamsUser_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsNo_RawTyped_r_BamsUser]
    ON [BamsNo_RawTyped].[r_BamsUser]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

