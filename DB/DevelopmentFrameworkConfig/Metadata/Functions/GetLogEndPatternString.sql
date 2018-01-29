-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetLogEndPatternString] (@SSISPackageGUID NVARCHAR(128))
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@CreateProcedureStringLogEnd NVARCHAR(max)

	SET @CreateProcedureStringLogEnd = '        -- Create end log ' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '	set @_ExecutionEndTime = getdate()' + @CRLF + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '	EXECUTE DWH_0_Admin.Logging.LogPackageEnd ' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '		@PackageID = ''' + @SSISPackageGUID + '''' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @ExecutionID = @_ExecutionID' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @ExecutionEndTime = @_ExecutionEndTime' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsRead = @ReadCount' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsInserted = @InsertCount' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsUpdated = @UpdateCount' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsDeleted = @DeleteCount' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsIgnored = @IgnoreCount' + @CRLF
	SET @CreateProcedureStringLogEnd = @CreateProcedureStringLogEnd + '       , @RowsError = @ErrorCount' + @CRLF

	RETURN @CreateProcedureStringLogEnd
END