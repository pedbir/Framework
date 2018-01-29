CREATE TABLE [Logging].[PackageExecution] (
    [ExecutionID]                 UNIQUEIDENTIFIER NOT NULL,
    [PackageVersionID]            UNIQUEIDENTIFIER NOT NULL,
    [ExecutionStart]              DATETIME         CONSTRAINT [DF_PackageLog_PackageExecutionStart] DEFAULT (getdate()) NOT NULL,
    [ExecutionEnd]                DATETIME         NULL,
    [MachineName]                 VARCHAR (50)     NOT NULL,
    [UserName]                    VARCHAR (50)     NOT NULL,
    [InteractiveMode]             BIT              NOT NULL,
    [ProductVersion]              VARCHAR (15)     NULL,
    [RowsRead]                    BIGINT           NULL,
    [RowsInserted]                BIGINT           NULL,
    [RowsUpdated]                 BIGINT           NULL,
    [RowsDeleted]                 BIGINT           NULL,
    [RowsIgnored]                 BIGINT           NULL,
    [RowsError]                   BIGINT           NULL,
    [Status]                      VARCHAR (15)     NOT NULL,
    [SysExecutionLog_key]         INT              IDENTITY (1, 1) NOT NULL,
    [SysBatchLogExecutionLog_key] INT              NULL,
    CONSTRAINT [PK_PackageExecution] PRIMARY KEY CLUSTERED ([ExecutionID] ASC),
    CONSTRAINT [CH_PackageLog_PackageExecutionEnd] CHECK ([ExecutionEnd]>=[ExecutionStart]),
    CONSTRAINT [FK_PackageExecution_PackageVersion] FOREIGN KEY ([PackageVersionID]) REFERENCES [Logging].[PackageVersion] ([VersionID])
);




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'En exekvering av ett paket med en viss version.', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primärnyckel', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'ExecutionID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Främmande nyckel till PackageVersion ', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'PackageVersionID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tidpunkt för start på exekveringen', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'ExecutionStart';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tidpunkt för slut på exekveringen', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'ExecutionEnd';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Namn på den maskin där paketet körde', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'MachineName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Användarnamn på den användare som startade körningen', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'UserName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Om paketet kördes i BIDS eller ej', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'InteractiveMode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Version på den servermjukvara körningen gjordes', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'ProductVersion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Status på körning (Failure, Succeeded, In Progress)', @level0type = N'SCHEMA', @level0name = N'Logging', @level1type = N'TABLE', @level1name = N'PackageExecution', @level2type = N'COLUMN', @level2name = N'Status';


GO
CREATE NONCLUSTERED INDEX [IX_SysExecutionLog_key]
    ON [Logging].[PackageExecution]([PackageVersionID] ASC, [Status] ASC, [SysExecutionLog_key] DESC)
    INCLUDE([ExecutionStart]);

