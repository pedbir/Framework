CREATE TABLE [Metadata].[DataTypeTranslation] (
    [Id]            INT          IDENTITY (1, 1) NOT NULL,
    [SQLServer]     VARCHAR (50) NULL,
    [SSIS]          VARCHAR (50) NULL,
    [Biml]          VARCHAR (50) NULL,
    [DataTypeGroup] VARCHAR (50) NULL,
    CONSTRAINT [PK_DataTypeTranslation] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Date', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'DataTypeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Group name of the data type', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'DataTypeGroup';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DateTime2', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'Biml';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Data type name used in BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'Biml';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'DT_DBTIMESTAMP2', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'SSIS';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Data type name used in SSIS', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'SSIS';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'datetime2', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'SQLServer';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Data type name used in MS SQL Server', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'SQLServer';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1,2,3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'Id';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DataTypeTranslation', @level2type = N'COLUMN', @level2name = N'Id';

