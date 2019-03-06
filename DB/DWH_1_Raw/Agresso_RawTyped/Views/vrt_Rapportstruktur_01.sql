
CREATE VIEW Agresso_RawTyped.vrt_Rapportstruktur_01
AS
SELECT TOP 0  SysFileName
       ,SysDatetimeInsertedUTC
       ,SysDatetimeUpdatedUTC
       ,SysDatetimeDeletedUTC
       ,SysSrcGenerationDateTime
       ,SysModifiedUTC
       ,SysExecutionLog_key
       ,Recno
       ,Section
       ,Tab
       ,ID
       ,Account
       ,Ftg
       ,Segment
       ,Kst
       ,Str0account
       ,Str1account
       ,Str2account
       ,Str3account
       ,LastUpdate
       ,Percentage
       ,UserId
FROM    ( SELECT  *
                 ,_isFirst = LAG(0, 1, 1) OVER (PARTITION BY ID ORDER BY SysSrcGenerationDateTime DESC)
          FROM    Agresso_RawTyped.rt_Rapportstruktur_01) t
WHERE   t._isFirst = 1