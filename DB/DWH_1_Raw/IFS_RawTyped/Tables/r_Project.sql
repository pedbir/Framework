CREATE TABLE [IFS_RawTyped].[r_Project] (
    [Project_key]              INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Project_bkey]             NVARCHAR (100) NOT NULL,
    [Name]                     NVARCHAR (250) NULL,
    [ProgramID]                NVARCHAR (100) NULL,
    [Category1ID]              NVARCHAR (100) NULL,
    [Category2ID]              NVARCHAR (100) NULL,
    [ObjState]                 NVARCHAR (100) NULL,
    [PlanFinish]               DATETIME       NULL,
    [CloseDate]                DATETIME       NULL,
    [NumOfHP]                  INT            NULL,
    [NumOfHC]                  INT            NULL,
    [NumOfHCAM]                INT            NULL,
    [NumOfMDU]                 INT            NULL,
    [NumOfCORP]                INT            NULL,
    CONSTRAINT [PK_IFS_RawTyped_r_Project] PRIMARY KEY CLUSTERED ([Project_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_IFS_RawTyped_r_Project]
    ON [IFS_RawTyped].[r_Project]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

