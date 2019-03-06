CREATE VIEW Fact.d_Calendar
AS

SELECT  nc.SysDatetimeDeletedUTC
       ,nc.SysModifiedUTC
       ,nc.SysIsInferred
       ,nc.SysValidFromDateTime
       ,nc.SysSrcGenerationDateTime       
	   ,Calendar_key	= CAST(nc.Calendar_bkey AS date)	   
       ,CalendarYear    = DATEPART(yyyy, Calendar_bkey)
       ,YearMonth       = CAST(DATEPART(yyyy, Calendar_bkey) AS VARCHAR(4)) + '-' + RIGHT(CONVERT(VARCHAR(6), Calendar_bkey, 112), 2)
       ,YearWeek        = CAST(YEAR(DATEADD(day, 26 - DATEPART(isoww, Calendar_bkey), Calendar_bkey)) AS VARCHAR(4)) + '-W' + CAST(DATEPART(isoww, Calendar_bkey) AS VARCHAR(2))
       ,YearQuarter     = CAST(DATEPART(yyyy, Calendar_bkey) AS VARCHAR(4)) + '-Q' + CAST(DATEPART(qq, Calendar_bkey) AS VARCHAR(2))
       ,CalendarQuarter = 'Q' + CAST(DATEPART(qq, Calendar_bkey) AS VARCHAR(2))	   
       ,MonthofYear     = DATEPART(mm, Calendar_bkey)
       ,MonthName       = CAST(UPPER(LEFT(DATENAME(m, Calendar_bkey), 1)) + SUBSTRING(DATENAME(m, Calendar_bkey), 2, LEN(Calendar_bkey)) AS VARCHAR(10))
       ,WeekOfYear      = DATEPART(isowk, Calendar_bkey)
       ,DayofWeek       = DATEPART(dw, Calendar_bkey)
       ,DayName         = CAST(UPPER(LEFT(DATENAME(dw, Calendar_bkey), 1)) + SUBSTRING(DATENAME(dw, Calendar_bkey), 2, LEN(Calendar_bkey)) AS CHAR(10))
       ,DayofMonth      = DATEPART(DAY, Calendar_bkey)
	   ,YearMonthId		= CAST(CONVERT(NVARCHAR(6), nc.Calendar_bkey, 112) AS INT)
	   ,DateId			= CAST(CONVERT(NVARCHAR(8), nc.Calendar_bkey, 112) AS INT)	   
	   ,YearWeekId		= YEAR(DATEADD(day, 26 - DATEPART(isoww, Calendar_bkey), Calendar_bkey)) * 100 + DATEPART(isoww, Calendar_bkey)	  
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY CAST(nc.Calendar_bkey AS date) ORDER BY nc.SysValidFromDateTime DESC) FROM Norm.n_Calendar nc) nc
WHERE nc._isFirst = 1