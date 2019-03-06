CREATE TABLE [Norm].[n_DepositAccount] (
    [DepositAccount_key]        INT           IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]       INT           NOT NULL,
    [SysDatetimeInsertedUTC]    DATETIME2 (0) NOT NULL,
    [SysDatetimeUpdatedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeDeletedUTC]     DATETIME2 (0) NULL,
    [SysDatetimeReprocessedUTC] DATETIME2 (0) NULL,
    [SysModifiedUTC]            DATETIME2 (0) NOT NULL,
    [SysIsInferred]             BIT           NOT NULL,
    [SysValidFromDateTime]      DATETIME2 (0) NOT NULL,
    [SysSrcGenerationDateTime]  DATETIME2 (0) NOT NULL,
    [DepositAccount_bkey]       INT           NOT NULL,
    [ProductCode]               VARCHAR (50)  NULL,
    [ProductName]               VARCHAR (50)  NULL,
    [Openingdate]               DATETIME      NULL,
    [Firstdepostitdate]         DATETIME      NULL,
    [Closingdate]               DATETIME      NULL,
    CONSTRAINT [PK_Norm_n_DepositAccount] PRIMARY KEY CLUSTERED ([DepositAccount_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_DepositAccount]
    ON [Norm].[n_DepositAccount]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

