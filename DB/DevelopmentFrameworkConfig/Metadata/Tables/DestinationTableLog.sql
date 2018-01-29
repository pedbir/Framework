CREATE TABLE [Metadata].[DestinationTableLog] (
    [DestinationTableLogID]   INT           IDENTITY (1, 1) NOT NULL,
    [SourceTableCatalog]      VARCHAR (128) NULL,
    [SourceSchemaName]        VARCHAR (128) NULL,
    [SourceTableName]         VARCHAR (128) NULL,
    [DestinationTableCatalog] VARCHAR (128) NOT NULL,
    [DestinationSchemaName]   VARCHAR (128) NOT NULL,
    [DestinationTableName]    VARCHAR (128) NOT NULL,
    [VersionComment]          VARCHAR (128) NOT NULL,
    [UserNameInserted]        VARCHAR (128) NULL,
    [DateTimeInsertedUTC]     DATETIME      NULL
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '2016-11-18 13:40:23.012', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DateTimeInsertedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Log date time', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DateTimeInsertedUTC';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'spotify\jukkaaskvinge', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'UserNameInserted';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The name of the user that modified', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'UserNameInserted';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'FSSC-1026', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'VersionComment';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The schema of the object that was modified', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'VersionComment';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'n_Country', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The destination of the table that was modified', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Norm', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The schema of the object that was modified', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_2_Norm', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The destination of the database that was modified', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Country', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The source of the table that was used to modify the target/destination', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Norm_Scd2', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The source of the schema that was used to modify the target/destination', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DWH_1_Raw', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The source of the database that was used to modify the target/destination', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 2, 3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableLogID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableLog', @level2type = N'COLUMN', @level2name = N'DestinationTableLogID';

