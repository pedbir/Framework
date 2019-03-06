CREATE TABLE [Fact].[d_GLAccount] (
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [GLAccount_key]            INT            NOT NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [GLAccount_bkey]           NVARCHAR (100) NOT NULL,
    [GLAccountName]            NVARCHAR (300) NULL,
    [GLAccountGroupCode]       NVARCHAR (50)  NULL,
    [GLAccountGroup]           NVARCHAR (200) NULL,
    [GLAccountType]            NVARCHAR (10)  NULL,
    [GLAccountCode]            NVARCHAR (50)  NULL,
    [GLAccountHierarchy1Code]  NVARCHAR (100) NULL,
    [GLAccountHierarchy1Name]  NVARCHAR (100) NULL,
    [GLAccountHierarchy2Code]  NVARCHAR (100) NULL,
    [GLAccountHierarchy2Name]  NVARCHAR (100) NULL,
    [GLAccountHierarchy3Code]  NVARCHAR (100) NULL,
    [GLAccountHierarchy3Name]  NVARCHAR (100) NULL,
    [LegalEntity_bkey]         NVARCHAR (100) NULL,
    [Status]                   NVARCHAR (3)   NULL,
    CONSTRAINT [PK_Fact_d_GLAccount] PRIMARY KEY CLUSTERED ([GLAccount_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_GLAccount]
    ON [Fact].[d_GLAccount]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

