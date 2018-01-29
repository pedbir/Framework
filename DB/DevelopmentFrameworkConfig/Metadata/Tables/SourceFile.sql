CREATE TABLE [Metadata].[SourceFile] (
    [SourceTableCatalog]        VARCHAR (128) NOT NULL,
    [SourceSchemaName]          VARCHAR (128) NOT NULL,
    [SourceTableName]           VARCHAR (128) NOT NULL,
    [ColumnNamesInFirstDataRow] BIT           NOT NULL,
    [HeaderRowsToSkip]          SMALLINT      NOT NULL,
    [DataRowsToSkip]            SMALLINT      NOT NULL,
    [FlatFileType]              VARCHAR (20)  NOT NULL,
    [HeaderRowDelimiter]        VARCHAR (5)   NOT NULL,
    [RowDelimiter]              VARCHAR (5)   NOT NULL,
    [ColumnDelimiter]           VARCHAR (5)   NULL,
    [TextQualifier]             VARCHAR (5)   NULL,
    [IsUnicode]                 BIT           NOT NULL,
    CONSTRAINT [PK_SourceFile] PRIMARY KEY CLUSTERED ([SourceTableCatalog] ASC, [SourceSchemaName] ASC, [SourceTableName] ASC),
    CONSTRAINT [CK_SourceFile_FlatFileType] CHECK ([FlatFileType]='Delimited' OR [FlatFileType]='FixedWidth' OR [FlatFileType]='RaggedRight')
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'IsUnicode';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate if the source file is created in unicode character set', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'IsUnicode';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'TextQualifier';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'TextQualifier';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N';, ¤, |', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'ColumnDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The column delimiter in the source file (if type Delimited is used)', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'ColumnDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'CRLF', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'RowDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Delimiter of the data row in the source file', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'RowDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'CRLF', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'HeaderRowDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Delimiter of the header row in the source file', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'HeaderRowDelimiter';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'FixedWidth, Delimited', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'FlatFileType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Type of file of the source file', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'FlatFileType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'DataRowsToSkip';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Number of data rows to skip in the source file', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'DataRowsToSkip';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'HeaderRowsToSkip';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Number of header rows to skip in the source file', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'HeaderRowsToSkip';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'ColumnNamesInFirstDataRow';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate if the source file have column names in the first data row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'ColumnNamesInFirstDataRow';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'Account, Customer, rCustomer, hCustomer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the source table.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceTableName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'dbo, AX', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the source schema.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWHistory, SMNE_DW, ApplLayer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the source database.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceFile', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';

