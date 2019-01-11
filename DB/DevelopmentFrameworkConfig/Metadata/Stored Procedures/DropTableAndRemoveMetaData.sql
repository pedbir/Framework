-- =============================================
--
-- Author:		
-- Create date: 2018-12-04
-- Description:	
--	
--	
--	
-- Example:	
--	EXEC Metadata.DropTableAndRemoveMetaData 
--				 @SourceTableCatalog      = N'DWH_1_Raw'
--				,@DestinationTableCatalog = N'DWH_2_Norm'
--				,@SourceSchema            = N'Norm'
--				,@DestinationSchemaName   = N'Norm'       
--				,@SourceTable             = N'TestEtlUser'
-- =============================================

CREATE PROC Metadata.DropTableAndRemoveMetaData
	  @SourceTableCatalog NVARCHAR(128)
	 ,@DestinationTableCatalog NVARCHAR(128)
	 ,@SourceSchema NVARCHAR(128)
	 ,@DestinationSchemaName NVARCHAR(128)
	 ,@SourceTable NVARCHAR(128)
	 ,@LinkedServerName NVARCHAR(128) = 'LOCALHOST'
	 ,@Verbose BIT = 1
AS
SET XACT_ABORT ON
SET NOCOUNT ON
BEGIN
  
  BEGIN TRANSACTION RemoveMetadata

  BEGIN TRY
    DECLARE @DestinationTableName     NVARCHAR(128) = ( SELECT  TOP 1 dt.DestinationTableName FROM    Metadata.DestinationTable dt WHERE   dt.SourceTableCatalog          = @SourceTableCatalog AND dt.DestinationTableCatalog = @DestinationTableCatalog AND dt.SourceSchemaName        = @SourceSchema AND dt.SourceTableName         = @SourceTable)
           ,@SqlDropSource            NVARCHAR(MAX)
           ,@SqlDropDestination       NVARCHAR(MAX)
           ,@SQLSourceTableExist      NVARCHAR(MAX)
           ,@SQLDestinationTableExist NVARCHAR(MAX)

    IF (@DestinationTableName IS NULL)
	BEGIN
		DECLARE @errorMsg NVARCHAR(100) ='Source ' + QUOTENAME(@SourceSchema) + '.' + QUOTENAME(@SourceTable) + ' was not found in database ' + QUOTENAME(@SourceTableCatalog) + '. Check parameters and try again'
		RAISERROR(@errorMsg, 18, 1) WITH NOWAIT
		RETURN
	END 
	
	CREATE TABLE #Source_tables(SourceTable NVARCHAR(500),SourceType NVARCHAR(10))

    PRINT CHAR(10) + '------------------------------------------------------------------------------------------------------------------------------'
    PRINT 'Drop Source: [' + @SourceSchema + '].[' + @SourceTableCatalog + ']'
    PRINT '------------------------------------------------------------------------------------------------------------------------------' + CHAR(10)

    SET @SQLSourceTableExist = N'EXECUTE ' + @LinkedServerName + N'.' + @SourceTableCatalog + N'.dbo.sp_executesql
		N''SELECT o.name, o.type FROM sys.objects o WHERE o.name = ''''' + @SourceTable + N'''''' + N'AND SCHEMA_NAME(o.schema_id) = ''''' + @SourceSchema + N'''''' + N'''';

    IF (@Verbose = 1) PRINT @SQLSourceTableExist

    INSERT INTO #Source_tables EXECUTE (@SQLSourceTableExist)

    IF EXISTS (SELECT TOP 1 st.SourceTable FROM #Source_tables st WHERE st.SourceType = 'V')
    BEGIN
      SET @SqlDropSource = N'EXECUTE ' + @LinkedServerName + N'.' + @SourceTableCatalog + N'.dbo.sp_executesql N''DROP VIEW ' + @SourceSchema + N'.' + @SourceTable + N''''
      IF (@Verbose = 1) PRINT @SqlDropSource
      EXEC (@SqlDropSource)
    END

    TRUNCATE TABLE #Source_tables
    PRINT CHAR(10) + '------------------------------------------------------------------------------------------------------------------------------'
    PRINT 'Drop Destination: [' + @DestinationSchemaName + '].[' + @DestinationTableName + ']'
    PRINT '------------------------------------------------------------------------------------------------------------------------------' + CHAR(10)

    SET @SQLDestinationTableExist = N'EXECUTE ' + @LinkedServerName + N'.' + @DestinationTableCatalog + N'.dbo.sp_executesql
		N''SELECT o.name, o.type FROM sys.objects o WHERE o.name = ''''' + @DestinationTableName + N'''''' + N'AND SCHEMA_NAME(o.schema_id) = ''''' + @DestinationSchemaName + N'''''' + N'''';

    IF (@Verbose = 1) PRINT @SQLDestinationTableExist

    INSERT INTO #Source_tables EXECUTE (@SQLDestinationTableExist)

    IF EXISTS (SELECT TOP 1 st.SourceTable FROM #Source_tables st WHERE st.SourceType = 'U')
    BEGIN
      SET @SqlDropDestination = N'EXECUTE ' + @LinkedServerName + N'.' + @DestinationTableCatalog + N'.dbo.sp_executesql N''DROP TABLE ' + @DestinationSchemaName + N'.' + @DestinationTableName + N''''
      IF (@Verbose = 1) PRINT @SqlDropDestination
      EXEC (@SqlDropDestination)
    END

    PRINT CHAR(10) + '------------------------------------------------------------------------------------------------------------------------------'
    PRINT 'Remove Metadata'
    PRINT '------------------------------------------------------------------------------------------------------------------------------' + CHAR(10)

    EXEC DevelopmentFrameworkConfig.Metadata.RemoveMetaData @DestinationTableDataBase = @DestinationTableCatalog
                                                           ,@SourceTableDataBase = @SourceTableCatalog
                                                           ,@DestinationTableName = @DestinationTableName
                                                           ,@DestinationSchemaName = @DestinationSchemaName




    COMMIT TRANSACTION RemoveMetadata
  END TRY
  BEGIN CATCH  
    ROLLBACK TRANSACTION RemoveMetadata;
    THROW;
  END CATCH
END