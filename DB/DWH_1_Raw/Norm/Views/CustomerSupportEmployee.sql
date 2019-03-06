
CREATE VIEW Norm.CustomerSupportEmployee
AS
SELECT  SysDatetimeDeletedUTC        = IIF(rbu.ACTIVE = 1, GETUTCDATE(), SysDatetimeDeletedUTC)
       ,rbu.SysModifiedUTC
       ,rbu.SysValidFromDateTime
       ,rbu.SysSrcGenerationDateTime
       ,CustomerSupportEmployee_bkey = CAST(rbu.BamsUser_bkey + '#NO' AS NVARCHAR(100))
       ,UserName                     = rbu.UserName
       ,FirstName                    = rbu.FirstName
       ,SurName                      = rbu.SurName
       ,PrimaryEmailAddress          = ISNULL(rbu.PrimaryEmailAddress, 'N/A')
FROM    BamsNo_RawTyped.r_BamsUser rbu
WHERE   rbu.BamsUser_bkey <> '-1'
UNION ALL
SELECT  SysDatetimeDeletedUTC        = IIF(rbu.ACTIVE = 1, GETUTCDATE(), SysDatetimeDeletedUTC)
       ,rbu.SysModifiedUTC
       ,rbu.SysValidFromDateTime
       ,rbu.SysSrcGenerationDateTime
       ,CustomerSupportEmployee_bkey = CAST(rbu.BamsUser_bkey + '#SE' AS NVARCHAR(100))
       ,UserName                     = rbu.UserName
       ,FirstName                    = rbu.FirstName
       ,SurName                      = rbu.SurName
       ,PrimaryEmailAddress          = ISNULL(rbu.PrimaryEmailAddress, 'N/A')
FROM    BamsSe_RawTyped.r_BamsUser rbu
WHERE   rbu.BamsUser_bkey <> '-1'