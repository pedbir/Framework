CREATE TABLE [Metadata].[EnvironmentVariables] (
    [Id]                                       INT            IDENTITY (1, 1) NOT NULL,
    [StagingEnvironmentName]                   VARCHAR (50)   NULL,
    [NormEnvironmentName]                      VARCHAR (50)   NULL,
    [MartEnvironmentName]                      VARCHAR (50)   NULL,
    [DefaultTableCompressionType]              VARCHAR (50)   CONSTRAINT [DF_EnvironmentVariables_DefaultTableCompressionType] DEFAULT ('PAGE') NOT NULL,
    [DefaultSSISIncrementalLoad]               BIT            CONSTRAINT [DF_EnvironmentVariables_DefaultSSISIncrementalLoad] DEFAULT ((1)) NOT NULL,
    [DefaultSSISConfigurationFrameWorkCatalog] NVARCHAR (50)  CONSTRAINT [DF_EnvironmentVariables_DefaultSSISConfigurationFrameWorkCatalog] DEFAULT (N'DWH_0_Admin') NOT NULL,
    [DefaultDtsConfigEnvironmentVariableName]  NVARCHAR (50)  CONSTRAINT [DF_EnvironmentVariables_DefaultDtsConfigEnvironmentVariableName] DEFAULT (N'J.dwautogen_SSISAdminConfig') NOT NULL,
    [DefaultNormLayerIndexStorageLocation]     NVARCHAR (128) CONSTRAINT [DF_EnvironmentVariables_DefaultNormLayerIndexStorageLocation] DEFAULT (N'Norm_Index') NOT NULL,
    [DefaultNormLayerDataStorageLocation]      NVARCHAR (128) CONSTRAINT [DF_EnvironmentVariables_DefaultNormLayerDataStorageLocation] DEFAULT (N'Norm_Data') NOT NULL,
    [DefaultMartLayerIndexStorageLocation]     NVARCHAR (128) CONSTRAINT [DF_EnvironmentVariables_DefaultMartLayerIndexStorageLocation] DEFAULT (N'Fact_Index') NOT NULL,
    [DefaultMartLayerDataStorageLocation]      NVARCHAR (128) CONSTRAINT [DF_EnvironmentVariables_DefaultMartLayerDataStorageLocation] DEFAULT (N'Fact_Data') NOT NULL,
    [RawEnvironmentName]                       VARCHAR (50)   NULL,
    [DefaultRawLayerIndexStorageLocation]      VARCHAR (50)   DEFAULT ('PRIMARY') NOT NULL,
    [DefaultRawLayerDataStorageLocation]       VARCHAR (50)   DEFAULT ('PRIMARY') NOT NULL,
    CONSTRAINT [PK_EnvironmentVariables] PRIMARY KEY CLUSTERED ([Id] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Fact_Data', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultMartLayerDataStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the efile group that will be used when creating the destination/target table in the mart layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultMartLayerDataStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Fact_Index', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultMartLayerIndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the file group that will be used when creating non clustered indexes in the destination/target table in the mart layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultMartLayerIndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Norm_Data', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultNormLayerDataStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the efile group that will be used when creating the destination/target table in the norm layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultNormLayerDataStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Norm_Index', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultNormLayerIndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the file group that will be used when creating non clustered indexes in the destination/target table in the norm layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultNormLayerIndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'J_dwautogen_SSISAdminConfig', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultDtsConfigEnvironmentVariableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the environment variable that will be used in SSIS packages', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultDtsConfigEnvironmentVariableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_0_Admin', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultSSISConfigurationFrameWorkCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) where the configurations and logging tables/functions/stored procedures resides (in run time)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultSSISConfigurationFrameWorkCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultSSISIncrementalLoad';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The indicator (the default one) whether the integrations should use incremental load or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultSSISIncrementalLoad';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'PAGE, ROW, NONE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultTableCompressionType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The type of compression (the default one) to use when creating tables', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'DefaultTableCompressionType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_3_Fact', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'MartEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the database that will be used as mart layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'MartEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_2_Norm', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'NormEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the database that will be used as norm layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'NormEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_1_Raw', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'StagingEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name (the default one) of the database that will be used as staging layer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'StagingEnvironmentName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1,2,3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'Id';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'EnvironmentVariables', @level2type = N'COLUMN', @level2name = N'Id';

