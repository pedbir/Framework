CREATE TABLE [BamsSe_RawTyped].[r_Customer] (
    [Customer_key]                 INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]          INT            NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)  NULL,
    [SysModifiedUTC]               DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                BIT            NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)  NULL,
    [Customer_bkey]                NVARCHAR (100) NOT NULL,
    [BirthYear]                    INT            NULL,
    [Gender]                       NVARCHAR (20)  NULL,
    [City]                         NVARCHAR (100) NULL,
    [Zip]                          NVARCHAR (100) NULL,
    [MaritalStatusCODE]            NVARCHAR (100) NULL,
    [MaritalStatusText]            NVARCHAR (100) NULL,
    [PriceLevelCODE]               NVARCHAR (100) NULL,
    [PriceLevelText]               NVARCHAR (100) NULL,
    [RiskgroupCODE]                NVARCHAR (100) NULL,
    [RiskgroupText]                NVARCHAR (100) NULL,
    [DebtKFM]                      INT            NULL,
    [AccomodationTypeCODE]         NVARCHAR (100) NULL,
    [AccomodationTypeText]         NVARCHAR (100) NULL,
    [TotalNumberOfRemarks]         INT            NULL,
    [NumberOfRemarks]              INT            NULL,
    [TotalSumOfRemarks]            INT            NULL,
    [SumOfRemarks]                 INT            NULL,
    [PrenupDateString]             NVARCHAR (20)  NULL,
    [WarningCODE]                  NVARCHAR (100) NULL,
    [WarningText]                  NVARCHAR (100) NULL,
    [IsPep]                        BIT            NULL,
    [AssessmentYear]               INT            NULL,
    [AssessedIncome]               INT            NULL,
    [IsBankrupt]                   BIT            NULL,
    [LastRemarkDate]               DATETIME2 (0)  NULL,
    [LastBankruptDate]             DATETIME2 (0)  NULL,
    [TotalNumberOfMortgageRemarks] INT            NULL,
    [NumberOfMortgageRemarks]      INT            NULL,
    [SumOfMortgageRemarks]         INT            NULL,
    CONSTRAINT [PK_BamsSe_RawTyped_r_Customer] PRIMARY KEY CLUSTERED ([Customer_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsSe_RawTyped_r_Customer]
    ON [BamsSe_RawTyped].[r_Customer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

