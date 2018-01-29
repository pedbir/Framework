CREATE VIEW Norm_d.Calendar
AS
SELECT  SysValidFromDateTime       = CAST('1900-01-01' AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))        
		, fc.Calendar_bkey
		, CalendarDate = fc.Calendar_bkey
FROM    dbo.fn_Calendar('2012-01-01', DATEADD(YEAR, 2, GETUTCDATE())) fc