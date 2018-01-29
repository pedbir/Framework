
CREATE VIEW Fact.d_Scenario
AS

SELECT ns.Scenario_key
		 , ns.SysModifiedUTC
		 , ns.SysIsInferred
		 , ns.SysValidFromDateTime
		 , ns.SysSrcGenerationDateTime
		 , ns.Scenario_bkey
		 , ns.ScenarioName
		 , ns.ScenarioCategoryCode
		 , ns.ScenarioCategoryName
		 , ns.ScenarioSubCategoryCode 
FROM Norm.n_Scenario ns