-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetContainerVariables] (
	@SOURCE_CATALOG VARCHAR(50)
	,@DESTINATION_TABLE_CATALOG VARCHAR(50)
	,@DESTINATION_TABLE_NAME VARCHAR(50)
	,@USAGE_TYPE VARCHAR(50)
	)
RETURNS XML
AS
BEGIN
	DECLARE @DerivedColumns XML
	DECLARE @ExtendedVariables AS TABLE (
		column_name VARCHAR(128)
		,SSISDataType NVARCHAR(128)
		,SSISColumnSpecification NVARCHAR(255)
		,UsageType VARCHAR(50)
		)

	INSERT INTO @ExtendedVariables
	VALUES (
		'LastRecId'
		,'Int64'
		,'0'
		,'Fact'
		)
		,(
		'PackageLastExecuted'
		,'String'
		,'1900-01-01'
		,'Fact'
		)

	SELECT @DerivedColumns = (
			SELECT Column_Name AS 'Variable/@Name'
				,SSISDataType AS 'Variable/@DataType'
				,'User' AS 'Variable/@Namespace'
				,'true' AS 'Variable/@EvaluateAsExpression'
				,SSISColumnSpecification AS 'Variable'
			FROM (
				SELECT Column_Name
					,SSISDataType
					,SSISColumnSpecification
				FROM [Metadata].[DestinationFieldExtended]
				WHERE SSISColumnSpecification IS NOT NULL
					AND IsNull(SourceTableCatalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
					AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND isnull(ApplicableTable, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
					AND COLUMN_NAME != 'SysExecutionLog_key'
					AND @USAGE_TYPE IN (
						'All'
						,'Datamart objects'
						)
				
				UNION
				
				SELECT column_name
					,SSISDataType
					,SSISColumnSpecification
				FROM @ExtendedVariables ext
				WHERE ext.UsageType = @USAGE_TYPE
				) Variables
			ORDER BY COLUMN_NAME
			FOR XML path('')
			)

	RETURN @DerivedColumns
END