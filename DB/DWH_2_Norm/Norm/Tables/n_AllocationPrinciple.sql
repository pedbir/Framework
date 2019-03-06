CREATE TABLE [Norm].[n_AllocationPrinciple] (
    [AllocationPrinciple_key]   INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [AllocationPrinciple_bkey]  NVARCHAR (50)  NOT NULL,
    [AllocationPrincipleName]   NVARCHAR (255) NULL,
    CONSTRAINT [PK_Norm_n_AllocationPrinciple] PRIMARY KEY CLUSTERED ([AllocationPrinciple_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_AllocationPrinciple]
    ON [Norm].[n_AllocationPrinciple]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

