CREATE TABLE [Metadata].[SourceField] (
    [TABLE_CATALOG]            VARCHAR (128)   NOT NULL,
    [TABLE_SCHEMA]             VARCHAR (128)   NOT NULL,
    [TABLE_NAME]               VARCHAR (128)   NOT NULL,
    [COLUMN_NAME]              VARCHAR (128)   NOT NULL,
    [ORDINAL_POSITION]         INT             NULL,
    [COLUMN_DEFAULT]           NVARCHAR (4000) NULL,
    [IS_NULLABLE]              VARCHAR (3)     NULL,
    [DATA_TYPE]                NVARCHAR (128)  NULL,
    [CHARACTER_MAXIMUM_LENGTH] INT             NULL,
    [CHARACTER_OCTET_LENGTH]   INT             NULL,
    [NUMERIC_PRECISION]        TINYINT         NULL,
    [NUMERIC_PRECISION_RADIX]  SMALLINT        NULL,
    [NUMERIC_SCALE]            INT             NULL,
    [DATETIME_PRECISION]       SMALLINT        NULL,
    [CHARACTER_SET_CATALOG]    NVARCHAR (128)  NULL,
    [CHARACTER_SET_SCHEMA]     NVARCHAR (128)  NULL,
    [CHARACTER_SET_NAME]       NVARCHAR (128)  NULL,
    [COLLATION_CATALOG]        NVARCHAR (128)  NULL,
    [COLLATION_SCHEMA]         NVARCHAR (128)  NULL,
    [COLLATION_NAME]           NVARCHAR (128)  NULL,
    [DOMAIN_CATALOG]           NVARCHAR (128)  NULL,
    [DOMAIN_SCHEMA]            NVARCHAR (128)  NULL,
    [DOMAIN_NAME]              NVARCHAR (128)  NULL,
    [DestinationTableCatalog]  NVARCHAR (128)  NOT NULL,
    [TABLE_SERVER]             VARCHAR (128)   NULL,
    [SourceFieldID]            INT             IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [UQ_SourceField] UNIQUE CLUSTERED ([TABLE_CATALOG] ASC, [TABLE_SCHEMA] ASC, [TABLE_NAME] ASC, [COLUMN_NAME] ASC, [DestinationTableCatalog] ASC, [TABLE_SERVER] ASC)
);






GO





GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'10001', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'SourceFieldID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'SourceFieldID';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'GOT, KUN', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_SERVER';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'A tag to separate definitions when SourceTableCatalog not is enough to uniquely identify meta data', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_SERVER';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWHistory_BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the database where the destination table will be created', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DOMAIN_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'Finnish_Swedish_CI_AS', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLLATION_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'UNICODE', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_SET_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DATETIME_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DATETIME_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_SCALE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_SCALE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'10', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION_RADIX';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION_RADIX';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'10', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'20', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_OCTET_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_OCTET_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'10', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_MAXIMUM_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The maximum length of the current column, if the data type of the column is char, varchar, nchar or nvarchar', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'CHARACTER_MAXIMUM_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'nvarchar, decimal, int', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'YES, NO', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'IS_NULLABLE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'-- See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns --', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'IS_NULLABLE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'((0))', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLUMN_DEFAULT';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLUMN_DEFAULT';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'5, 8, 10', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'ORDINAL_POSITION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'ORDINAL_POSITION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'PDSFREIGHTACCRUED', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the column in the source table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'rCustTable', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'AX, dbo', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_SCHEMA';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWRaw_BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_CATALOG';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'See documentation of this field in Microsofts documentation of INFORMATION_SCHEMA.Columns', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'SourceField', @level2type = N'COLUMN', @level2name = N'TABLE_CATALOG';

