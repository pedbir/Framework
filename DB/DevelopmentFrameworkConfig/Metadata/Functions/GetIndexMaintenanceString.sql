-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetIndexMaintenanceString] (
	@DestinationTableCatalog NVARCHAR(128)
	,@DestinationSchemaName NVARCHAR(128)
	,@DestinationTableName NVARCHAR(128)
	)
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@TAB NVARCHAR(1) = NCHAR(9)
		,@IndexStatement NVARCHAR(max) = ''

	SET @IndexStatement = @TAB + '-- Index maintenance statement' + @CRLF
	SET @IndexStatement = @IndexStatement + @TAB + 'ALTER INDEX ALL ON [' + @DestinationSchemaName + '].[' + @DestinationTableName + '] REBUILD PARTITION = ALL' + @CRLF + @CRLF

	RETURN @IndexStatement
END