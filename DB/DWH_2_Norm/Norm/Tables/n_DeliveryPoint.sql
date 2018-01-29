CREATE TABLE [Norm].[n_DeliveryPoint] (
    [DeliveryPoint_key]         INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [DeliveryPoint_bkey]        NVARCHAR (100) NOT NULL,
    [Delivery_bkey]             NVARCHAR (100) NOT NULL,
    [Access_bkey]               INT            NULL,
    [Address_bkey]              NVARCHAR (100) NOT NULL,
    [DeliveryPointName]         NVARCHAR (255) NULL,
    [CustomerType]              NVARCHAR (150) NULL,
    CONSTRAINT [PK_Norm_n_DeliveryPoint] PRIMARY KEY CLUSTERED ([DeliveryPoint_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);








GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_DeliveryPoint]
    ON [Norm].[n_DeliveryPoint]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO
CREATE NONCLUSTERED INDEX [IX_Access_bkey]
    ON [Norm].[n_DeliveryPoint]([Access_bkey] ASC, [SysValidFromDateTime] DESC)
    INCLUDE([Delivery_bkey], [Address_bkey])
    ON [Norm_Data];

