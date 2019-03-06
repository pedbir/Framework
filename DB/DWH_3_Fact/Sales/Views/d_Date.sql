CREATE VIEW Sales.d_Date
AS
SELECT  dc.Calendar_key
       ,dc.CalendarYear
       ,dc.YearMonth
       ,dc.YearWeek
       ,dc.YearQuarter
       ,dc.CalendarQuarter
       ,dc.MonthofYear
       ,dc.MonthName
       ,dc.WeekOfYear
       ,dc.DayofWeek
       ,dc.DayName
       ,dc.DayofMonth
       ,IsCurrentMonth     = CASE EOMONTH(dc.Calendar_key) WHEN EOMONTH(GETDATE()) THEN 'Current'
                                                           WHEN EOMONTH(DATEADD(MONTH, -1, GETDATE())) THEN 'Past'
                                                           WHEN EOMONTH(DATEADD(MONTH, 1, GETDATE())) THEN 'Next' ELSE 'N/A' END
       ,IsCurrentMonthSort = CASE EOMONTH(dc.Calendar_key) WHEN EOMONTH(GETDATE()) THEN 1
                                                           WHEN EOMONTH(DATEADD(MONTH, -1, GETDATE())) THEN 2
                                                           WHEN EOMONTH(DATEADD(MONTH, 1, GETDATE())) THEN 0 ELSE -1 END
       ,dc.YearMonthId
	   ,dc.YearWeekId
FROM    Fact.d_Calendar dc
WHERE   dc.Calendar_key <> '1900-01-01'