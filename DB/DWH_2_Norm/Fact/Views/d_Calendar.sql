
CREATE VIEW Fact.d_Calendar
AS
SELECT  nc.SysSrcGenerationDateTime
        , nc.SysValidFromDateTime
        , nc.SysModifiedUTC
        , nc.SysDatetimeDeletedUTC
        , Calendar_key    = CAST(CONVERT(NVARCHAR(8), nc.Calendar_bkey, 112) AS INT)
        , nc.Calendar_bkey
        , CalendarYear    = DATEPART(yyyy, nc.Calendar_bkey)
        , YearMonth       = CAST(DATEPART(yyyy, nc.Calendar_bkey) AS VARCHAR(4)) + '-' + RIGHT(CONVERT(VARCHAR(6), nc.Calendar_bkey, 112), 2)
        , YearWeek        = CAST(DATEPART(yyyy, nc.Calendar_bkey) AS VARCHAR(4)) + '-W' + CAST(DATEPART(wk, nc.Calendar_bkey) AS VARCHAR(2))
        , YearQuarter     = CAST(DATEPART(yyyy, nc.Calendar_bkey) AS VARCHAR(4)) + '-Q' + CAST(DATEPART(qq, nc.Calendar_bkey) AS VARCHAR(2))
        , CalendarQuarter = DATEPART(qq, nc.Calendar_bkey)
        , MonthofYear     = DATEPART(mm, nc.Calendar_bkey)
        , MonthName       = CAST(UPPER(LEFT(DATENAME(m, nc.Calendar_bkey), 1)) + SUBSTRING(DATENAME(m, nc.Calendar_bkey), 2, LEN(nc.Calendar_bkey)) AS VARCHAR(10))
        , WeekOfYear      = DATEPART(wk, nc.Calendar_bkey)
        , DayofWeek       = DATEPART(dw, nc.Calendar_bkey)
        , DayName         = CAST(UPPER(LEFT(DATENAME(dw, nc.Calendar_bkey), 1)) + SUBSTRING(DATENAME(dw, nc.Calendar_bkey), 2, LEN(nc.Calendar_bkey)) AS CHAR(10))
        , DayofMonth      = DATEPART(DAY, nc.Calendar_bkey)
FROM    Norm.n_Calendar nc
WHERE nc.Calendar_key <> -1