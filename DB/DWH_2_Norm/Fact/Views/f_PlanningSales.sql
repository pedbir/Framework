CREATE VIEW Fact.f_PlanningSales
AS

SELECT nps.SysDatetimeDeletedUTC
      ,nps.SysModifiedUTC
      ,nps.SysValidFromDateTime
      ,nps.SysSrcGenerationDateTime
      ,PlanningSales_key = nps.PlanningSales_bkey
      ,nfs.FinanceSegment_key
	  ,nps.FinanceSegment_bkey
      ,nps.PlanningMetricCode
      ,nps.PlanningMetric
	  ,nps.PeriodCode
      ,nps.PlanningScenarioCode
      ,nps.PlanningScenario      
      ,Calendar_Period_key = CAST(nps.Calendar_Period_bkey AS DATE)
      ,nps.PlanningAmount
      ,nps.EnterUserName
      ,nps.LastChgUserName       
FROM (SELECT *, _isFirst = LAG(0,1,1) OVER (PARTITION BY nps.PlanningSales_bkey ORDER BY nps.SysValidFromDateTime DESC) FROM Norm.n_PlanningSales nps) nps
OUTER APPLY (SELECT TOP 1 nfs.FinanceSegment_key FROM Norm.n_FinanceSegment nfs WHERE nfs.FinanceSegment_bkey = nps.FinanceSegment_bkey ORDER BY nfs.SysValidFromDateTime DESC) nfs
WHERE _isFirst = 1 AND nps.PlanningSales_bkey <> '-1'