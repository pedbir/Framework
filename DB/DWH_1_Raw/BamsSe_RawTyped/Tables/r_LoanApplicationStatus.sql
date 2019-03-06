CREATE TABLE [BamsSe_RawTyped].[r_LoanApplicationStatus] (
    [LoanApplicationStatus_key]  INT            IDENTITY (1, 1) NOT NULL,
    [SysExecutionLog_key]        INT            NOT NULL,
    [SysDatetimeInsertedUTC]     DATETIME2 (0)  NOT NULL,
    [SysDatetimeUpdatedUTC]      DATETIME2 (0)  NULL,
    [SysDatetimeDeletedUTC]      DATETIME2 (0)  NULL,
    [SysModifiedUTC]             DATETIME2 (0)  NOT NULL,
    [SysIsInferred]              BIT            NOT NULL,
    [SysValidFromDateTime]       DATETIME2 (0)  NOT NULL,
    [SysSrcGenerationDateTime]   DATETIME2 (0)  NULL,
    [LoanApplicationStatus_bkey] NVARCHAR (100) NOT NULL,
    [ApplicationId]              NVARCHAR (100) NULL,
    [ApplicationNumber]          INT            NULL,
    [CompletedDate]              DATETIME       NULL,
    [StatusID]                   NVARCHAR (100) NULL,
    [StatusName]                 NVARCHAR (150) NULL,
    [CompletedByEmployeeID]      NVARCHAR (100) NULL,
    CONSTRAINT [PK_BamsSe_RawTyped_r_LoanApplicationStatus] PRIMARY KEY CLUSTERED ([LoanApplicationStatus_bkey] ASC, [SysValidFromDateTime] DESC) WITH (DATA_COMPRESSION = PAGE)
);












GO



GO
CREATE NONCLUSTERED INDEX [NCIDX_SysModifiedUTC_BamsSe_RawTyped_r_LoanApplicationStatus]
    ON [BamsSe_RawTyped].[r_LoanApplicationStatus]([SysModifiedUTC] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationId]
    ON [BamsSe_RawTyped].[r_LoanApplicationStatus]([ApplicationId] ASC, [SysValidFromDateTime] DESC)
    INCLUDE([ApplicationNumber], [StatusName], [CompletedDate], [CompletedByEmployeeID], [SysSrcGenerationDateTime], [SysModifiedUTC], [StatusID]);






GO
CREATE NONCLUSTERED INDEX [IX_LoanApplicationStatus_StatusName]
    ON [BamsSe_RawTyped].[r_LoanApplicationStatus]([ApplicationId] ASC, [StatusName] ASC, [CompletedDate] ASC)
    INCLUDE([StatusID], [CompletedByEmployeeID]);


GO
CREATE NONCLUSTERED INDEX [IX_LoanApplicationStatus_StatusID]
    ON [BamsSe_RawTyped].[r_LoanApplicationStatus]([StatusID] ASC, [SysValidFromDateTime] DESC)
    INCLUDE([StatusName]);


GO
CREATE NONCLUSTERED INDEX [NCIDX_SysSrcGenerationDateTime_BamsSe_RawTyped_r_LoanApplicationStatus]
    ON [BamsSe_RawTyped].[r_LoanApplicationStatus]([SysSrcGenerationDateTime] ASC) WITH (DATA_COMPRESSION = PAGE);

