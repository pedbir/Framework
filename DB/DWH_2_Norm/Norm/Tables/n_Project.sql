CREATE TABLE [Norm].[n_Project] (
    [Project_key]               INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [Project_bkey]              NVARCHAR (100) NOT NULL,
    [ProjectName]               NVARCHAR (250) NULL,
    [ProgramID]                 NVARCHAR (100) NULL,
    [Category1ID]               NVARCHAR (100) NULL,
    [Category2ID]               NVARCHAR (100) NULL,
    [PlanFinish]                DATETIME       NULL,
    [CloseDate]                 DATETIME       NULL,
    [NumOfHP]                   INT            NULL,
    [NumOfHC]                   INT            NULL,
    CONSTRAINT [PK_Norm_n_Project] PRIMARY KEY CLUSTERED ([Project_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Project]
    ON [Norm].[n_Project]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

