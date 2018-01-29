CREATE TABLE [Sugar_RawTyped].[r_Contact] (
    [Contact_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Contact_bkey]             NVARCHAR (100) NOT NULL,
    [deleted]                  INT            NULL,
    [FirstName]                NVARCHAR (100) NULL,
    [LastName]                 NVARCHAR (100) NULL,
    [Title]                    NVARCHAR (100) NULL,
    [ContactDescription]       NVARCHAR (500) NULL,
    [AssignedUserId]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Contact] PRIMARY KEY CLUSTERED ([Contact_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Contact]
    ON [Sugar_RawTyped].[r_Contact]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

