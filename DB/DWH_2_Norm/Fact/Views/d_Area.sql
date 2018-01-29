CREATE VIEW Fact.d_Area
AS

SELECT  na.Area_key
        , na.SysDatetimeDeletedUTC
        , na.SysModifiedUTC
        , na.SysIsInferred
        , na.SysValidFromDateTime
        , na.SysSrcGenerationDateTime
        , na.Area_bkey
        , na.AreaName
        , Geography_key								= ISNULL(ng.Geography_key, -1)
        , Project_key								= ISNULL(np.Project_key, -1)
        , Employee_MetroNetworkManager_key			= ISNULL(Employee_MetroNetworkManager_bkey.Employee_key, -1)
        , Employee_RegionConstructionManager_key	= ISNULL(Employee_RegionConstructionManager_bkey.Employee_key, -1)
        , Employee_DeliveryStreamLeader_key			= ISNULL(Employee_DeliveryStreamLeader_bkey.Employee_key, -1)
        , Employee_ConstructionManager_key			= ISNULL(Employee_ConstructionManager_bkey.Employee_key, -1)
		, na.Employee_MetroNetworkManager_bkey			
        , na.Employee_RegionConstructionManager_bkey
        , na.Employee_DeliveryStreamLeader_bkey			
        , na.Employee_ConstructionManager_bkey
        , SugarEnum_ConstructionStatus_key			= ISNULL(SugarEnum_ConstructionStatus_bkey.SugarEnum_key, -1)
        , SugarEnum_SalesStatus_key					= ISNULL(SugarEnum_SalesStatus_bkey.SugarEnum_key, -1)
        , SugarEnum_SourcingStatus_key				= ISNULL(SugarEnum_SourcingStatus_bkey.SugarEnum_key, -1)
        , SugarEnum_IikStatus_key					= ISNULL(SugarEnum_IikStatus_bkey.SugarEnum_key, -1)
        , SugarEnum_AreaType_key					= ISNULL(SugarEnum_AreaType_bkey.SugarEnum_key, -1)
        , SugarEnum_Contractor_key					= ISNULL(SugarEnum_Contractor_bkey.SugarEnum_key, -1)
        , SugarEnum_SalesOrganisation_key			= ISNULL(SugarEnum_SalesOrganisation_bkey.SugarEnum_key, -1)
        , SugarEnum_ConstructionOrganisation_key	= ISNULL(SugarEnum_ConstructionOrganisation_bkey.SugarEnum_key, -1)
        , SugarEnum_SubsidyArea_key					= ISNULL(SugarEnum_SubsidyArea_bkey.SugarEnum_key, -1)
        , SugarEnum_ProjectDesign_key				= ISNULL(SugarEnum_ProjectDesign_bkey.SugarEnum_key, -1)
        , SugarEnum_CountyAdvisoryBoardStatus_key	= ISNULL(SugarEnum_CountyAdvisoryBoardStatus_bkey.SugarEnum_key, -1)
        , na.InitialSalesStart
        , na.AfterMarketSalesStart
        , na.StrategicNetworkPlanningComplete
        , na.LeasedUplinkExpected
        , na.LeasedUplinkDeployed
        , na.TRVPermissionNeeded
        , na.SumOfTRVNeeded
        , na.SumOfTRVSubmitted
        , na.SumOfTRVApproved
        , na.ExpectedApprovalOfTRV
        , na.AllTRVApplicationsSubmitted
        , na.AllTRVApplicationsApproved
        , na.CommentOnTRV
        , na.MunicipalLandPermit
        , na.BuildingPermitApproved
        , na.AllBuildingPermitsSubmitted
        , na.CommentOnBuildingPermit
        , na.PlannedInstallationStart
        , na.PlannedInstallationComplete
        , na.PlannedConstructionStart
        , na.FinalDocumentationComplete
		, cc.CustomerCommunicationCount
		, cc.CommunicationPhase
FROM    Norm.n_Area na
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Geography ng WHERE ng.Geography_bkey = na.Geography_bkey ORDER BY ng.SysValidFromDateTime DESC) ng
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np WHERE np.Project_bkey = na.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = na.Employee_MetroNetworkManager_bkey ORDER BY ne.SysValidFromDateTime DESC) Employee_MetroNetworkManager_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = na.Employee_RegionConstructionManager_bkey ORDER BY ne.SysValidFromDateTime DESC) Employee_RegionConstructionManager_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = na.Employee_DeliveryStreamLeader_bkey ORDER BY ne.SysValidFromDateTime DESC) Employee_DeliveryStreamLeader_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = na.Employee_ConstructionManager_bkey ORDER BY ne.SysValidFromDateTime DESC) Employee_ConstructionManager_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_ConstructionStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_ConstructionStatus_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_SalesStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_SalesStatus_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_SourcingStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_SourcingStatus_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_IikStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_IikStatus_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_AreaType_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_AreaType_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_Contractor_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_Contractor_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_SalesOrganisation_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_SalesOrganisation_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_ConstructionOrganisation_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_ConstructionOrganisation_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_SubsidyArea_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_SubsidyArea_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_ProjectDesign_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_ProjectDesign_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = na.SugarEnum_CountyAdvisoryBoardStatus_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_CountyAdvisoryBoardStatus_bkey
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_CustomerCommunication cc WHERE cc.CustomerCommunication_bkey = na.Area_bkey ORDER BY cc.SysValidFromDateTime DESC) cc