CREATE VIEW Fact.f_Planning
AS

SELECT	unpvt.SysDatetimeDeletedUTC
		, unpvt.SysModifiedUTC
		, unpvt.SysValidFromDateTime
		, Planning_key = CAST(unpvt.Planning_key AS NVARCHAR(100)) + '#' + unpvt.PlanningPeriod
		, Calendar_key = CAST(CONVERT(NVARCHAR(8), EOMONTH(CAST(LEFT(unpvt.Scenario_bkey, 4) + RIGHT(PlanningPeriod, 2) + '01'AS DATE)), 112) AS INT)
		, vcc.CustomerCategory_key		
		, unpvt.Scenario_bkey		
		, ns.Scenario_key
		, Phase_bkey		
		, PlanningPeriod
		, Amount		
FROM	(	SELECT	np.Planning_key
					, np.SysDatetimeDeletedUTC
					, np.SysModifiedUTC
					, np.SysValidFromDateTime
					, np.Planning_bkey
					, np.Scenario_bkey
					, np.Phase_bkey
					, np.CustomerCategory_bkey
					, np.P01
					, np.P02
					, np.P03
					, np.P04
					, np.P05
					, np.P06
					, np.P07
					, np.P08
					, np.P09
					, np.P10
					, np.P11
					, np.P12
			FROM	Norm.vn_Planning np
			WHERE	np.Planning_bkey <> '-1') p 
			UNPIVOT(Amount FOR PlanningPeriod IN(P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12))unpvt
INNER JOIN Norm.vn_CustomerCategory vcc ON vcc.CustomerCategory_bkey = unpvt.CustomerCategory_bkey AND vcc._isLast = 1
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_Scenario ns WHERE ns.Scenario_bkey = unpvt.Scenario_bkey ORDER BY ns.SysValidFromDateTime DESC) ns