﻿-- =============================================
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
CREATE FUNCTION [ssis].[GetOleDbCommandUpdateColumns] (
	@SOURCE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_SCHEMA VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@UsageType VARCHAR(50)
	)
RETURNS VARCHAR(max)
AS
BEGIN
	DECLARE @UpdateCols VARCHAR(max)
	-- columns generated by ETL flow
	DECLARE @AdditionalColumns AS TABLE (
		column_name VARCHAR(128)
		,ordinal_position INT
		,r TINYINT
		,UsageType VARCHAR(50)
		)

	--insert into @AdditionalColumns values ('ToDate',1,3,'dwTodate')
	SELECT @UpdateCols = (
			SELECT stuff((
						SELECT ',' + col
						FROM (
							SELECT CONCAT (
									quotename(column_name)
									,' = ? '
									) col
								,ordinal_position
								,1 AS r
							FROM ssis.UpdatableColumns
							WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
								AND DestinationSchemaName = @DESTINATION_TABLE_SCHEMA
								AND DestinationTableName = @DESTINATION_TABLE_NAME
								AND @UsageType != 'dwToDate'
							
							UNION
							
							SELECT DISTINCT CONCAT (
									quotename(column_name)
									,CASE column_name
										WHEN 'SysDateTimeUpdatedUTC'
											THEN ' = GETUTCDATE()'
										WHEN 'SysModifiedUTC'
											THEN ' = GETUTCDATE()'
										WHEN 'SysIsInferred'
											THEN ' = 0'
										ELSE ' = ? '
										END
									) col
								,ordinal_position
								,2 AS r
							FROM Metadata.DestinationFieldExtended
							WHERE DestinationTableCatalog = @DESTINATION_TABLE_CATALOG
								AND column_name IN (
									'SysExecutionLog_key'
									,'SysDateTimeUpdatedUTC'
									,'SysModifiedUTC'
									)
								OR (
									column_name = 'SysIsInferred'
									AND @UsageType = 'dwInfUpd'
									)
								OR (
									column_name = 'ToDate'
									AND @UsageType = 'dwToDate'
									)
							-- get columns generated by ETL flow
							
							UNION
							
							SELECT CONCAT (
									quotename(column_name)
									,' = ? '
									) col
								,ordinal_position
								,r
							FROM @AdditionalColumns ac
							WHERE ac.UsageType = @UsageType
							) ColumnSource
						ORDER BY r
							,ordinal_position
						FOR XML path('')
						), 1, 1, ' ')
			)

	RETURN @UpdateCols
END