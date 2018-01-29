CREATE TABLE [Logging].[PackageVersion] (
    [VersionID]           UNIQUEIDENTIFIER NOT NULL,
    [PackageID]           UNIQUEIDENTIFIER NOT NULL,
    [VersionMajor]        SMALLINT         NOT NULL,
    [VersionMinor]        SMALLINT         NOT NULL,
    [VersionBuild]        INT              NOT NULL,
    [VersionComments]     VARCHAR (255)    NULL,
    [CreationDate]        DATE             NULL,
    [CreatorName]         VARCHAR (255)    NULL,
    [CreatorComputerName] VARCHAR (50)     NULL,
    [LocaleID]            INT              NOT NULL,
    CONSTRAINT [PK_PackageVersion] PRIMARY KEY CLUSTERED ([VersionID] ASC),
    CONSTRAINT [FK_PackageVersion_Package] FOREIGN KEY ([PackageID]) REFERENCES [Logging].[Package] ([PackageID])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'En unik version för ett visst paket', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primärnyckel', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'VersionID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Främmande nyckel till Package ', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'PackageID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Versionsnummer major', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'VersionMajor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Versionsnummer minor', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'VersionMinor';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Versionsnummer för kompilering', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'VersionBuild';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Kommentarer rörande versionen', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageVersion', @level2type = N'COLUMN', @level2name = N'VersionComments';

