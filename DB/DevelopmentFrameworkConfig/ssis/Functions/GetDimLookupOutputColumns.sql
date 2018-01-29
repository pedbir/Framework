
-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE function [ssis].[GetDimLookupOutputColumns] (
	@DIMENSION_SCHEMA_CATALOG varchar(max)
	,@DIMENSION_TABLE_NAME varchar(max)
	)
returns xml
as
begin
	declare @DerivedColumns xml

	select @DerivedColumns = (
			select SourceColumn as '@SourceColumn'
				,TargetColumn as '@TargetColumn'
			from (
				-- Key columns generated from ExtendedFields
				select COLUMN_NAME as SourceColumn
					,Column_Name as TargetColumn
					,ORDINAL_POSITION
				from [Metadata].[DestinationFieldExtended]
				where DestinationTableCatalog in ((select top 1 [NormEnvironmentName]
									from [Metadata].[EnvironmentVariables]), 
										  (select top 1 RawEnvironmentName
										  from [Metadata].[EnvironmentVariables]))
					and SourceTableCatalog = (select top 1 [StagingEnvironmentName]
												from [Metadata].[EnvironmentVariables])
					and ApplicableTable = @DIMENSION_TABLE_NAME
					and IsIdentity = 1
				
				union
				
				-- add IsInferred and FromDate
				select distinct COLUMN_NAME as 'SourceColumn'
					,CONCAT (
						'Old'
						,COLUMN_NAME
						) as 'TargetColumn'
					,ORDINAL_POSITION
				from Metadata.DestinationFieldExtended e
				where COLUMN_NAME in (
						'SysIsInferred'
						--,'SysSrcGenerationDateTime'
						)
				
				union
				
				-- add HashKey manually. Column is generated in OleDb Source component
				select 'CheckSumNonPK' as SourceColumn
					,'OldCheckSumNonPK' as TargetColumn
					,9999 as ORDINAL_POSITION
				) OutPutCols
			order by ORDINAL_POSITION
			for xml path('Column')
			)

	return @DerivedColumns
end