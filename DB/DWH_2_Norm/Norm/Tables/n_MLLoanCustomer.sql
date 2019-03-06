CREATE TABLE [Norm].[n_MLLoanCustomer] (
    [MLLoanCustomer_key]           INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]          INT            NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]               DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                BIT            NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)  NULL,
    [MLLoanCustomer_bkey]          NVARCHAR (100) NOT NULL,
    [BirthYear]                    INT            NULL,
    [Gender]                       NVARCHAR (20)  NULL,
    [City]                         NVARCHAR (100) NULL,
    [Zip]                          NVARCHAR (100) NULL,
    [MaritalStatusCode]            NVARCHAR (100) NULL,
    [MaritalStatusText]            NVARCHAR (100) NULL,
    [PriceLevelCode]               NVARCHAR (100) NULL,
    [PriceLevelText]               NVARCHAR (100) NULL,
    [RiskgroupCode]                NVARCHAR (100) NULL,
    [RiskgroupText]                NVARCHAR (100) NULL,
    [DebtKFM]                      INT            NULL,
    [AccomodationTypeCode]         NVARCHAR (100) NULL,
    [AccomodationTypeText]         NVARCHAR (100) NULL,
    [TotalNumberOfRemarks]         INT            NULL,
    [NumberOfRemarks]              INT            NULL,
    [TotalSumOfRemarks]            INT            NULL,
    [SumOfRemarks]                 INT            NULL,
    [PrenupDateString]             NVARCHAR (20)  NULL,
    [WarningCode]                  NVARCHAR (100) NULL,
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
    CONSTRAINT [PK_Norm_n_MLLoanCustomer] PRIMARY KEY CLUSTERED ([MLLoanCustomer_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
) ON [Norm_Data];






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_MLLoanCustomer]
    ON [Norm].[n_MLLoanCustomer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

