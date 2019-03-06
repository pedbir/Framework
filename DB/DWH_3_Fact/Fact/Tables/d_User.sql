CREATE TABLE [Fact].[d_User] (
    [SysExecutionLog_key]    INT            NOT NULL,
    [SysDatetimeInsertedUTC] DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]         DATETIME2 (0)  NOT NULL,
    [User_key]               NVARCHAR (100) NOT NULL,
    [SysDatetimeDeletedUTC]  DATETIME2 (0)  NULL,
    CONSTRAINT [PK_Fact_d_User] PRIMARY KEY CLUSTERED ([User_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_User]
    ON [Fact].[d_User]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

