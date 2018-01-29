CREATE TABLE [Fact].[f_Penetration] (
    [SysExecutionLog_key]           INT            NOT NULL,
    [SysDatetimeInsertedUTC]        DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]         DATETIME2 (0)  NULL,
    [SysModifiedUTC]                DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]      DATETIME2 (0)  NULL,
    [SysValidFromDateTime]          DATETIME2 (0)  NOT NULL,
    [SysDatetimeDeletedUTC]         DATETIME2 (0)  NULL,
    [Calendar_key]                  INT            NULL,
    [Penetration_key]               NVARCHAR (250) NOT NULL,
    [Opportunity_key]               INT            NOT NULL,
    [Area_key]                      INT            NOT NULL,
    [Project_key]                   INT            NOT NULL,
    [Geography_key]                 INT            NOT NULL,
    [Address_key]                   INT            NOT NULL,
    [SalesOrder_key]                INT            NOT NULL,
    [Customer_key]                  INT            NOT NULL,
    [Employee_SalesResponsible_key] INT            NOT NULL,
    [Access_key]                    INT            NOT NULL,
    [NoOfHP]                        INT            NULL,
    [NoOfHC]                        INT            NULL,
    [NoOfInstalled]                 INT            NOT NULL,
    [NoOfBacklog]                   INT            NULL,
    CONSTRAINT [PK_Fact_f_Penetration] PRIMARY KEY CLUSTERED ([Penetration_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_f_Penetration]
    ON [Fact].[f_Penetration]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

