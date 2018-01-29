-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns xml for Aggregate Transformation OutputPath columns
--		Format <Column Operation="GroupBy" SourceColumn=".." TargetColumn=".." IsUsed="true"></Column>
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetAggregateTransformationOutputColumns] (
	@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_SCHEMA VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@INCLUDE_COLUMNS VARCHAR(max)
	,-- todo: comma separated input. splitStringToTable and create internal table parameter
	@OperationType VARCHAR(50)
	)
RETURNS XML
AS
BEGIN
	DECLARE @OutputColumns XML

	SELECT @OutputColumns = (
			SELECT @OperationType AS '@Operation'
				,Column_Name AS '@SourceColumn'
				,OutPutColumnName AS '@TargetColumn'
				,'true' AS '@IsUsed'
			FROM (
				SELECT @INCLUDE_COLUMNS AS Column_Name
					, 1 AS ordinalNo
					, left(@INCLUDE_COLUMNS, charindex('_', @INCLUDE_COLUMNS, 1)-1) + '_bkey' as OutPutColumnName
				UNION
				
				SELECT dc.Column_Name
					,	2 AS ordinalNo
					, dc.Column_Name as OutPutColumnName
				FROM ssis.DerivedColumns dc
				WHERE (
						dc.Column_Name IN (
							/*'SysSrcGenerationDateTime'
							,'ToDate'
							,*/'SysIsInferred'
							,'SysExecutionLog_key'
							--,'DatetimeInsertedUTC'
							--,'ModifiedUTC'
							)
						AND @OperationType = 'GroupBy'
						)
					AND dc.DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND isnull(dc.DestinationTableName, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
				) Cols
			ORDER BY ordinalNo
				,Column_Name
			FOR XML path('Column')
			)

	RETURN @OutputColumns
END