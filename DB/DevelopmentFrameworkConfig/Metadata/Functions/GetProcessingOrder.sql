/*

CREATE FUNCTION Metadata.GetProcessingOrder(
    @LoadContext nvarchar(max)=NULL
)
RETURNS @tbl TABLE (
    SSISPackageName     varchar(128) NOT NULL,
    LoadOrder           int NOT NULL
)
AS

BEGIN;

    DECLARE @context TABLE (
        Context                 nvarchar(1000) NOT NULL,
        PRIMARY KEY CLUSTERED (Context)
    );

    DECLARE @depends TABLE (
        SourceDatabase          sysname NOT NULL,
        SourceObjectID          int NOT NULL,
        SourceObjectName        nvarchar(1000) NOT NULL,
        SSISPackageName         varchar(128) NULL,
        DestinationDatabase     sysname NOT NULL,
        DestinationObjectID     int NOT NULL,
        DestinationObjectName   nvarchar(1000) NOT NULL,
        PRIMARY KEY CLUSTERED (DestinationDatabase, DestinationObjectID, SourceDatabase, SourceObjectID)
    );


    --- This is what we want to load (parsing the @LoadContext variable into the @context table)
    INSERT INTO @context (Context)
    SELECT DISTINCT LTRIM(RTRIM(context.n.value('.', 'nvarchar(1000)'))) AS Context
    FROM (SELECT CAST(N'<context>'+REPLACE(@LoadContext, N',', N'</context><context>')+N'</context>' AS xml)) AS x(blob)
    CROSS APPLY x.blob.nodes('/context') AS context(n);




    --- View dependencies in DWH_1_Raw
    INSERT INTO @depends
    SELECT DISTINCT ISNULL(d.referenced_database_name, 'DWH_1_Raw') AS SourceDatabase,
           COALESCE(d.referenced_id, OBJECT_ID(ISNULL(d.referenced_database_name+N'.', N'')+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name), 0) AS SourceObjectID,
           ISNULL(d.referenced_database_name, N'DWH_1_Raw')+N'.'+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           'DWH_1_Raw' AS DestinationDatabase,
           d.referencing_id AS DestinationObjectID,
           N'DWH_1_Raw.'+s.[name]+N'.'+v.[name] AS DestinationObjectName
    FROM DWH_1_Raw.sys.objects AS v
    INNER JOIN DWH_1_Raw.sys.schemas AS s ON v.[schema_id]=s.[schema_id]
    INNER JOIN DWH_1_Raw.sys.sql_expression_dependencies AS d ON v.[object_id]=d.referencing_id
    WHERE d.referencing_id!=d.referenced_id AND
          v.[type] IN ('TF', 'FN', 'IF', 'V') AND
          d.referencing_class=1 AND     -- OBJECT_OR_COLUMN
          d.referenced_class=1;         -- OBJECT_OR_COLUMN

/*  --- Foreign key constraints in DWH_2_Norm
    INSERT INTO @depends
    SELECT DISTINCT N'DWH_1_Raw' AS SourceDatabase,
           fk.referenced_object_id AS SourceObjectID,
           N'DWH_1_Raw.'+ss.[name]+N'.'+s.[name] AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           N'DWH_1_Raw' AS DestinationDatabase,
           fk.parent_object_id AS DestinationObjectID,
           N'DWH_1_Raw.'+ds.[name]+N'.'+d.[name] AS DestinationObjectName
    FROM DWH_1_Raw.sys.foreign_keys AS fk
    INNER JOIN DWH_1_Raw.sys.tables AS s ON fk.referenced_object_id=s.[object_id]
    INNER JOIN DWH_1_Raw.sys.schemas AS ss ON s.[schema_id]=ss.[schema_id]
    INNER JOIN DWH_1_Raw.sys.tables AS d ON fk.parent_object_id=d.[object_id]
    INNER JOIN DWH_1_Raw.sys.schemas AS ds ON d.[schema_id]=ds.[schema_id]
    WHERE fk.parent_object_id!=fk.referenced_object_id;
*/


    --- View dependencies in DWH_2_Norm
    INSERT INTO @depends
    SELECT DISTINCT ISNULL(d.referenced_database_name, 'DWH_2_Norm') AS SourceDatabase,
           COALESCE(d.referenced_id, OBJECT_ID(ISNULL(d.referenced_database_name+N'.', N'')+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name), 0) AS SourceObjectID,
           ISNULL(d.referenced_database_name, N'DWH_2_Norm')+N'.'+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           'DWH_2_Norm' AS DestinationDatabase,
           d.referencing_id AS DestinationObjectID,
           N'DWH_2_Norm.'+s.[name]+N'.'+v.[name] AS DestinationObjectName
    FROM DWH_2_Norm.sys.objects AS v
    INNER JOIN DWH_2_Norm.sys.schemas AS s ON v.[schema_id]=s.[schema_id]
    INNER JOIN DWH_2_Norm.sys.sql_expression_dependencies AS d ON v.[object_id]=d.referencing_id
    WHERE d.referencing_id!=d.referenced_id AND
          v.[type] IN ('TF', 'FN', 'IF', 'V') AND
          d.referencing_class=1 AND     -- OBJECT_OR_COLUMN
          d.referenced_class=1;         -- OBJECT_OR_COLUMN


/*  --- Foreign key constraints in DWH_2_Norm
    INSERT INTO @depends
    SELECT DISTINCT N'DWH_2_Norm' AS SourceDatabase,
           fk.referenced_object_id AS SourceObjectID,
           N'DWH_2_Norm.'+ss.[name]+N'.'+s.[name] AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           N'DWH_2_Norm' AS DestinationDatabase,
           fk.parent_object_id AS DestinationObjectID,
           N'DWH_2_Norm.'+ds.[name]+N'.'+d.[name] AS DestinationObjectName
    FROM DWH_2_Norm.sys.foreign_keys AS fk
    INNER JOIN DWH_2_Norm.sys.tables AS s ON fk.referenced_object_id=s.[object_id]
    INNER JOIN DWH_2_Norm.sys.schemas AS ss ON s.[schema_id]=ss.[schema_id]
    INNER JOIN DWH_2_Norm.sys.tables AS d ON fk.parent_object_id=d.[object_id]
    INNER JOIN DWH_2_Norm.sys.schemas AS ds ON d.[schema_id]=ds.[schema_id]
    WHERE fk.parent_object_id!=fk.referenced_object_id;
*/



    --- View dependencies in DWH_3_Fact
    INSERT INTO @depends
    SELECT DISTINCT ISNULL(d.referenced_database_name, 'DWH_3_Fact') AS SourceDatabase,
           COALESCE(d.referenced_id, OBJECT_ID(ISNULL(d.referenced_database_name+N'.', N'')+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name), 0) AS SourceObjectID,
           ISNULL(d.referenced_database_name, N'DWH_3_Fact')+N'.'+ISNULL(d.referenced_schema_name, N'dbo')+N'.'+d.referenced_entity_name AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           'DWH_3_Fact' AS DestinationDatabase,
           d.referencing_id AS DestinationObjectID,
           N'DWH_3_Fact.'+s.[name]+N'.'+v.[name] AS DestinationObjectName
    FROM DWH_3_Fact.sys.objects AS v
    INNER JOIN DWH_3_Fact.sys.schemas AS s ON v.[schema_id]=s.[schema_id]
    INNER JOIN DWH_3_Fact.sys.sql_expression_dependencies AS d ON v.[object_id]=d.referencing_id
    WHERE d.referencing_id!=d.referenced_id AND
          v.[type] IN ('TF', 'FN', 'IF', 'V') AND
          d.referencing_class=1 AND     -- OBJECT_OR_COLUMN
          d.referenced_class=1;         -- OBJECT_OR_COLUMN


/*  --- Foreign key constraints in DWH_3_Fact
    INSERT INTO @depends
    SELECT DISTINCT N'DWH_3_Fact' AS SourceDatabase,
           fk.referenced_object_id AS SourceObjectID,
           N'DWH_3_Fact.'+ss.[name]+N'.'+s.[name] AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           N'DWH_3_Fact' AS DestinationDatabase,
           fk.parent_object_id AS DestinationObjectID,
           N'DWH_3_Fact.'+ds.[name]+N'.'+d.[name] AS DestinationObjectName
    FROM DWH_3_Fact.sys.foreign_keys AS fk
    INNER JOIN DWH_3_Fact.sys.tables AS s ON fk.referenced_object_id=s.[object_id]
    INNER JOIN DWH_3_Fact.sys.schemas AS ss ON s.[schema_id]=ss.[schema_id]
    INNER JOIN DWH_3_Fact.sys.tables AS d ON fk.parent_object_id=d.[object_id]
    INNER JOIN DWH_3_Fact.sys.schemas AS ds ON d.[schema_id]=ds.[schema_id]
    WHERE fk.parent_object_id!=fk.referenced_object_id;
*/



    --- Foreign key constraints according to framework configuration:
    INSERT INTO @depends
    SELECT DISTINCT c.DimensionTableCatalog AS SourceDatabase,
           ISNULL(OBJECT_ID(c.DimensionTableCatalog+N'.'+c.DimensionSchemaName+N'.'+c.ForeignKeyTableName), 0) AS SourceObjectID,
           c.DimensionTableCatalog+N'.'+c.DimensionSchemaName+N'.'+c.ForeignKeyTableName AS SourceObjectName,
           CAST(NULL AS varchar(128)) AS SSISPackageName,
           c.DimensionTableCatalog AS DestinationDatabase,
           ISNULL(OBJECT_ID(c.DimensionTableCatalog+N'.'+c.DimensionSchemaName+N'.'+c.DimensionTableName), 0) AS DestinationObjectID,
           c.DimensionTableCatalog+N'.'+c.DimensionSchemaName+N'.'+c.DimensionTableName AS DestinationObjectName
    FROM ssis.DimensionForeignKeyColumns AS c;



    --- SSIS Package dependencies:
    INSERT INTO @depends
    SELECT SourceTableCatalog AS SourceDatabase,
           OBJECT_ID(SourceTableCatalog+N'.'+SourceSchemaName+N'.'+SourceTableName) AS SourceObjectID,
           SourceTableCatalog+N'.'+SourceSchemaName+N'.'+SourceTableName AS SourceObjectName,
           SSISPackageName,
           DestinationTableCatalog AS DestinationDatabase,
           OBJECT_ID(DestinationTableCatalog+N'.'+DestinationSchemaName+N'.'+DestinationTableName) AS DestinationObjectID,
           DestinationTableCatalog+N'.'+DestinationSchemaName+N'.'+DestinationTableName AS DestinationObjectName
    FROM Metadata.DestinationTable;





    --- Remove "islands", i.e. stuff that has no dependencies AND no dependents.
    DELETE d
    FROM @depends AS d
    WHERE d.SourceObjectID=0 OR
          (SELECT COUNT(*) FROM @depends AS x WHERE x.DestinationDatabase=d.SourceDatabase AND x.DestinationObjectID=d.SourceObjectID)=0 AND -- Sources
          (SELECT COUNT(*) FROM @depends AS x WHERE x.SourceDatabase=d.DestinationDatabase AND x.SourceObjectID=d.DestinationObjectID)=0;    -- Dependents





    --- Building the load order hierarchy:
    WITH rcte AS (
        --- The anchor is the end-product - tables that have no other dependents (destinations)
        SELECT d.SourceDatabase, d.SourceObjectID, d.SSISPackageName, 0 AS [Level],
               CAST(d.SourceObjectName+N'   ->   '+d.DestinationObjectName AS nvarchar(max)) AS [Path]
        FROM @depends AS d
        LEFT JOIN (SELECT DISTINCT SourceDatabase, SourceObjectID FROM @depends) AS x ON
            x.SourceDatabase=d.DestinationDatabase AND
            x.SourceObjectID=d.DestinationObjectID

        WHERE d.SSISPackageName IS NOT NULL AND

              (@LoadContext IS NULL AND
               x.SourceDatabase IS NULL --- No dependents
               OR
               @LoadContext IS NOT NULL AND (
                    --- Load context referring to fully qualified destination table, example "DWH_2_Norm.Norm.n_Country":
                    d.DestinationObjectName IN (SELECT Context FROM @context) OR
                    --- Load context referring to SSIS package name:
                    d.SSISPackageName       IN (SELECT Context FROM @context))
              )
      
        UNION ALL

        --- Recursing "backwards" through the dependencies:
        SELECT d.SourceDatabase AS [Database], d.SourceObjectID AS [object_id], d.SSISPackageName, rcte.[Level]+1,
               CAST(d.SourceObjectName+N'   ->   '+rcte.[Path] AS nvarchar(max)) AS [Path]
        FROM @depends AS d
        INNER JOIN rcte ON
            rcte.SourceDatabase=d.DestinationDatabase AND
            rcte.SourceObjectID=d.DestinationObjectID
        )

    --- ... and dump the result in the output table:
    INSERT INTO @tbl (SSISPackageName, LoadOrder)
    SELECT DISTINCT SSISPackageName,
           DENSE_RANK() OVER (ORDER BY [Level] DESC) AS LoadOrder
    FROM (
        SELECT *, MAX([Level]) OVER (PARTITION BY SSISPackageName) AS _maxLevel
        FROM rcte
        WHERE SSISPackageName IS NOT NULL
        ) AS sub
    WHERE [Level]=_maxLevel;

    --- Done.
    RETURN;

END;

*/