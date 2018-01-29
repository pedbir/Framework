
CREATE VIEW Norm_d.Planning
AS


SELECT  SysDatetimeDeletedUTC         = CAST(IIF(State = 'Deleted', LastChgDateTime, NULL) AS DATETIME2(0))
        , SysModifiedUTC              = CAST(LastChgDateTime AS DATETIME2(0))
        , SysValidFromDateTime        = CAST(LastChgDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime    = CAST(EnterDateTime AS DATETIME2(0))
		, Planning_bkey = ID
		 , Scenario_bkey = Scenario_Code
		 , Phase_bkey = Phase_Code
		 , CustomerCategory_bkey = CustomerCategory_ID
		 , P01
		 , P02
		 , P03
		 , P04
		 , P05
		 , P06
		 , P07
		 , P08
		 , P09
		 , P10
		 , P11
		 , P12
FROM OPENQUERY(MDS, 'SELECT * FROM DWH_0_MDM.[mdm].[Planning]') oq