CREATE TABLE [Fact].[d_Project] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [Project_key]              INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [Project_bkey]             NVARCHAR (100) NOT NULL,
    [ProjectCode]              NVARCHAR (100) NULL,
    [ProjectName]              NVARCHAR (250) NULL,
    [Status]                   NVARCHAR (3)   NULL,
    [UpdatedBy]                NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Fact_d_Project] PRIMARY KEY CLUSTERED ([Project_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Project]
    ON [Fact].[d_Project]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

