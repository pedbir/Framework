CREATE TABLE [Metadata].[DerivedColumnOverride] (
    [Id]                INT            IDENTITY (1, 1) NOT NULL,
    [DerivedColumnType] VARCHAR (50)   NOT NULL,
    [DerivedColumnName] VARCHAR (50)   NOT NULL,
    [OverrideValue]     NVARCHAR (255) NOT NULL,
    [DataType]          NVARCHAR (50)  NULL,
    [Comment]           TEXT           NULL,
    [ApplicableTable]   NVARCHAR (255) NULL,
    [MaxLength]         SMALLINT       NULL,
    CONSTRAINT [PK_DerivedColumnOverride] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '100', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'MaxLength';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The length of the derived column when using character types', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'MaxLength';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'n_Country', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'ApplicableTable';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicates if the derived column need to be specific to one integration', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'ApplicableTable';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'Extended field in Stage. To be populated in DW for missing Foreign Key members', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'Comment';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Just a comment column -> not used in the code', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'Comment';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'datetime, nvarchar', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DataType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Data type of the derived column', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DataType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '@[System::PackageName], GETUTCDATE()', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'OverrideValue';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'The value, expressed in SSIS code, for the expression', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'OverrideValue';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'SysSrcGenerationDateTime, PackageName', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DerivedColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Name of the derived column', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DerivedColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = 'dwInfFK, dwInit, dwError', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DerivedColumnType';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'Indicator of where this derived column, and the value for that, will reside. This indicator is used as parameter when creating derived column components in the created SSIS packages', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'DerivedColumnType';


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = '1,2,3', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'Id';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = 'System generated identity of the current row', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DerivedColumnOverride', @level2type = N'COLUMN', @level2name = N'Id';

