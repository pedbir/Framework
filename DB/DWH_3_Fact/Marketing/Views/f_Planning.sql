CREATE VIEW Marketing.[f_Planning]
AS

SELECT fps.FinanceSegment_key            
	  ,fps.PlanningScenarioCode
      ,fps.PlanningScenario
      ,fps.Calendar_Period_key
      ,PayoutAmount = CASE PlanningMetricCode WHEN 'PayoutAmount' THEN fps.PlanningAmount ELSE 0 END
	  ,NrPayoutLoans = CASE PlanningMetricCode WHEN 'NrPayoutLoans' THEN fps.PlanningAmount ELSE 0 END      
FROM Fact.f_PlanningSales fps