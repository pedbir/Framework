CREATE TABLE [Sugar_RawTyped].[r_User] (
    [User_key]                 INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [User_bkey]                NVARCHAR (100) NOT NULL,
    [Username]                 NVARCHAR (100) NULL,
    [Deleted]                  INT            NULL,
    [FirstName]                NVARCHAR (30)  NULL,
    [LastName]                 NVARCHAR (30)  NULL,
    [Title]                    NVARCHAR (50)  NULL,
    [Department]               NVARCHAR (50)  NULL,
    [EmployeeStatus]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_User] PRIMARY KEY CLUSTERED ([User_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_User]
    ON [Sugar_RawTyped].[r_User]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

