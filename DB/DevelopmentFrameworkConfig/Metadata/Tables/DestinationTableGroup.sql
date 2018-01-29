CREATE TABLE [Metadata].[DestinationTableGroup] (
    [GroupName] VARCHAR (20) NOT NULL,
    CONSTRAINT [UQ_DestinationTableGroup] UNIQUE NONCLUSTERED ([GroupName] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'ExampleValue', @value = N'Dimension - CRM', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableGroup', @level2type = N'COLUMN', @level2name = N'GroupName';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnDescription', @value = N'Name of the group.', @level0type = N'SCHEMA', @level0name = N'Metadata', @level1type = N'TABLE', @level1name = N'DestinationTableGroup', @level2type = N'COLUMN', @level2name = N'GroupName';

