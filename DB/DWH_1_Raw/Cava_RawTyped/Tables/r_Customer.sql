CREATE TABLE [Cava_RawTyped].[r_Customer] (
    [Customer_key]             INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Customer_bkey]            INT            NOT NULL,
    [FullName]                 NVARCHAR (255) NULL,
    [OrgNo]                    NVARCHAR (255) NULL,
    [SuperOfficeUser]          NVARCHAR (50)  NULL,
    [SegmentID]                INT            NULL,
    [MasterSystemID]           NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Cava_RawTyped_r_Customer] PRIMARY KEY CLUSTERED ([Customer_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);




GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Cava_RawTyped_r_Customer]
    ON [Cava_RawTyped].[r_Customer]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

