



CREATE VIEW [Fact].[d_Delivery]
AS

SELECT  nd.Delivery_key
        , nd.SysDatetimeDeletedUTC
        , nd.SysModifiedUTC
        , nd.SysIsInferred
        , nd.SysValidFromDateTime
        , nd.SysSrcGenerationDateTime
        , nd.Delivery_bkey
        , DeliveryName								= ISNULL(nd.DeliveryName, 'N/A')
        , Geography_key								= ISNULL(ng.Geography_key, -1)
        , Project_key								= ISNULL(np.Project_key, -1)
        , Employee_ConstructionManager_key			= ISNULL(Employee_ConstructionManager_bkey.Employee_key, -1)
FROM    Norm.n_Delivery nd
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Geography ng WHERE ng.Geography_bkey = nd.Geography_bkey ORDER BY ng.SysValidFromDateTime DESC) ng
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np WHERE np.Project_bkey = nd.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Employee ne WHERE ne.Employee_bkey = nd.Employee_ConstructionManager_bkey ORDER BY ne.SysValidFromDateTime DESC) Employee_ConstructionManager_bkey