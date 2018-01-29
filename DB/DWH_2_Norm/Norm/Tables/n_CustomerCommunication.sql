CREATE TABLE [Norm].[n_CustomerCommunication] (
    [CustomerCommunication_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]        INT            NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]  DATETIME2 (0)  NULL,
    [SysModifiedUTC]             DATETIME2 (0)  NOT NULL,
    [SysIsInferred]              BIT            NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0)  NULL,
    [CustomerCommunication_bkey] NVARCHAR (100) NOT NULL,
    [Area_bkey]                  NVARCHAR (100) NOT NULL,
    [CommunicationPhase]         NVARCHAR (128) NULL,
    [CustomerCommunicationCount] INT            NULL,
    CONSTRAINT [PK_Norm_n_CustomerCommunication] PRIMARY KEY CLUSTERED ([CustomerCommunication_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_CustomerCommunication]
    ON [Norm].[n_CustomerCommunication]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

