CREATE TABLE [Norm].[n_Opportunity] (
    [Opportunity_key]                INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]            INT            NOT NULL,
    [SysDatetimeInsertedUTC]         DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]          DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]                 DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                  BIT            NOT NULL,
    [SysValidFromDateTime]           DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]       DATETIME2 (0)  NULL,
    [Opportunity_bkey]               NVARCHAR (100) NOT NULL,
    [Area_bkey]                      NVARCHAR (100) NOT NULL,
    [Access_bkey]                    INT            NOT NULL,
    [Address_bkey]                   NVARCHAR (100) NOT NULL,
    [Employee_SalesResponsible_bkey] NVARCHAR (100) NOT NULL,
    [OpportunityName]                NVARCHAR (255) NULL,
    [SugarEnum_BusinessType_bkey]    NVARCHAR (250) NULL,
    [CustomerType]                   NVARCHAR (150) NULL,
    [Fastighetsbeteckningc]          NVARCHAR (255) NULL,
    [AcquiredAccess]                 VARCHAR (7)    NOT NULL,
    CONSTRAINT [PK_Norm_n_Opportunity] PRIMARY KEY CLUSTERED ([Opportunity_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);














GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Opportunity]
    ON [Norm].[n_Opportunity]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];


GO


