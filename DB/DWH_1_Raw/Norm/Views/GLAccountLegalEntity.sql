

CREATE VIEW [Norm].[GLAccountLegalEntity]
AS
SELECT    SysSrcGenerationDateTime  = CAST(NULL AS DATETIME2(0))
         ,SysModifiedUTC            = CAST(GETUTCDATE() AS DATETIME2(0))
         ,SysValidFromDateTime      = CAST(GETUTCDATE() AS DATETIME2(0))
         ,SysDatetimeDeletedUTC     = CAST(NULL AS DATETIME2(0))
         ,GLAccountLegalEntity_bkey = CAST(CAST(ISNULL(rh.Account, '-1') AS NVARCHAR(50)) + '#' + ISNULL(rh.Client, '-1') AS NVARCHAR(100))
		 ,GLAccount_bkey            = CAST(CAST(ISNULL(rh.Account, '-1') AS NVARCHAR(50)) + '#' + ISNULL(rh.Client, '-1') AS NVARCHAR(100))
         ,LegalEntity_bkey          = CAST(ISNULL(RTRIM(LTRIM(UPPER(Client))), '-1') AS NVARCHAR(100))
FROM      Agresso_RawTyped.rt_Huvudbok_01 rh
GROUP BY  Account
         ,Client