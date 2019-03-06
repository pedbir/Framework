CREATE TABLE [Fact].[d_ReportStructure] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [ReportStructure_key]      INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [ReportStructure_bkey]     NVARCHAR (100) NOT NULL,
    [ReportStructureLvl1Code]  NVARCHAR (50)  NULL,
    [ReportStructureLvl1Name]  NVARCHAR (250) NULL,
    [ReportStructureLvl2Code]  NVARCHAR (50)  NULL,
    [ReportStructureLvl2Name]  NVARCHAR (250) NULL,
    [ReportStructureLvl3Code]  NVARCHAR (50)  NULL,
    [ReportStructureLvl3Name]  NVARCHAR (250) NULL,
    CONSTRAINT [PK_Fact_d_ReportStructure] PRIMARY KEY CLUSTERED ([ReportStructure_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_ReportStructure]
    ON [Fact].[d_ReportStructure]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

