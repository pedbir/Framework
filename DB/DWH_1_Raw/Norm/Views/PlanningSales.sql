CREATE VIEW Norm.PlanningSales
AS
SELECT  SysValidFromDateTime     = CAST(LastChgDateTime AS DATETIME2(0))
       ,SysSrcGenerationDateTime = CAST(EnterDateTime AS DATETIME2(0))
       ,SysDatetimeDeletedUTC    = CAST(IIF(State = 'Deleted', LastChgDateTime, NULL) AS DATETIME2(0))
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,PlanningSales_bkey       = CAST(CAST(up.ID AS NVARCHAR(50)) + '#' + up.Period AS NVARCHAR(100))
       ,FinanceSegment_bkey      = CAST(up.Segment_Code			 as nvarchar(100))
       ,PlanningMetricCode       = CAST(up.PlanningMetric_Code	 as nvarchar(100))
       ,PlanningMetric           = CAST(up.PlanningMetric_Name	 as nvarchar(200))
       ,PlanningScenarioCode     = CAST(up.PlanningScenario_Code as nvarchar(100))
       ,PlanningScenario         = CAST(up.PlanningScenario_Name as nvarchar(200))
       ,PeriodCode               = CAST(up.Period				 as nvarchar(100))
       ,Calendar_Period_bkey     = DATETIMEFROMPARTS(LEFT(up.PlanningScenario_Code, 4), CAST(REPLACE(up.Period, 'P', '') AS INT), 1, 0, 0, 0, 0)
       ,PlanningAmount           = CAST(up.PlanningAmount AS MONEY)
       ,up.EnterUserName
       ,up.LastChgUserName
FROM    OPENQUERY(MDS, '
SELECT  Segment_Code
       ,PlanningMetric_Code
       ,PlanningMetric_Name
       ,PlanningScenario_Code
       ,PlanningScenario_Name       
       ,PlanningAmount       = CAST(up.PlanningAmount AS MONEY)
       ,up.Period
	   ,up.ID
	   ,LastChgDateTime
	   ,EnterDateTime
	   ,State
	   ,EnterUserName
	   ,LastChgUserName
FROM    MDS.mdm.PlanningSales ps
  UNPIVOT (PlanningAmount FOR Period IN (P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12)) up
'
) up

GO

