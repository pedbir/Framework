CREATE TABLE [Cava_RawTyped].[r_NDBUser] (
    [NDBUser_key]              INT              IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT              NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)    NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)    NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)    NULL,
    [SysModifiedUTC]           DATETIME2 (0)    NOT NULL,
    [SysIsInferred]            BIT              NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)    NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)    NULL,
    [NDBUser_bkey]             NVARCHAR (50)    NOT NULL,
    [NDBUserID]                INT              NULL,
    [ObjectGUID]               UNIQUEIDENTIFIER NULL,
    [FirstName]                NVARCHAR (50)    NULL,
    [LastName]                 NVARCHAR (50)    NULL,
    [Active]                   BIT              NULL,
    [Email]                    NVARCHAR (150)   NULL,
    [MobilePhone]              NVARCHAR (100)   NULL,
    [TelephoneNumber]          NVARCHAR (100)   NULL,
    [Department]               NVARCHAR (250)   NULL,
    [Title]                    NVARCHAR (250)   NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_NDBUser] PRIMARY KEY CLUSTERED ([NDBUser_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_NDBUser]
    ON [Cava_RawTyped].[r_NDBUser]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

