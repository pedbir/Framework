-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns the parameters for the merge operation.
--		Ordinal in result set must be insert,update,delete. 
--		Update clause should include batchid - ignore that row in SetFieldOnUpdate
--		<Parameter DataType="int" Name="OrdinalNo" ParameterName="User.x" Direction="Input"></Parameter>
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetSqlTaskMergeParameter] (
	@SOURCE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@USAGE_TYPE VARCHAR(50)
	,@IncrementalLoad bit = 0
	)
RETURNS XML
AS
BEGIN
	DECLARE @MergeParameter XML

	SELECT @MergeParameter = (
			SELECT ROW_NUMBER() OVER (
					ORDER BY r
						,ordinal_position
					) - 1 AS 'Parameter/@Name'
				,VariableName AS 'Parameter/@VariableName'
				,DataType AS 'Parameter/@DataType'
				,Direction AS 'Parameter/@Direction'
			FROM (
				SELECT CONCAT (
						'User.'
						,Column_Name
						) AS VariableName
					,SSISDataType AS DataType
					,'Input' AS Direction
					,SSISColumnSpecification AS Parameter
					,
					-- meta
					2 AS r
					,ORDINAL_POSITION
				FROM [Metadata].[DestinationFieldExtended]
				WHERE SSISColumnSpecification IS NOT NULL
					AND IsNull(SourceTableCatalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
					AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND isnull(ApplicableTable, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
					AND (SetFieldOnInsert = 1)
				
				UNION ALL
				
				SELECT CONCAT (
						'User.'
						,Column_Name
						) AS VariableName
					,SSISDataType AS DataType
					,'Input' AS Direction
					,SSISColumnSpecification AS Parameter
					,
					-- meta
					3 AS r
					,ORDINAL_POSITION
				FROM [Metadata].[DestinationFieldExtended]
				WHERE SSISColumnSpecification IS NOT NULL
					AND IsNull(SourceTableCatalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
					AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND isnull(ApplicableTable, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
					AND (SetFieldOnUpdate = 1)
					AND COLUMN_NAME != 'SysExecutionLog_key'
				
				UNION ALL
				
				SELECT CONCAT (
						'User.'
						,Column_Name
						) AS VariableName
					,SSISDataType AS DataType
					,'Input' AS Direction
					,SSISColumnSpecification AS Parameter
					,
					-- meta
					4 AS r
					,ORDINAL_POSITION
				FROM [Metadata].[DestinationFieldExtended]
				WHERE SSISColumnSpecification IS NOT NULL
					AND IsNull(SourceTableCatalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
					AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND isnull(ApplicableTable, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
					AND SetFieldOnDelete = 1
					AND @USAGE_TYPE = (SELECT TOP 1 [StagingEnvironmentName]
										FROM [Metadata].[EnvironmentVariables])
			UNION ALL
				
			SELECT TOP 1 'User.PackageLastExecutedNew' AS VariableName
					,'DateTime' AS DataType
					,'Input' AS Direction
					,'@[User::PackageLastExecutedNew]' AS Parameter
					,
					-- meta
					1 AS r
					,1
			FROM [Metadata].[DestinationFieldExtended]
			WHERE @IncrementalLoad = 1 AND @USAGE_TYPE = 'DWH_3_Fact'
				) Variables
			ORDER BY r
				,ORDINAL_POSITION
			FOR XML path('')
			)

	RETURN @MergeParameter
END