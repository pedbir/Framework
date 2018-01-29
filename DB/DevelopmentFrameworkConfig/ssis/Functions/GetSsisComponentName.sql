-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSsisComponentName] (
	@COMPONENT_TYPE VARCHAR(50)
	,@COMPONENT_USAGE_TYPE VARCHAR(50)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @SsisComponentName VARCHAR(max)
	DECLARE @Components AS TABLE (
		ComponentName VARCHAR(max)
		,ComponentType VARCHAR(50)
		,ComponentUsageType VARCHAR(50)
		)

	INSERT INTO @Components
	VALUES (
		'DC Error metadata'
		,'UnionAll'
		,'UnionError'
		)

	SELECT @SsisComponentName = (
			SELECT ComponentName
			FROM @Components
			WHERE ComponentType = @COMPONENT_TYPE
				AND ComponentUsageType = @COMPONENT_USAGE_TYPE
			)

	RETURN @SsisComponentName
END