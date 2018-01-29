




CREATE PROCEDURE [Metadata].[CreateRawEntities] @SourceSchema VARCHAR(50), @DropAndCreate BIT = 0 
AS
--EXEC [Metadata].[CreateRawEntities] @SourceSchema = 'Netsuite', @DropAndCreate = 1 -- varchar(50)
--EXECUTE Metadata.RemoveMultipleMetaDataObject @SourceSchema = 'Netsuite', @DestinationTableCatalog = 'DWH_1_Raw'

    DECLARE @psource_DB NVARCHAR(50)
       ,@pdest_db NVARCHAR(50) = 'DWH_1_Raw'
       ,@psource_schema NVARCHAR(50)
       ,@pdest_schema NVARCHAR(50)
       ,@psource_table NVARCHAR(50)
       ,@pGroupName NVARCHAR(50)
       ,@pdest_Table NVARCHAR(50)
       ,@pCreateOrRebuild NVARCHAR(50);
		 
        
    IF @DropAndCreate = 1
        BEGIN 
            EXECUTE Metadata.RemoveMultipleMetaDataObject @SourceSchema = @SourceSchema, @DestinationTableCatalog = @pdest_db             
        END 
	       
    DECLARE SourceTables CURSOR FAST_FORWARD READ_ONLY
    FOR
        SELECT  psource_DB		 = t.TABLE_CATALOG
               ,psource_schema	 = t.TABLE_SCHEMA
               ,psource_table		 = t.TABLE_NAME 
               ,pGroupName		 = CASE WHEN t.TABLE_SCHEMA LIKE '%[_]f' THEN 'Fact' ELSE 'Dimension' END
               ,pdest_schema		 = REPLACE(REPLACE(t.TABLE_SCHEMA, '_d', ''), '_f', '') +'_RawTyped'
               ,pdest_Table		 = CONCAT('r_', t.TABLE_NAME)
               ,pCreateOrRebuild	 = CASE WHEN dt.SourceTableName IS NULL THEN 'C' ELSE 'R' END
        FROM    DWH_1_Raw.INFORMATION_SCHEMA.TABLES t
        LEFT JOIN Metadata.DestinationTable dt ON t.TABLE_SCHEMA = dt.SourceSchemaName AND t.TABLE_CATALOG = dt.SourceTableCatalog AND t.TABLE_NAME = dt.SourceTableName
        WHERE   t.TABLE_TYPE = 'VIEW' AND t.TABLE_SCHEMA LIKE @SourceSchema + '%';
        
    OPEN SourceTables;
        
    FETCH NEXT FROM SourceTables INTO @psource_DB, @psource_schema,
        @psource_table, @pGroupName, @pdest_schema, @pdest_Table, @pCreateOrRebuild;
                 

    WHILE @@FETCH_STATUS = 0
        BEGIN
        
            IF NOT EXISTS ( SELECT  *
                            FROM    DWH_1_Raw.sys.schemas
                            WHERE   name = @pdest_schema )
                BEGIN 
                        
                    EXEC('use '+ @pdest_db +'; exec sp_executesql N''create schema '+ @pdest_schema +' '' ')
				   
                END;

            IF @pCreateOrRebuild = 'R'
                BEGIN				       		  
				EXECUTE Metadata.ReGenerateTable @_DestinationTableCatalog = @pdest_db,
				    @_LinkedServerName = N'localhost', 
				    @_DestinationTableName = @pdest_Table,
				    @_DestinationSchemaName = @pdest_schema, 
				    @UpdateSourceFields = 1, -- bit
				    @VersionComment = 'AutoRebuild' 				
                END 

            IF @pCreateOrRebuild = 'C' 
                BEGIN 
                    EXECUTE Metadata.CreateNormEntity @source_DB = @psource_DB,
                        @dest_db = @pdest_db, 
				    @source_schema = @psource_schema,
                        @dest_schema = @pdest_schema,
                        @source_table = @psource_table, 
				    @BIP = N'Test',
                        @GroupName = @pGroupName;
                END 
        
            FETCH NEXT FROM SourceTables INTO @psource_DB, @psource_schema,
                @psource_table, @pGroupName, @pdest_schema, @pdest_Table, @pCreateOrRebuild;
        END;
        
    CLOSE SourceTables;
    DEALLOCATE SourceTables;