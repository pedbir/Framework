CREATE TABLE [Fact].[d_Area] (
    [SysExecutionLog_key]                     INT            NOT NULL,
    [SysDatetimeInsertedUTC]                  DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]                   DATETIME2 (0)  NULL,
    [SysModifiedUTC]                          DATETIME2 (0)  NOT NULL,
    [Area_key]                                INT            NOT NULL,
    [SysDatetimeDeletedUTC]                   DATETIME2 (0)  NULL,
    [SysIsInferred]                           BIT            NOT NULL,
    [SysValidFromDateTime]                    DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]                DATETIME2 (0)  NULL,
    [Area_bkey]                               NVARCHAR (100) NOT NULL,
    [AreaName]                                NVARCHAR (255) NULL,
    [Geography_key]                           INT            NOT NULL,
    [Project_key]                             INT            NOT NULL,
    [Employee_MetroNetworkManager_key]        INT            NOT NULL,
    [Employee_RegionConstructionManager_key]  INT            NOT NULL,
    [Employee_DeliveryStreamLeader_key]       INT            NOT NULL,
    [Employee_ConstructionManager_key]        INT            NOT NULL,
    [Employee_MetroNetworkManager_bkey]       NVARCHAR (100) NULL,
    [Employee_RegionConstructionManager_bkey] NVARCHAR (100) NULL,
    [Employee_DeliveryStreamLeader_bkey]      NVARCHAR (100) NULL,
    [Employee_ConstructionManager_bkey]       NVARCHAR (100) NULL,
    [SugarEnum_ConstructionStatus_key]        INT            NOT NULL,
    [SugarEnum_SalesStatus_key]               INT            NOT NULL,
    [SugarEnum_SourcingStatus_key]            INT            NOT NULL,
    [SugarEnum_IikStatus_key]                 INT            NOT NULL,
    [SugarEnum_AreaType_key]                  INT            NOT NULL,
    [SugarEnum_Contractor_key]                INT            NOT NULL,
    [SugarEnum_SalesOrganisation_key]         INT            NOT NULL,
    [SugarEnum_ConstructionOrganisation_key]  INT            NOT NULL,
    [SugarEnum_SubsidyArea_key]               INT            NOT NULL,
    [SugarEnum_ProjectDesign_key]             INT            NOT NULL,
    [SugarEnum_CountyAdvisoryBoardStatus_key] INT            NOT NULL,
    [InitialSalesStart]                       DATE           NULL,
    [AfterMarketSalesStart]                   DATE           NULL,
    [StrategicNetworkPlanningComplete]        DATE           NULL,
    [LeasedUplinkExpected]                    DATE           NULL,
    [LeasedUplinkDeployed]                    DATE           NULL,
    [TRVPermissionNeeded]                     NVARCHAR (100) NULL,
    [SumOfTRVNeeded]                          INT            NULL,
    [SumOfTRVSubmitted]                       INT            NULL,
    [SumOfTRVApproved]                        INT            NULL,
    [ExpectedApprovalOfTRV]                   DATE           NULL,
    [AllTRVApplicationsSubmitted]             DATE           NULL,
    [AllTRVApplicationsApproved]              DATE           NULL,
    [CommentOnTRV]                            NVARCHAR (255) NULL,
    [MunicipalLandPermit]                     DATE           NULL,
    [BuildingPermitApproved]                  DATE           NULL,
    [AllBuildingPermitsSubmitted]             DATE           NULL,
    [CommentOnBuildingPermit]                 NVARCHAR (255) NULL,
    [PlannedInstallationStart]                DATE           NULL,
    [PlannedInstallationComplete]             DATE           NULL,
    [PlannedConstructionStart]                DATE           NULL,
    [FinalDocumentationComplete]              DATE           NULL,
    [CustomerCommunicationCount]              INT            NULL,
    [CommunicationPhase]                      NVARCHAR (128) NULL,
    CONSTRAINT [PK_Fact_d_Area] PRIMARY KEY CLUSTERED ([Area_key] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Fact_Data]
);










GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Fact_d_Area]
    ON [Fact].[d_Area]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Fact_Index];

