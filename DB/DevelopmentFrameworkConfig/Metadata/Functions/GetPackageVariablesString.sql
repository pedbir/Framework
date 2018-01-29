-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetPackageVariablesString] ()
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@CreatePackageVariablesString NVARCHAR(max)

	SET @CreatePackageVariablesString = '         -- Declare package variables ' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + '	DECLARE @ReadCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + '	, @InsertCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + ' , @UpdateCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + ' , @DeleteCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + ' , @IgnoreCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + ' , @ErrorCount int = 0' + @CRLF
	SET @CreatePackageVariablesString = @CreatePackageVariablesString + ' ,  @_ExecutionEndTime datetime' + @CRLF + @CRLF

	RETURN @CreatePackageVariablesString
END