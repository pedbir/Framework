CREATE TABLE [BamsNo_RawTyped].[r_ApplicationUser] (
    [ApplicationUser_key]      INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [ApplicationUser_bkey]     NVARCHAR (100) NOT NULL,
    [ApplicationId]            NVARCHAR (100) NULL,
    [EmployeeID]               NVARCHAR (100) NULL,
    [OwnerRoleID]              NVARCHAR (100) NULL,
    [OwnerRole]                NVARCHAR (150) NULL,
    CONSTRAINT [PK_BamsNo_RawTyped_r_ApplicationUser] PRIMARY KEY CLUSTERED ([ApplicationUser_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationId_OwnerRole_SysValidFromDateTime]
    ON [BamsNo_RawTyped].[r_ApplicationUser]([ApplicationId] ASC, [OwnerRole] ASC, [SysValidFromDateTime] DESC);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsNo_RawTyped_r_ApplicationUser]
    ON [BamsNo_RawTyped].[r_ApplicationUser]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

