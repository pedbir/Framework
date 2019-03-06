CREATE TABLE [Norm].[n_Fields] (
    [Fields_key]                INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NOT NULL,
    [Fields_bkey]               INT            NOT NULL,
    [TableName]                 NVARCHAR (100) NULL,
    [ColumnName]                NVARCHAR (100) NULL,
    [Category]                  NVARCHAR (5)   NULL,
    CONSTRAINT [PK_Norm_n_Fields] PRIMARY KEY CLUSTERED ([Fields_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Fields]
    ON [Norm].[n_Fields]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

