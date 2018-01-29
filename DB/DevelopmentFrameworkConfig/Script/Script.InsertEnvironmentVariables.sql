SELECT Id = 1
       , StagingEnvironmentName = 'DWH_1_Raw'
       , NormEnvironmentName = 'DWH_2_Norm'
       , MartEnvironmentName = 'DWH_3_Fact'
       , DefaultTableCompressionType = 'PAGE'
       , DefaultSSISIncrementalLoad = 1
       , DefaultSSISConfigurationFrameWorkCatalog = N'DWH_0_Admin'
       , DefaultDtsConfigEnvironmentVariableName = N'J_dwautogen_SSISAdminConfig'
       , DefaultNormLayerIndexStorageLocation = N'Norm_Index'
       , DefaultNormLayerDataStorageLocation = N'Norm_Data'
       , DefaultMartLayerIndexStorageLocation = N'Fact_Index'
       , DefaultMartLayerDataStorageLocation = N'Fact_Data'
       , RawEnvironmentName = 'DWH_1_Raw'
       , DefaultRawLayerIndexStorageLocation = 'PRIMARY'
       , DefaultRawLayerDataStorageLocation = 'PRIMARY'
INTO #EnvironmentVariables


SET IDENTITY_INSERT [Metadata].[EnvironmentVariables] ON

INSERT INTO Metadata.EnvironmentVariables
        (id 
		, StagingEnvironmentName
        , NormEnvironmentName
        , MartEnvironmentName
        , DefaultTableCompressionType
        , DefaultSSISIncrementalLoad
        , DefaultSSISConfigurationFrameWorkCatalog
        , DefaultDtsConfigEnvironmentVariableName
        , DefaultNormLayerIndexStorageLocation
        , DefaultNormLayerDataStorageLocation
        , DefaultMartLayerIndexStorageLocation
        , DefaultMartLayerDataStorageLocation
        , RawEnvironmentName
        , DefaultRawLayerIndexStorageLocation
        , DefaultRawLayerDataStorageLocation )
SELECT ev.Id
     , ev.StagingEnvironmentName
     , ev.NormEnvironmentName
     , ev.MartEnvironmentName
     , ev.DefaultTableCompressionType
     , ev.DefaultSSISIncrementalLoad
     , ev.DefaultSSISConfigurationFrameWorkCatalog
     , ev.DefaultDtsConfigEnvironmentVariableName
     , ev.DefaultNormLayerIndexStorageLocation
     , ev.DefaultNormLayerDataStorageLocation
     , ev.DefaultMartLayerIndexStorageLocation
     , ev.DefaultMartLayerDataStorageLocation
     , ev.RawEnvironmentName
     , ev.DefaultRawLayerIndexStorageLocation
     , ev.DefaultRawLayerDataStorageLocation 
FROM #EnvironmentVariables ev
WHERE ev.Id NOT IN (SELECT ev2.Id FROM Metadata.EnvironmentVariables ev2)

SET IDENTITY_INSERT [Metadata].[EnvironmentVariables] OFF
