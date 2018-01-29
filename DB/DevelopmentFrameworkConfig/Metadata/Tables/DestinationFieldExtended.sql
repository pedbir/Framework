CREATE TABLE [Metadata].[DestinationFieldExtended] (
    [ID]                       INT             IDENTITY (1, 1) NOT NULL,
    [COLUMN_NAME]              NVARCHAR (128)  NOT NULL,
    [DATA_TYPE]                NVARCHAR (128)  NOT NULL,
    [CHARACTER_MAXIMUM_LENGTH] INT             NULL,
    [DATETIME_PRECISION]       INT             NULL,
    [ORDINAL_POSITION]         INT             NULL,
    [NUMERIC_PRECISION]        TINYINT         NULL,
    [NUMERIC_SCALE]            INT             NULL,
    [IS_NULLABLE]              VARCHAR (3)     CONSTRAINT [DF_FieldsExtendedForDestinations_IS_NULLABLE] DEFAULT ('NO') NOT NULL,
    [IncludeInChecksum_src]    BIT             CONSTRAINT [DF_DestinationFieldExtended_IncludeInChecksum_src] DEFAULT ((0)) NOT NULL,
    [TableColumnSpecification] NVARCHAR (1000) NULL,
    [IsIdentity]               BIT             CONSTRAINT [DF_DestinationFieldExtended_IsIdentity] DEFAULT ((0)) NOT NULL,
    [CreateColumnIndex]        BIT             NULL,
    [SourceTableCatalog]       NVARCHAR (128)  NULL,
    [DestinationTableCatalog]  NVARCHAR (128)  NOT NULL,
    [DestinationSchemaName]    NVARCHAR (128)  CONSTRAINT [DF_DestinationFieldExtended_DestinationSchemaName] DEFAULT ('-') NOT NULL,
    [ApplicableTable]          NVARCHAR (128)  NULL,
    [SSISDataType]             NVARCHAR (128)  NULL,
    [SSISDataTypeLength]       INT             NULL,
    [SSISColumnSpecification]  NVARCHAR (255)  NULL,
    [SetFieldOnInsert]         BIT             CONSTRAINT [DF_DestinationFieldExtended_SetFieldAtInsert] DEFAULT ((1)) NOT NULL,
    [SetFieldOnUpdate]         BIT             NOT NULL,
    [SetFieldOnDelete]         BIT             NOT NULL,
    [GroupName]                VARCHAR (20)    CONSTRAINT [DF_DestinationFieldExtended_GroupName] DEFAULT ('All') NULL,
    CONSTRAINT [UQ_DestinationFieldExtended] UNIQUE NONCLUSTERED ([DestinationTableCatalog] ASC, [SourceTableCatalog] ASC, [DestinationSchemaName] ASC, [ApplicableTable] ASC, [COLUMN_NAME] ASC)
);




GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'Dimension - CRM', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'GroupName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the group that this extended field will belong to.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'GroupName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnDelete';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'A flag that indicates if current extended column will be set on deletes from the table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnDelete';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnUpdate';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'A flag that indicates if current extended column will be set on updates of the table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnUpdate';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnInsert';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'A flag that indicates if current extended column will be set on inserts into the table', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SetFieldOnInsert';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'@[User::SysExecutionLog_key], 25, GETDATE()', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISColumnSpecification';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The column specification for the extended column. Specification need to be written with SSIS syntax.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISColumnSpecification';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'10', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISDataTypeLength';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The length of the data type in the SSIS package', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISDataTypeLength';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'String', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISDataType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The data type used in the SSIS package, for the current extended column', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SSISDataType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'hInventSum', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'ApplicableTable';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Table name for which the current field will be appended. If NULL then column will be appended for all objects in the specified database.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'ApplicableTable';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'norm', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The schema name that this extended field will be created for', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DestinationSchemaName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWHistory_BIML', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the database. When a table is created this column is used to get all extra columns that will be created during the creation process for a table in current database.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DestinationTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'EDWHistory, SMNE_DW, ApplLayer', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the source database.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'SourceTableCatalog';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'CreateColumnIndex';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate whether an index will be created on the current column, during the table creation process, or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'CreateColumnIndex';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IsIdentity';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate whether current column is an identity column or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IsIdentity';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'convert(nvarchar(27), (case    when DatetimeDeleted > isnull(DatetimeUpdated, convert(DATETIME, ''1900-01-01'', 20)) and DatetimeDeleted > isnull(DatetimeInserted, convert(DATETIME, ''1900-01-01'', 20)) then DatetimeDeleted   when DatetimeUpdated > isnull(DatetimeDeleted, convert(DATETIME, ''1900-01-01'', 20)) and DatetimeUpdated > isnull(DatetimeInserted, convert(DATETIME, ''1900-01-01'', 20)) then DatetimeUpdated          else DatetimeInserted   end), 121) PERSISTED', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'TableColumnSpecification';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The specification that will be used for calculated columns, during the creation process of tables.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'TableColumnSpecification';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1, 0', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IncludeInChecksum_src';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate whether the current column shall be included in the checksum or not', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IncludeInChecksum_src';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'YES, NO', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IS_NULLABLE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Flag to indicate whether the current column is nullable or not.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'IS_NULLABLE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '3, 4, 5', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'NUMERIC_SCALE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Number of decimals for the column if the data type is decimal', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'NUMERIC_SCALE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '10, 18, 15', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The precision for the column if the data type is decimal', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'NUMERIC_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'1007', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'ORDINAL_POSITION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The ordinal position where the column will be materialized in the table.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'ORDINAL_POSITION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '0, 1, 2', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DATETIME_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The precision for the datetime2 data type in SQL Server', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DATETIME_PRECISION';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'27', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'CHARACTER_MAXIMUM_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The maximum length of the current column, if the data type of the column is char, varchar, nchar or nvarchar', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'CHARACTER_MAXIMUM_LENGTH';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'int', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'The data type for the current column -> The syntax for the data type must match SQL Server 2008 R2 T-SQL syntax.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'DATA_TYPE';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'SourceSystemID', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the column, when creating tables and SSIS packages', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationFieldExtended', @level2type = N'COLUMN', @level2name = N'COLUMN_NAME';

