CREATE TABLE [Sugar_RawTyped].[r_Affarsmojlighet] (
    [Affarsmojlighet_key]      INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]      INT            NOT NULL,
    [SysDatetimeInsertedUTC]   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]    DATETIME2 (0)  NULL,
    [SysModifiedUTC]           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]            BIT            NOT NULL,
    [SysValidFromDateTime]     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime] DATETIME2 (0)  NULL,
    [Affarsmojlighet_bkey]     NVARCHAR (100) NOT NULL,
    [Name]                     NVARCHAR (255) NULL,
    [Deleted]                  INT            NULL,
    [OrdernummerCavaC]         NVARCHAR (255) NULL,
    [AffarstypC]               NVARCHAR (50)  NULL,
    CONSTRAINT [PK_Sugar_RawTyped_r_Affarsmojlighet] PRIMARY KEY CLUSTERED ([Affarsmojlighet_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE)
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Sugar_RawTyped_r_Affarsmojlighet]
    ON [Sugar_RawTyped].[r_Affarsmojlighet]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);

