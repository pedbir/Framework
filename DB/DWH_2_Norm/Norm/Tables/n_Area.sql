CREATE TABLE [Norm].[n_Area] (
    [Area_key]                                 INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]                      INT            NOT NULL,
    [SysDatetimeInsertedUTC]                   DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]                    DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]                    DATETIME2 (0)  NULL,
    [SysDatetimeReprocessedUTC]                DATETIME2 (0)  NULL,
    [SysModifiedUTC]                           DATETIME2 (0)  NOT NULL,
    [SysIsInferred]                            BIT            NOT NULL,
    [SysValidFromDateTime]                     DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]                 DATETIME2 (0)  NULL,
    [Area_bkey]                                NVARCHAR (100) NOT NULL,
    [AreaName]                                 NVARCHAR (255) NULL,
    [Geography_bkey]                           NVARCHAR (100) NULL,
    [Project_bkey]                             NVARCHAR (100) NULL,
    [Employee_MetroNetworkManager_bkey]        NVARCHAR (100) NULL,
    [Employee_RegionConstructionManager_bkey]  NVARCHAR (100) NULL,
    [Employee_DeliveryStreamLeader_bkey]       NVARCHAR (100) NULL,
    [Employee_ConstructionManager_bkey]        NVARCHAR (100) NULL,
    [SugarEnum_ConstructionStatus_bkey]        NVARCHAR (130) NULL,
    [SugarEnum_SalesStatus_bkey]               NVARCHAR (131) NULL,
    [SugarEnum_SourcingStatus_bkey]            NVARCHAR (131) NULL,
    [SugarEnum_IikStatus_bkey]                 NVARCHAR (122) NULL,
    [SugarEnum_AreaType_bkey]                  NVARCHAR (123) NULL,
    [SugarEnum_Contractor_bkey]                NVARCHAR (127) NULL,
    [SugarEnum_SalesOrganisation_bkey]         NVARCHAR (138) NULL,
    [SugarEnum_ConstructionOrganisation_bkey]  NVARCHAR (138) NULL,
    [SugarEnum_SubsidyArea_bkey]               NVARCHAR (126) NULL,
    [SugarEnum_ProjectDesign_bkey]             NVARCHAR (128) NULL,
    [SugarEnum_CountyAdvisoryBoardStatus_bkey] NVARCHAR (136) NULL,
    [InitialSalesStart]                        DATE           NULL,
    [AfterMarketSalesStart]                    DATE           NULL,
    [StrategicNetworkPlanningComplete]         DATE           NULL,
    [LeasedUplinkExpected]                     DATE           NULL,
    [LeasedUplinkDeployed]                     DATE           NULL,
    [TRVPermissionNeeded]                      NVARCHAR (100) NULL,
    [SumOfTRVNeeded]                           INT            NULL,
    [SumOfTRVSubmitted]                        INT            NULL,
    [SumOfTRVApproved]                         INT            NULL,
    [ExpectedApprovalOfTRV]                    DATE           NULL,
    [AllTRVApplicationsSubmitted]              DATE           NULL,
    [AllTRVApplicationsApproved]               DATE           NULL,
    [CommentOnTRV]                             NVARCHAR (255) NULL,
    [MunicipalLandPermit]                      DATE           NULL,
    [BuildingPermitApproved]                   DATE           NULL,
    [AllBuildingPermitsSubmitted]              DATE           NULL,
    [CommentOnBuildingPermit]                  NVARCHAR (255) NULL,
    [PlannedInstallationStart]                 DATE           NULL,
    [PlannedInstallationComplete]              DATE           NULL,
    [PlannedConstructionStart]                 DATE           NULL,
    [FinalDocumentationComplete]               DATE           NULL,
    [CustomerCommunicationCount]               INT            NULL,
    CONSTRAINT [PK_Norm_n_Area] PRIMARY KEY CLUSTERED ([Area_bkey] ASC, [SysValidFromDateTime] ASC) WITH (DATA_COMPRESSION = PAGE) ON [Norm_Data]
);






GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_Norm_n_Area]
    ON [Norm].[n_Area]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE)
    ON [Norm_Index];

