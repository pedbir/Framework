﻿CREATE TABLE [Norm].[n_CustomerCategory] (
    [CustomerCategory_key]        INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]         INT            NOT NULL,
    [SysDatetimeInsertedUTC]      DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]       DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]       DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]   DATETIME2 (0)  NULL,
    [SysModifiedUTC]              DATETIME2 (0)  NOT NULL,
    [SysIsInferred]               BIT            NOT NULL,
    [SysValidFromDateTime]        DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]    DATETIME2 (0)  NULL,
    [CustomerCategory_bkey]       INT            NOT NULL,
    [CustomerCategoryCode]        NVARCHAR (250) NOT NULL,
    [CustomerCategory]            NVARCHAR (250) NULL,
    [SalesHierarchy]              NVARCHAR (100) NULL,
    [SugarEnum_BusinessType_bkey] NVARCHAR (100) NOT NULL,
    [SugarEnum_AreaType_bkey]     NVARCHAR (100) NOT NULL,
    [SugarEnum_OrderType_bkey]    NVARCHAR (100) NOT NULL,
    [OpportunityCustomerType]     NVARCHAR (100) NOT NULL,
    [SugarEnum_SubsidyArea_bkey]  NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Norm_n_CustomerCategory] PRIMARY KEY CLUSTERED ([CustomerCategory_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_CustomerCategory]
    ON [Norm].[n_CustomerCategory]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

