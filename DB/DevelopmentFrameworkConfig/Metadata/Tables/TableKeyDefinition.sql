CREATE TABLE [Metadata].[TableKeyDefinition] (
    [TableCatalog]            VARCHAR (128)  NOT NULL,
    [SchemaName]              VARCHAR (128)  NOT NULL,
    [TableName]               VARCHAR (128)  NOT NULL,
    [TableKeyName]            VARCHAR (128)  NULL,
    [COLUMN_NAME]             VARCHAR (128)  NOT NULL,
    [DATA_TYPE]               VARCHAR (128)  NOT NULL,
    [KeyType]                 VARCHAR (50)   NOT NULL,
    [KeyColumnOrder]          SMALLINT       CONSTRAINT [DF_TableKeyDefinition_ColumnOrderInTableKeyDefinition] DEFAULT ((1)) NOT NULL,
    [IncludedColumn]          BIT            CONSTRAINT [DF_TableKeyDefinition_IncludedColumn] DEFAULT ((0)) NOT NULL,
    [TableKeyDefinitionRowID] INT            IDENTITY (1, 1) NOT NULL,
    [IndexStorageLocation]    NVARCHAR (128) DEFAULT ('Norm_Index') NOT NULL,
    [FilterPredicate]         NVARCHAR (128) NULL,
    [IsAscendingOrder]        BIT            DEFAULT ((1)) NOT NULL,
    [IndexIsUnique]           BIT            CONSTRAINT [DF_TableKeyDefinition_IndexIsUnique] DEFAULT ((0)) NOT NULL,
    [IndexFillFactor]         SMALLINT       NULL,
    CONSTRAINT [CK_TableKeyDefinition_KeyType] CHECK ([KeyType]='FK' OR [KeyType]='UK' OR [KeyType]='PK' OR [KeyType]='CIX' OR [KeyType]='NCIX'),
    CONSTRAINT [UQ_TableKeyDefinition] UNIQUE NONCLUSTERED ([TableCatalog] ASC, [SchemaName] ASC, [TableName] ASC, [TableKeyName] ASC, [COLUMN_NAME] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '70, 80, 90, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexFillFactor';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The fill factor (between 0 and 100) that will be used when creating indexes', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexFillFactor';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexIsUnique';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicator if the current index will be created as an unique index or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexIsUnique';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IsAscendingOrder';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Indicates whether the index attribute shall be sorted in ascending or descending order. 1 means ascending while 0 means descending.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IsAscendingOrder';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'WHERE StartDate > ''20000101'' AND EndDate <= ''20000630''', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'FilterPredicate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Filtered index predicate for which rows to include in the index', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'FilterPredicate';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'[FileGroup_Facts_DW_Clicks]', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Specifies the partition scheme or filegroup on which the table is stored', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IndexStorageLocation';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1,2,3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableKeyDefinitionRowID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableKeyDefinitionRowID';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IncludedColumn';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate if the non-clustred index should be treated as an included column or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'IncludedColumn';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 2, 3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'KeyColumnOrder';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Column order in which the primary key will be built.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'KeyColumnOrder';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'PK, NCIDX', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'KeyType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Type of key that will be created.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'KeyType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'nvarchar', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The data type for the current column -> The syntax for the data type must match SQL Server 2008 R2 T-SQL syntax.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'ACCOUNTNUM', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the column, that will be used in the definition of the primary key or an index', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'NCIDX_Modified_hCustInvoiceJour', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableKeyName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The name of the key/index to create', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableKeyName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'hInventSum, rAssesBook', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The name of the table where the key belongs.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'AX', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'SchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The name of the schema for the table where the key belongs.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'SchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWHistory, EDWRaw', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The name of the database for the table where the key belongs.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'TableKeyDefinition', @level2type = N'COLUMN', @level2name = N'TableCatalog';

