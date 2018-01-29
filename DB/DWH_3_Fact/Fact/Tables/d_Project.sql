CREATE TABLE [Fact].[d_Project] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [Project_key]              INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Project_bkey]             NVARCHAR (100) NOT NULL,
    [ProjectName]              NVARCHAR (250) NOT NULL,
    [ProgramID]                NVARCHAR (100) NOT NULL,
    [Category1ID]              NVARCHAR (100) NOT NULL,
    [Category2ID]              NVARCHAR (100) NOT NULL,
    [PlanFinish]               DATETIME       NULL,
    [CloseDate]                DATETIME       NULL,
    CONSTRAINT [PK_Fact_d_Project] PRIMARY KEY CLUSTERED ([Project_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Project]
    ON [Fact].[d_Project]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

