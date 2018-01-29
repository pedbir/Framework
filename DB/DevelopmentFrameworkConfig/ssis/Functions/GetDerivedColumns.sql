
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
--		Table [Metadata].[DerivedColumnOverride] contains Extended fields values that needs
--		other than default in a specific type of Derived Column.
--		Further there are derived columns that do not exist as Extended fields for a given db-catalog
--		that needs to be populated when missing members needs to be inserted in FK related tables
-- Example:	
--
--
-- =============================================

CREATE FUNCTION [ssis].[GetDerivedColumns] (
	@SOURCE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_CATALOG VARCHAR(max)
	,@DESTINATION_TABLE_NAME VARCHAR(max)
	,@DESTINATION_SCHEMA_NAME VARCHAR(max)
	,@DeriveType VARCHAR(10)
	)
RETURNS XML
AS
BEGIN
	DECLARE @DerivedColumns XML

	SELECT @DerivedColumns = (
			SELECT isnull(DerCols.Column_Name, dco.[DerivedColumnName]) AS 'Column/@Name'
				,isnull(DerCols.Data_Type, dco.DataType) AS 'Column/@DataType'
				,
				-- default should be false
				isnull(dco.ReplaceExisting, DerCols.ReplaceExisting) AS 'Column/@ReplaceExisting'
				,isnull(DerCols.ColMaxLength, dco.ColMaxLength) AS 'Column/@Length'
				,CASE @DeriveType
					WHEN 'dwInfFK'
						-- if inferred member to foreign tables, apply missing member
						THEN isnull(dco.OverrideValue, DerCols.ColMissingMember)
							-- use default values
					ELSE isnull(dco.OverrideValue, DerCols.Col)
					END AS 'Column'
			FROM (
				SELECT column_name
					,ColMissingMember
					,data_type
					,isnull(dc.ColMaxLength, - 1) AS ColMaxLength
					,replaceExisting
					,col
				FROM [ssis].[DerivedColumns] dc
				WHERE IsNull(SourceTableCatalog, @SOURCE_CATALOG) = @SOURCE_CATALOG
					AND DestinationTableCatalog = @DESTINATION_TABLE_CATALOG	
					
					AND (CASE WHEN dc.DestinationSchemaName = '-' THEN @DESTINATION_SCHEMA_NAME ELSE dc.DestinationSchemaName END) = @DESTINATION_SCHEMA_NAME			
						
					AND isnull(DestinationTableName, @DESTINATION_TABLE_NAME) = @DESTINATION_TABLE_NAME
					AND (
						-- Add new row when new DeriveType
						(
							setFieldOnInsert = 1
							AND @DeriveType = 'ins'
							)
						OR (
							setFieldOnUpdate = 1
							AND @DeriveType = 'upd'
							)
						OR (
							setFieldOnDelete = 1
							AND @DeriveType = 'del'
							)
						OR (
							(
								/*column_name LIKE '%_bkey'
								OR */column_name IN (
									'SysExecutionLog_key'
									,'SysDatetimeInsertedUTC'
									,'SysModifiedUTC'
									,'SysDateTimeDeletedUTC'
									)
								)
							AND @DeriveType = 'dwInit'
							)
						OR (
							(column_name IN (
								'SysIsInferred'
								--,'SysSrcGenerationDateTime'
								) OR (column_name LIKE '%_bkey' AND column_name <> REPLACE(dc.DestinationTableName, 'n_', '') + '_bkey'))
							AND @DeriveType = 'dwInf'
							)
						OR (
							(
								column_name LIKE '%_bkey'
								AND stuff(@DESTINATION_TABLE_NAME, 1, 2, '') != replace(column_name, '_bkey', '')
								)
							AND @DeriveType = 'dwInfFK'
							)
						OR (
							column_name IN (
								'SysIsInferred'
								--,'SysSrcGenerationDateTime'
								)
							AND @DeriveType = 'dwNewRow'
							)
						OR (
							column_name IN (
								'SysIsInferred'
								--,'SysSrcGenerationDateTime'
								)
							AND @DeriveType = 'dwNewVer'
							)
						)
				) DerCols
			FULL OUTER JOIN (
				SELECT DerivedColumnName
					,dtt.Biml AS DataType
					,isnull(dco.[MaxLength], - 1) AS ColMaxLength
					,CASE OverrideValue
						WHEN '<<DynamicValue>>'
							THEN ssis.GetDerivedColumnDynamicOverrideValue(@SOURCE_CATALOG, @DESTINATION_TABLE_CATALOG, @DESTINATION_TABLE_NAME, dco.Id)
						ELSE OverrideValue
						END AS OverrideValue
					,'false' AS ReplaceExisting
				FROM Metadata.DerivedColumnOverride dco
				LEFT JOIN Metadata.DataTypeTranslation dtt ON dco.DataType = dtt.SQLServer
				WHERE dco.DerivedColumnType = @DeriveType
				) dco ON dco.DerivedColumnName = DerCols.Column_name
			ORDER BY isnull(DerCols.Column_Name, dco.[DerivedColumnName])
			FOR XML path('')
			)

	-- Remove attribute Length where value = -1
	SET @DerivedColumns.modify('delete /Column/@Length[. = "-1"]')

	-- Set ReplaceExisting to false if DeriveType is missing member foreign tables
	IF @DeriveType = 'dwInfFK'
	BEGIN
		DECLARE @T TABLE (Col XML)

		INSERT INTO @T
		SELECT a.query('.')
		FROM @DerivedColumns.nodes('Column') Col(a)

		UPDATE @T
		SET Col.modify('replace value of (/Column/@ReplaceExisting)[1] with "false"')

		SET @DerivedColumns = (
				SELECT Col AS [*]
				FROM @T
				FOR XML path('')
				)
	END

	RETURN @DerivedColumns
END