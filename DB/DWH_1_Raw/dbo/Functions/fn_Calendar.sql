

CREATE FUNCTION [dbo].[fn_Calendar] 
(	@p_StartDate DateTime,
	@p_EndDate DateTime 

)
RETURNS TABLE 
AS
RETURN 
(
	


With Base As 
( 
      Select 1 as n 
      Union All 
      Select n+1 From Base Where n < Ceiling(SQRT(Datediff(day,@p_StartDate,@p_EndDate) + 1)) 
), 
Expand As 
( 
      Select 1 as C 
      From Base as B1, Base as B2 
), 
Nums As 
( 
      Select Row_Number() OVER(ORDER BY C) As n 
      From Expand 
) , 
CalcDate AS
(
	select Dateadd(day,n-1,@p_StartDate) as Datum_nk
	from Nums
	Where n<=Datediff(day,@p_StartDate,@p_EndDate) + 1
)
 
--Main Query to generate Calendar table 
SELECT
	Datum_nk as [Calendar_bkey]  
	,datepart(yyyy,Datum_nk) as CalendarYear
	,cast(datepart(yyyy,Datum_nk) as varchar(4)) + '-' + RIGHT(convert(varchar(6), Datum_nk, 112), 2) as YearMonth
	,cast(datepart(yyyy,Datum_nk) as varchar(4)) + '-W' + cast(datepart(wk,Datum_nk) as varchar(2)) as YearWeek
	,cast(datepart(yyyy,Datum_nk) as varchar(4)) + '-Q' + cast(datepart(qq, Datum_nk) as varchar(2)) as [YearQuarter]
	,datepart(qq, Datum_nk) as CalendarQuarter
	,datepart(mm,Datum_nk) as MonthofYear
	,cast(UPPER(LEFT(DATENAME(m,Datum_nk),1)) + SUBSTRING(DATENAME(m,Datum_nk),2,LEN(Datum_nk)) as varchar(10)) as [MonthName]
	,datepart(wk,Datum_nk) as [WeekOfYear]
	,datepart(dw,Datum_nk) as DayofWeek
	,CAST(UPPER(LEFT(DATENAME(dw,Datum_nk),1)) + SUBSTRING(DATENAME(dw,Datum_nk),2,LEN(Datum_nk)) as char(10))  as [DayName]
	,datepart(day,Datum_nk) as DayofMonth
From CalcDate  
 
 
 
)