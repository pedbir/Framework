CREATE TABLE [Metadata].[DestinationTable] (
    [SourceTableCatalog]                VARCHAR (128)    NULL,
    [SourceSchemaName]                  VARCHAR (128)    NULL,
    [SourceTableName]                   VARCHAR (128)    NULL,
    [SourceFile]                        VARCHAR (128)    NULL,
    [DestinationTableCatalog]           VARCHAR (128)    NOT NULL,
    [DestinationSchemaName]             VARCHAR (128)    NOT NULL,
    [DestinationTableName]              VARCHAR (128)    NOT NULL,
    [StageTableCatalog]                 VARCHAR (128)    NULL,
    [StageSchemaName]                   VARCHAR (128)    NULL,
    [StageTableName]                    VARCHAR (128)    NULL,
    [CompressionType]                   VARCHAR (50)     CONSTRAINT [DF_DestinationTable_CompressionType] DEFAULT (N'NONE') NOT NULL,
    [SSISPackageName]                   VARCHAR (128)    NOT NULL,
    [SSISPackageGUID]                   UNIQUEIDENTIFIER CONSTRAINT [DF_DestinationTable_SSISPackageGUID] DEFAULT (newid()) NOT NULL,
    [SSISIncrementalLoad]               BIT              CONSTRAINT [DF_DestinationTable_SSISIncrementalLoad] DEFAULT ((0)) NOT NULL,
    [CreateTable]                       TINYINT          NOT NULL,
    [CreateStageTable]                  BIT              CONSTRAINT [DF_DestinationTable_CreateStageTable] DEFAULT ((0)) NOT NULL,
    [CreateChecksumColumns]             BIT              CONSTRAINT [DF_TablesForDestinations_CreateChecksumColumns] DEFAULT ((1)) NOT NULL,
    [CreateChecksumIndexes]             BIT              CONSTRAINT [DF_TablesForDestinations_CreateIndexesForChecksumColumns] DEFAULT ((1)) NOT NULL,
    [CreateSSISPackage]                 TINYINT          CONSTRAINT [DF_DestinationTable_CreateSSISPackage] DEFAULT ((1)) NOT NULL,
    [UseSSISLoggingFrameWork]           TINYINT          CONSTRAINT [DF_DestinationTable_ActivateLoggingFrameWork] DEFAULT ((1)) NOT NULL,
    [SSISConfigurationFrameWorkCatalog] NVARCHAR (50)    CONSTRAINT [DF_DestinationTable_SSISConfigurationFrameWorkCatalog] DEFAULT ('DWH_0_Admin') NOT NULL,
    [DtsConfigEnvironmentVariableName]  NVARCHAR (50)    CONSTRAINT [DF_DestinationTable_DtsConfigEnvironmentVariableName] DEFAULT ('J_dwautogen_SSISAdminConfig') NOT NULL,
    [CDCInstanceName]                   VARCHAR (128)    NULL,
    [SourceSelectClause]                VARCHAR (1000)   NULL,
    [SourceFilterCondition]             VARCHAR (500)    NULL,
    [DestinationDeleteCondition]        VARCHAR (255)    NULL,
    [GroupName]                         VARCHAR (20)     CONSTRAINT [DF_DestinationTable_GroupName] DEFAULT ('All') NOT NULL,
    [DestinationTableID]                INT              IDENTITY (1, 1) NOT NULL,
    [SourceServer]                      VARCHAR (128)    NULL,
    [UserNameInserted]                  VARCHAR (128)    CONSTRAINT [DF_DestinationTable_UserName] DEFAULT (suser_sname()) NULL,
    [DateTimeInsertedUTC]               DATETIME         CONSTRAINT [DF_DestinationTable_DateTimeInsertedUTC] DEFAULT (getutcdate()) NULL,
    [UserNameUpdated]                   VARCHAR (128)    NULL,
    [DateTimeUpdatedUTC]                DATETIME         NULL,
    [StageFilterCondition]              VARCHAR (500)    NULL,
    [IsPartitioned]                     BIT              DEFAULT ((0)) NULL,
    [PartitionFunctionName]             NVARCHAR (128)   NULL,
    [PartitionSchemeName]               NVARCHAR (128)   NULL,
    [PartitionKeyColumnName]            NVARCHAR (128)   NULL,
    [PartitionETLStrategy]              NVARCHAR (128)   NULL,
    [SourceMaxRecursion]                INT              NULL,
    [IsMigrationPackage]                BIT              CONSTRAINT [DF_DestinationTable_IsMigrationPackage] DEFAULT ((0)) NOT NULL,
    [ETLLookupCacheMode]                NVARCHAR (10)    CONSTRAINT [DF_DestinationTable_ETLLookupCacheMode] DEFAULT (N'Full') NOT NULL,
    [RequireTransaction]                BIT              CONSTRAINT [DF_DestinationTable_UseTransactionOnDestination] DEFAULT ((0)) NOT NULL,
    [EmptyTargetTable]                  BIT              CONSTRAINT [DF_DestinationTable_EmptyTargetTable] DEFAULT ((0)) NOT NULL,
    [ETLLookupCacheFilter]              NVARCHAR (1000)  NULL,
    [IsInProduction]                    BIT              CONSTRAINT [DF_IsInProduction] DEFAULT ((0)) NOT NULL,
    [FactScdType]                       TINYINT          NULL,
    CONSTRAINT [PK_Metadata_DestinationTable] PRIMARY KEY CLUSTERED ([SSISPackageName] ASC),
    CONSTRAINT [CK_DestinationTable_CompressionType] CHECK ([CompressionType]='ROW' OR [CompressionType]='PAGE' OR [CompressionType]='NONE'),
    CONSTRAINT [CK_DestinationTable_TargetNotLikeSource] CHECK ([SourceTableCatalog]<>[DestinationTableCatalog] OR [SourceSchemaName]<>[DestinationSchemaName] OR [SourceTableName]<>[DestinationSchemaName]),
    CONSTRAINT [FK_DestinationTable_DestinationTableGroup] FOREIGN KEY ([GroupName]) REFERENCES [Metadata].[DestinationTableGroup] ([GroupName])
);


GO
EXECUTE sp_addextendedproperty @name = N'ExempleValue', @value = N'null, 0, 1', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'FactScdType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDefinition', @value = N'Specifies what type of SCD handling to be used for fact tables. For norm tables set this column to null. ', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'FactScdType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsInProduction';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicates if an integration is in production or not -> not used specifically in any code. To be used wherever you want', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsInProduction';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'ETLLookupCacheFilter';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'ETLLookupCacheFilter';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'EmptyTargetTable';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'EmptyTargetTable';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'RequireTransaction';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Not specifically used in any code -> could be used as a gate keeper for the integration to continue or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'RequireTransaction';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'FULL, PARTIAL', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'ETLLookupCacheMode';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Not currently used in any code -> could be used to indicate if a specific cache mode should be used for lookups in the SSIS packages', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'ETLLookupCacheMode';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsMigrationPackage';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicates if an integration is a migration package or not -> not used specifically in any code. To be used wherever you want', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsMigrationPackage';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceMaxRecursion';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = '', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceMaxRecursion';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Partition Switching', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionETLStrategy';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Not currently used in any code -> could be used to indicate a specific ETL design pattern, e.g. Partition switching', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionETLStrategy';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'SysDatetimeInsertedUTC', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionKeyColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the partition key (column name) to use, when creating a partitioned table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionKeyColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'ps_PartitionByDate', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionSchemeName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the partition function to use, when creating a partitioned table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionSchemeName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'pf_PartitionByDate', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionFunctionName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the partition function to use, when creating a partitioned table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'PartitionFunctionName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsPartitioned';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicates whether the current destination table will be created with partitions or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'IsPartitioned';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '[tStart] > dateadd(day, -10, getutcdate())', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageFilterCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Filter condition that will be used when extracting data from the staging table, when staging table is used for the ETL.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageFilterCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '2013-08-21 14:34:45', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DateTimeUpdatedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'DateTime of when the current row was last updated (system set)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DateTimeUpdatedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'spotify\toba', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UserNameUpdated';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Identification of who made the last update on the current row (system set)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UserNameUpdated';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '2013-08-21 14:34:45', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DateTimeInsertedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'DateTime of when the current row was inserted  (system set)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DateTimeInsertedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'spotify\jukkaaskvinge', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UserNameInserted';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Identification of who inserted the current row (system set)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UserNameInserted';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'GOT, KUN', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceServer';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'A tag to separate definitions when SourceTableCatalog not is enough to uniquely identify meta data', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceServer';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '10001', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableID';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Dimension - CRM', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'GroupName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the group that this destination object will belong to.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'GroupName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'InventoryDate = CAST(getdate() as date)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationDeleteCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Delete condition at the destination table when creating an SSIS package for the ETL flow between the source table and the destination table. This condition will be used as a pre-execution phase to the data flow.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationDeleteCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'src.[DATAAREAID] IN (SELECT DataAreaKey FROM DevelopmentFrameworkConfig_TD.[Parameters].[AXDataArea] WHERE Loaddata = 1)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceFilterCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Filter condition that will be used when extracting data from the source table. The syntax must be in the source language, which means for example T-SQL on SQL Server sources and P/L SQL on Oracle sources. Note that the source column need to be prefixed with src., because the SSIS source extract script uses aliases for the source and destination tables.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceFilterCondition';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'select Foo, Bar from dbo.Time', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceSelectClause';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The Select clause used in the source data extraction. Normally the complete table will be extracted from the source, as a first step in the ETL process.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceSelectClause';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'CDC_INVENTTABLE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CDCInstanceName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name of the CDC instance that the current destination table has as its source.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CDCInstanceName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'SSISConfig, ETL_Config', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DtsConfigEnvironmentVariableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name of the environment variable that will be used in SSIS packages', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DtsConfigEnvironmentVariableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWGeneralAndLogging, Stage', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISConfigurationFrameWorkCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the database where the configuration to the SSIS packages will be collected from (normally the database name where the table [SSIS Configurations] is located)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISConfigurationFrameWorkCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UseSSISLoggingFrameWork';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether a logging framework will be used or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'UseSSISLoggingFrameWork';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateSSISPackage';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether the an SSIS package will be created, physically in the file system, or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateSSISPackage';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateChecksumIndexes';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether an index will be created on the checksum column ChecksumPrimaryKey, during the table creation process, or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateChecksumIndexes';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateChecksumColumns';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether checksum columns will be created, during the table creation process, or not. Two checksum columns will be created; CheckSumNonPKColumns_dst and CheckSumNonPKColumns_src. CheckSumNonPKColumns_dst is used as a check sum column when the current table act as a DESTINATION. CheckSumNonPKColumns_src is used as a check sum column when the current table act as a SOURCE.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateChecksumColumns';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateStageTable';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether a staging table will be created or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateStageTable';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateTable';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether the current table will be created, physically in the database, or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CreateTable';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISIncrementalLoad';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Flag to indicate whether a design pattern for incremental load will be used. Otherwise the full load design pattern will be used.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISIncrementalLoad';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'A56E68EF-8174-4281-8901-B6CCD49D41FD', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISPackageGUID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Unique identifier that will be used when creating SSIS packages via BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISPackageGUID';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'hInventSum, rAssesBook', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISPackageName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name of the SSIS package, that will be used in the creation process', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SSISPackageName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'NONE, ROW, PAGE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CompressionType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Type of compression that will be used, when creating clustered indexes and non-clustered indexes', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'CompressionType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'rCustTable, rFilteredAccount, sCustomer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the table where the staging table exists/will exist', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'AX, CRM', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the schema where the staging table exists/will exist', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'EDWRaw, Stage', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the database where the staging table exists/will exist', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'StageTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'hInventItemPriceSim', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the table in the destination database', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'AX, dbo', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Schema name for the current table.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'EDWHistory_BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The database for current table during the creation process of tables and SSIS packages.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'SMDTOTAL, SMDDSALE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceFile';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Identification of the source file. Should always be the name of the file, excluding the file extension.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceFile';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'INVENTSUM, INVENTTABLE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The table name the current source meta data belongs to', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'dbo, AX', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The schema the current source meta data belongs to', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'EDWHistory, EDWRaw', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The database the current source meta data belongs to', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTable', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';

