

CREATE VIEW [CityNetwork].[d_Area]
AS
SELECT		da.Area_key
			, da.Area_bkey
			, AreaName								= ISNULL(da.AreaName, 'N/A')
			, MetroNetworkManager					= ISNULL(Employee_MetroNetworkManager_key.EmployeeName, 'N/A')
			, RegionConstructionManager				= ISNULL(Employee_RegionConstructionManager_key.EmployeeName, 'N/A')
			, DeliveryStreamLeader					= ISNULL(Employee_DeliveryStreamLeader_key.EmployeeName, 'N/A')
			, ConstructionManager					= ISNULL(Employee_ConstructionManager_key.EmployeeName, 'N/A')
			, ConstructionStatus					= ISNULL(SugarEnum_ConstructionStatus_key.FieldValue, 'N/A')
			, SalesStatus							= ISNULL(SugarEnum_SalesStatus_key.FieldValue, 'N/A')
			, SourcingStatus						= ISNULL(SugarEnum_SourcingStatus_key.FieldValue, 'N/A')
			, IikStatus								= ISNULL(SugarEnum_IikStatus_key.FieldValue, 'N/A')
			, AreaType								= ISNULL(SugarEnum_AreaType_key.FieldValue, 'N/A')
			, Contractor							= ISNULL(SugarEnum_Contractor_key.FieldValue, 'N/A')
			, SalesOrganisation						= ISNULL(SugarEnum_SalesOrganisation_key.FieldValue, 'N/A')
			, ConstructionOrganisation				= ISNULL(SugarEnum_ConstructionOrganisation_key.FieldValue, 'N/A')
			, SubsidyArea							= ISNULL(SugarEnum_SubsidyArea_key.FieldValue, 'N/A')
			, ProjectDesign							= ISNULL(SugarEnum_ProjectDesign_key.FieldValue, 'N/A')
			, CountyAdvisoryBoardStatus				= ISNULL(SugarEnum_CountyAdvisoryBoardStatus_key.FieldValue, 'N/A')
			, MonthsSinceCommunication				= ISNULL(CEILING(da.CustomerCommunicationCount / 30.5), 0)
			, CommunicationPhase					= ISNULL(da.CommunicationPhase, 'N/A')
FROM		[$(DWH_3_Fact)].Fact.d_Area da
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_Employee Employee_MetroNetworkManager_key
			ON Employee_MetroNetworkManager_key.Employee_key			= da.Employee_MetroNetworkManager_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_Employee Employee_RegionConstructionManager_key
			ON Employee_RegionConstructionManager_key.Employee_key		= da.Employee_RegionConstructionManager_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_Employee Employee_DeliveryStreamLeader_key
			ON Employee_DeliveryStreamLeader_key.Employee_key			= da.Employee_DeliveryStreamLeader_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_Employee Employee_ConstructionManager_key
			ON Employee_ConstructionManager_key.Employee_key			= da.Employee_ConstructionManager_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_ConstructionStatus_key
			ON SugarEnum_ConstructionStatus_key.SugarEnum_key			= da.SugarEnum_ConstructionStatus_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_SalesStatus_key
			ON SugarEnum_SalesStatus_key.SugarEnum_key					= da.SugarEnum_SalesStatus_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_SourcingStatus_key
			ON SugarEnum_SourcingStatus_key.SugarEnum_key				= da.SugarEnum_SourcingStatus_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_IikStatus_key
			ON SugarEnum_IikStatus_key.SugarEnum_key					= da.SugarEnum_IikStatus_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_AreaType_key
			ON SugarEnum_AreaType_key.SugarEnum_key						= da.SugarEnum_AreaType_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_Contractor_key
			ON SugarEnum_Contractor_key.SugarEnum_key					= da.SugarEnum_Contractor_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_SalesOrganisation_key
			ON SugarEnum_SalesOrganisation_key.SugarEnum_key			= da.SugarEnum_SalesOrganisation_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_ConstructionOrganisation_key
			ON SugarEnum_ConstructionOrganisation_key.SugarEnum_key		= da.SugarEnum_ConstructionOrganisation_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_SubsidyArea_key
			ON SugarEnum_SubsidyArea_key.SugarEnum_key					= da.SugarEnum_SubsidyArea_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_ProjectDesign_key
			ON SugarEnum_ProjectDesign_key.SugarEnum_key				= da.SugarEnum_ProjectDesign_key
LEFT JOIN	[$(DWH_3_Fact)].Fact.d_SugarEnum SugarEnum_CountyAdvisoryBoardStatus_key
			ON SugarEnum_CountyAdvisoryBoardStatus_key.SugarEnum_key	= da.SugarEnum_CountyAdvisoryBoardStatus_key