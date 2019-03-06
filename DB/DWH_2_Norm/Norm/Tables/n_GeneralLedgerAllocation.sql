CREATE TABLE [Norm].[n_GeneralLedgerAllocation] (
    [SysExecutionLog_key]          INT             NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)   NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)   NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)   NULL,
    [SysDatetimeReprocessedUTC]    DATETIME2 (0)   NULL,
    [SysModifiedUTC]               DATETIME2 (0)   NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (3)   NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)   NULL,
    [GeneralLedgerAllocation_bkey] NVARCHAR (100)  NOT NULL,
    [AllocationPercent_bkey]       NVARCHAR (50)   NULL,
    [AllocationPrinciple_bkey]     NVARCHAR (50)   NULL,
    [FinanceVendor_From_bkey]      NVARCHAR (100)  NULL,
    [GLAccount_From_bkey]          NVARCHAR (100)  NULL,
    [LegalEntity_From_bkey]        NVARCHAR (100)  NULL,
    [Calender_From_bkey]           DATETIME        NULL,
    [FinanceSegment_To_bkey]       NVARCHAR (100)  NULL,
    [AllocationPercent]            NUMERIC (38, 6) NULL,
    [GLAccountLegalEntity_bkey]    NVARCHAR (100)  NULL,
    [AllocationSource]             VARCHAR (17)    NULL,
    CONSTRAINT [PK_Norm_n_GeneralLedgerAllocation] PRIMARY KEY CLUSTERED ([GeneralLedgerAllocation_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);












GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_GeneralLedgerAllocation]
    ON [Norm].[n_GeneralLedgerAllocation]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

