CREATE PROCEDURE Metadata.RemoveMultipleMetaDataObject
    @SourceSchema VARCHAR(50)
   ,@DestinationTableCatalog VARCHAR(50)
AS

--EXEC Metadata.RemoveMultipleMetaDataObject 'Norm', 'DWH_2_Norm'

    DECLARE @psource_DB NVARCHAR(50)
       ,@pdest_schema NVARCHAR(50)
       ,@pdest_Table NVARCHAR(50)
       	 
        
        
    DECLARE SourceTables CURSOR FAST_FORWARD READ_ONLY
    FOR
        SELECT  dt.SourceTableCatalog
               ,dt.DestinationSchemaName
               ,dt.DestinationTableName
        FROM    Metadata.DestinationTable dt
        WHERE   dt.SourceSchemaName LIKE @SourceSchema + '%' AND dt.DestinationTableCatalog = @DestinationTableCatalog
        
    OPEN SourceTables;
        
    FETCH NEXT FROM SourceTables INTO @psource_DB, @pdest_schema, @pdest_Table
                 

    WHILE @@FETCH_STATUS = 0
        BEGIN
            
		  PRINT 'EXEC Metadata.RemoveMetaData @DestinationTableDataBase = ' + @DestinationTableCatalog + ',
                @SourceTableDataBase = ' + @psource_DB +',
                @DestinationTableName = '+ @pdest_Table + ',
                @DestinationSchemaName = ' + @pdest_schema + ''

            EXEC Metadata.RemoveMetaData @DestinationTableDataBase = @DestinationTableCatalog,
                @SourceTableDataBase = @psource_DB,
                @DestinationTableName = @pdest_Table,
                @DestinationSchemaName = @pdest_schema
        
            FETCH NEXT FROM SourceTables INTO @psource_DB, @pdest_schema,
                @pdest_Table
                
        END;
        
    CLOSE SourceTables;
    DEALLOCATE SourceTables;