CREATE TABLE [dbo].[SSISConfigurations] (
    [ssisConfigurationId] INT            IDENTITY (1, 1) NOT NULL,
    [ConfigurationFilter] VARCHAR (255)  NOT NULL,
    [ConfiguredValue]     NVARCHAR (255) NULL,
    [PackagePath]         NVARCHAR (255) NOT NULL,
    [ConfiguredValueType] NVARCHAR (20)  NOT NULL
);

