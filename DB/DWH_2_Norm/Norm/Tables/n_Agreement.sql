CREATE TABLE [Norm].[n_Agreement] (
    [Agreement_key]             INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT            NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0)  NULL,
    [SysModifiedUTC]            DATETIME2 (0)  NOT NULL,
    [SysIsInferred]             BIT            NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0)  NULL,
    [Agreement_bkey]            INT            NOT NULL,
    [Customer_bkey]             NVARCHAR (100) NULL,
    [Employee_SalesPerson_bkey] NVARCHAR (255) NULL,
    [AgreementType_bkey]        INT            NOT NULL,
    [OrderNumber]               NVARCHAR (50)  NOT NULL,
    [AgreementDate]             DATETIME       NULL,
    CONSTRAINT [PK_Norm_n_Agreement] PRIMARY KEY CLUSTERED ([Agreement_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Agreement]
    ON [Norm].[n_Agreement]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

