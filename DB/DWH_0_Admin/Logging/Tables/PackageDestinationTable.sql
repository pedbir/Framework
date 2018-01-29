CREATE TABLE [Logging].[PackageDestinationTable] (
    [PackageDestinationTableID] INT              IDENTITY (1, 1) NOT NULL,
    [PackageID]                 UNIQUEIDENTIFIER NULL,
    [PackageName]               VARCHAR (250)    NULL,
    [SourceTableCatalog]        VARCHAR (250)    NULL,
    [SourceSchemaName]          VARCHAR (250)    NULL,
    [SourceTableName]           VARCHAR (250)    NULL,
    [DestinationTableCatalog]   VARCHAR (250)    NOT NULL,
    [DestinationSchemaName]     VARCHAR (250)    NOT NULL,
    [DestinationTableName]      VARCHAR (250)    NOT NULL,
    [SsisIncrementalLoad]       BIT              NOT NULL,
    [SsisLoadType]              VARCHAR (20)     NOT NULL,
    [DateTimeCreatedUTC]        DATETIME         NULL,
    [DateTimeUpdatedUTC]        DATETIME         NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Loggning_PackageDestinationTable_PackageID]
    ON [Logging].[PackageDestinationTable]([PackageID] ASC)
    INCLUDE([DestinationTableCatalog], [DestinationSchemaName], [DestinationTableName]);


GO
CREATE CLUSTERED INDEX [CI_PackageDestinationTable_PackageName]
    ON [Logging].[PackageDestinationTable]([PackageName] ASC);

