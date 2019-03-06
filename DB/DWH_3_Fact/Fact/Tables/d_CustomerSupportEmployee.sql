CREATE TABLE [Fact].[d_CustomerSupportEmployee] (
    [SysExecutionLog_key]          INT            NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)  NULL,
    [SysModifiedUTC]               DATETIME2 (0)  NOT NULL,
    [CustomerSupportEmployee_key]  INT            NOT NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)  NULL,
    [SysIsInferred]                BIT            NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)  NULL,
    [CustomerSupportEmployee_bkey] NVARCHAR (100) NOT NULL,
    [UserName]                     NVARCHAR (100) NULL,
    [FirstName]                    NVARCHAR (50)  NULL,
    [SurName]                      NVARCHAR (50)  NULL,
    [PrimaryEmailAddress]          NVARCHAR (256) NULL,
    CONSTRAINT [PK_Fact_d_CustomerSupportEmployee] PRIMARY KEY CLUSTERED ([CustomerSupportEmployee_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_CustomerSupportEmployee]
    ON [Fact].[d_CustomerSupportEmployee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

