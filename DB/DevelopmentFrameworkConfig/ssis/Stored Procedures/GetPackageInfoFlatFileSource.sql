CREATE PROC [ssis].[GetPackageInfoFlatFileSource]
  @DESTINATION_TABLE_CATALOG VARCHAR(128)
 ,@DESTINATION_SCHEMA_NAMES VARCHAR(128)
 ,@DESTINATION_TABLE_NAME VARCHAR(128)
AS
SET XACT_ABORT ON
SET NOCOUNT ON

/*
EXEC ssis.GetPackageInfoFlatFileSource @DESTINATION_TABLE_CATALOG = 'DWH_1_Raw'  -- varchar(128)
                                      ,@DESTINATION_SCHEMA_NAMES = 'Agresso_RawTyped'   -- varchar(128)
                                      ,@DESTINATION_TABLE_NAME = 'rt_Rapportstruktur_01'     -- varchar(128)

*/

SELECT      COLUMN_NAME
           ,BIML_DATATYPE
           ,LENGHT                   = ISNULL(sfffs.CHARACTER_MAXIMUM_LENGTH, 0)
           ,NUMERIC_PRECISION        = ISNULL(NUMERIC_PRECISION, 0)
           ,NUMERIC_SCALE            = ISNULL(NUMERIC_SCALE, 0)
           ,ORDINAL_POSITION         = ISNULL(ORDINAL_POSITION, 0)
           ,DELIMITER                = LEAD(dtffs.ColumnDelimiter, 1, dtffs.RowDelimiter) OVER (ORDER BY sfffs.ORDINAL_POSITION)
           ,SOURCETABLECATALOG       = dtffs.SourceRootFolder
           ,SOURCESCHEMANAME         = dtffs.SourceArea
           ,SourceTableName          = REPLACE(dtffs.DestinationTableName, 'rt_', '')
           ,FilePattern
           ,ColumnNamesInFirstDataRow = IIF(ColumnNamesInFirstDataRow = 1, 'true', 'false')
           ,HeaderRowsToSkip
           ,DataRowsToSkip
           ,FlatFileType
           ,HeaderRowDelimiter
           ,RowDelimiter
           ,ColumnDelimiter
           ,TextQualifer             = IIF(dtffs.TextQualifer = '"', '&quot;', dtffs.TextQualifer)
           ,IsUnicode				 = IIF(dtffs.IsUnicode = 1, 'true', 'false')
           ,CodePage
           ,DestinationFullTableName = QUOTENAME(dtffs.DestinationSchemaName) + '.' + QUOTENAME(dtffs.DestinationTableName)
           ,DestinationFullViewName  = QUOTENAME(dtffs.DestinationSchemaName) + '.' + QUOTENAME('v' + dtffs.DestinationTableName)
           ,DestinationDatabaseName
           ,Locale
           ,FileNameRegExDateTime
           ,FileNameDateTimePattern
           ,ExecProc                 = dtffs.ExecProcAnnotation
           ,DestinationSchemaName
           ,DestinationTableName
           ,dtffs.SSISPackageName
FROM        Metadata.DestinationTableFlatFileSource dtffs
INNER JOIN  Metadata.SourceFieldFlatFileSource      sfffs ON sfffs.SSISPackageName = dtffs.SSISPackageName
WHERE       dtffs.DestinationDatabaseName   = @DESTINATION_TABLE_CATALOG
            AND dtffs.DestinationSchemaName = @DESTINATION_SCHEMA_NAMES
            AND dtffs.DestinationTableName  = @DESTINATION_TABLE_NAME
