CREATE VIEW Norm_d.CustomerCategory
AS
SELECT  SysDatetimeDeletedUTC         = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC              = CAST(LastChgDateTime AS DATETIME2(0))
        , SysValidFromDateTime        = CAST(LastChgDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime    = CAST(EnterDateTime AS DATETIME2(0))
        , CustomerCategory_bkey       = cc.ID
		, CustomerCategoryCode		= cc.Code
        , CustomerCategory = cc.Name
        , SalesHierarchy
        , SugarEnum_BusinessType_bkey = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.BusinessType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_AreaType_bkey     = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.AreaType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_OrderType_bkey    = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.OrderType))) AS NVARCHAR(100)), ''), '%')
        , OpportunityCustomerType     = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.OpportunityCustomerType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_SubsidyArea_bkey  = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.SubsidyArea))) AS NVARCHAR(100)), ''), '%')
FROM OPENQUERY(MDS, 'SELECT * FROM DWH_0_MDM.[mdm].[CustomerCategory]') cc