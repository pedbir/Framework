﻿

CREATE VIEW Logging.PackageExecutionV
AS
SELECT p.PackageID
       , p.PackageName
       , pv.VersionID
       , pe.ExecutionID
       , pe.ExecutionStart
       , pe.ExecutionEnd
       , Duration = CASE WHEN pe.ExecutionStart < '1900-01-01' THEN NULL ELSE DATEDIFF(SECOND, pe.ExecutionStart, pe.ExecutionEnd) END	   
       , pe.RowsRead
       , pe.RowsInserted
       , pe.RowsUpdated
       , pe.RowsDeleted
       , pe.RowsIgnored
       , pe.RowsError
       , pe.Status
       , pe.MachineName
       , pe.UserName
       , pe.SysExecutionLog_key
       , pe.SysBatchLogExecutionLog_key
       , SourceView = CASE WHEN  pdt.SourceTableCatalog = '' THEN NULL ELSE  pdt.SourceTableCatalog + CASE WHEN pdt.SsisLoadType = 'FlatFile' THEN '\' ELSE '.' END + pdt.SourceSchemaName + CASE WHEN pdt.SsisLoadType = 'FlatFile' THEN '\' ELSE '.' END + pdt.SourceTableName END
       , DestinationTable = CASE WHEN pdt.DestinationTableCatalog  = '' THEN NULL ELSE pdt.DestinationTableCatalog + '.' + pdt.DestinationSchemaName + '.' + pdt.DestinationTableName END	   
	   , SsisIncrementalLoad = CASE WHEN pdt.SsisIncrementalLoad = 1 THEN 'Y' ELSE 'N' END
FROM   Logging.PackageExecution pe
INNER JOIN Logging.PackageVersion pv
        ON pe.PackageVersionID = pv.VersionID
INNER JOIN Logging.Package p
        ON pv.PackageID        = p.PackageID
INNER JOIN Logging.PackageDestinationTable pdt
        ON pdt.PackageID       = pv.PackageID
