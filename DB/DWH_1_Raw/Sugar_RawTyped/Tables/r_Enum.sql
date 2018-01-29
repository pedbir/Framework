CREATE TABLE [Sugar_RawTyped].[r_Enum] (
    [Enum_key]                 INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Enum_bkey]                NVARCHAR (100) NOT NULL,
    [ModuleName]               NVARCHAR (250) NULL,
    [ModuleField]              NVARCHAR (250) NULL,
    [FieldKey]                 NVARCHAR (250) NULL,
    [FieldValue]               NVARCHAR (250) NULL,
    [Deleted]                  INT            NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Enum] PRIMARY KEY CLUSTERED ([Enum_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Enum]
    ON [Sugar_RawTyped].[r_Enum]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
CREATE NONCLUSTERED INDEX [IX_Enum]
    ON [Sugar_RawTyped].[r_Enum]([ModuleName] ASC, [ModuleField] ASC, [FieldKey] ASC, [Deleted] ASC)
    INCLUDE([FieldValue]);

