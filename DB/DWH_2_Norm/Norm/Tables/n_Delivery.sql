CREATE TABLE [Norm].[n_Delivery] (
    [Delivery_key]                      INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]               INT            NOT NULL,
    [SysDatetimeInsertedUTC]            DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]             DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]             DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                    DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                     BIT            NOT NULL,
    [SysValidFromDateTime]              DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]          DATETIME2 (0)  NULL,
    [Delivery_bkey]                     NVARCHAR (100) NOT NULL,
    [Agreement_bkey]                    INT            NOT NULL,
    [Geography_bkey]                    NVARCHAR (100) NULL,
    [Project_bkey]                      NVARCHAR (100) NULL,
    [DeliveryName]                      NVARCHAR (255) NULL,
    [SugarEnum_BusinessType_bkey]       NVARCHAR (250) NULL,
    [Employee_ConstructionManager_bkey] NVARCHAR (100) NULL,
    CONSTRAINT [PK_Norm_n_Delivery] PRIMARY KEY CLUSTERED ([Delivery_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Delivery]
    ON [Norm].[n_Delivery]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

