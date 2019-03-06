CREATE TABLE [Norm].[n_ReportStructure] (
    [ReportStructure_key]       INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [ReportStructure_bkey]      NVARCHAR (100) NOT NULL,
    [ReportStructureLvl1Code]   NVARCHAR (50)  NULL,
    [ReportStructureLvl1Name]   NVARCHAR (250) NULL,
    [ReportStructureLvl2Code]   NVARCHAR (50)  NULL,
    [ReportStructureLvl2Name]   NVARCHAR (250) NULL,
    [ReportStructureLvl3Code]   NVARCHAR (50)  NULL,
    [ReportStructureLvl3Name]   NVARCHAR (250) NULL,
    CONSTRAINT [PK_Norm_n_ReportStructure] PRIMARY KEY CLUSTERED ([ReportStructure_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_ReportStructure]
    ON [Norm].[n_ReportStructure]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

