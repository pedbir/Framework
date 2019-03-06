CREATE VIEW Finance.d_VoucherDate
AS
SELECT Voucherdate_key = dc.Calendar_key
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
FROM Fact.d_Calendar dc