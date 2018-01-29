
CREATE PROCEDURE [Audit].[LogDataError]
	@DWID int,	
	@PackageName nvarchar(100), 	
	@SysExecutionLog_key int,
	@SourceTableName nvarchar(100),
	@ErrorDescription nvarchar(100) = '',
	@RowData xml = NULL
AS

	INSERT INTO Audit.DataError(DateTimeErrorUTC, PackageName, SysExecutionLog_key, SourceTableName, ErrorDescription, RowData)
	VALUES (GETUTCDATE(), @PackageName, @SysExecutionLog_key, @SourceTableName, @ErrorDescription, @RowData)
	
	RETURN
