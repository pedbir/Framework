CREATE TABLE [Logging].[Package] (
    [PackageID]          UNIQUEIDENTIFIER NOT NULL,
    [PackageName]        VARCHAR (150)    NOT NULL,
    [PackageDescription] VARCHAR (250)    NULL,
    CONSTRAINT [PK_Package] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ett SSIS-paket', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'Package';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primärnyckel', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'Package', @level2type = N'COLUMN', @level2name = N'PackageID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Namn på paketet', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'Package', @level2type = N'COLUMN', @level2name = N'PackageName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Beskrivning av paketet', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'Package', @level2type = N'COLUMN', @level2name = N'PackageDescription';

