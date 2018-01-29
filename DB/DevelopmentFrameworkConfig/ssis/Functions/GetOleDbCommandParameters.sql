-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Returns xml for OleDb Command in Data FLow
--		<Parameter SourceColumn="customer_code" TargetColumn="Param_0" Direction="Input"/>
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [ssis].[GetOleDbCommandParameters] (
	@SOURCE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_SCHEMA VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@UsageType VARCHAR(50)
	)
RETURNS XML
AS
BEGIN
	DECLARE @Parameters XML
	DECLARE @ExtendedParameters AS TABLE (
		column_name VARCHAR(128)
		,ordinal_position INT
		,r TINYINT
		,UsageType VARCHAR(50)
		)

	INSERT INTO @ExtendedParameters
	VALUES (
		'ToDateOld'
		,1
		,2
		,'dwTodate'
		)
		,(
		'SysExecutionLog_key'
		,2
		,2
		,'All'
		)

	SELECT @Parameters = (
			SELECT column_name AS '@SourceColumn'
				,CONCAT (
					'Param_'
					,Cast(ROW_NUMBER() OVER (
							ORDER BY r
								,ordinal_position
							) - 1 AS VARCHAR(10))
					) AS '@TargetColumn'
				,'Input' AS '@Direction'
			FROM (
				SELECT column_name
					,ordinal_position
					,1 AS r
				FROM ssis.UpdatableColumns
				WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND DestinationSchemaName = @DESTINATION_TABLE_SCHEMA
					AND DestinationTableName = @DESTINATION_TABLE_NAME
					AND @UsageType != 'dwTodate'
				
				UNION
				
				SELECT column_name
					,ordinal_position
					,r
				FROM @ExtendedParameters ep
				WHERE UsageType = @UsageType
					OR UsageType = 'All'
				
				UNION
				
				-- get the one identity column. It is derived from DestinationFieldExtended table.
				SELECT column_name
					,1 AS ORDINAL_POSITION
					,3 AS r
				FROM [Metadata].[DestinationFieldExtended]
				WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
					AND SourceTableCatalog = @SOURCE_CATALOG
					AND ApplicableTable = @DESTINATION_TABLE_NAME
					AND IsIdentity = 1
				) ParamSource
			ORDER BY r
				,ordinal_position
			FOR XML path('Parameter')
			)

	RETURN @Parameters
END