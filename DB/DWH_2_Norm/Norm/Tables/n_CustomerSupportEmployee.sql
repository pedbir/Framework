CREATE TABLE [Norm].[n_CustomerSupportEmployee] (
    [CustomerSupportEmployee_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]          INT            NOT NULL,
    [SysDatetimeInsertedUTC]       DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]        DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]               DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                BIT            NOT NULL,
    [SysValidFromDateTime]         DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]     DATETIME2 (0)  NULL,
    [CustomerSupportEmployee_bkey] NVARCHAR (100) NOT NULL,
    [UserName]                     NVARCHAR (100) NULL,
    [FirstName]                    NVARCHAR (50)  NULL,
    [SurName]                      NVARCHAR (50)  NULL,
    [PrimaryEmailAddress]          NVARCHAR (256) NULL,
    CONSTRAINT [PK_Norm_n_CustomerSupportEmployee] PRIMARY KEY CLUSTERED ([CustomerSupportEmployee_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_CustomerSupportEmployee]
    ON [Norm].[n_CustomerSupportEmployee]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

