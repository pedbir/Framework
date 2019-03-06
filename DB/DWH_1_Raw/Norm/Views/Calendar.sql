CREATE VIEW [Norm].[Calendar]
AS

SELECT SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
	,CAST('1900-01-01' AS DATETIME2(0)) AS SysSrcGenerationDateTime
	,CAST(NULL AS DATETIME2(0)) AS SysDatetimeDeletedUTC
	,CAST(GETUTCDATE() AS DATETIME2(0)) AS SysModifiedUTC
	,Calendar_bkey = CAST(t.Calendar_bkey AS DATETIME)	
	,CalendarDate = CAST(t.Calendar_bkey AS DATE)	
FROM fn_Calendar('2015-01-01', CAST(YEAR(GETDATE()) + 3 AS NVARCHAR(4)) + '-12-31') t