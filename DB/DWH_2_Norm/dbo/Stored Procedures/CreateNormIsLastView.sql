CREATE PROCEDURE [dbo].[CreateNormIsLastView]
AS


/* declare variables */
DECLARE @sqldrop NVARCHAR(max), @sqlcreate NVARCHAR(max)

DECLARE sqlCreateView CURSOR FAST_FORWARD READ_ONLY FOR 
SELECT  sqldrop     = 'IF EXISTS (SELECT * from sys.objects WHERE object_id = OBJECT_ID(N''' + t._viewFullName + ''') AND type IN (N''V'')) DROP VIEW ' + t._viewFullName
        , sqlCreate = CASE WHEN t._type = 'Fact' THEN 'CREATE VIEW ' + t._viewFullName + ' AS
							SELECT * 
							FROM (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY ' + t._bkey + ' ORDER BY SysValidFromDateTime) FROM   ' + t._tableFullName + ') t 
							WHERE t._isLast = 1'
                           WHEN t._type = 'Dim' THEN 'CREATE VIEW ' + t._viewFullName + ' AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY ' + t._bkey + ' ORDER BY SysValidFromDateTime) FROM   ' + t._tableFullName + ')
							SELECT '                 + t._column + ', t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.' + t._bkey + ' = t1.' + t._bkey + ' AND t2._isLast = 1' ELSE 'ERROR' END
FROM    (   SELECT  _bkey            = REPLACE(t.TABLE_NAME, 'n_', '') + '_bkey'
                    , _key           = REPLACE(t.TABLE_NAME, 'n_', '') + '_key'
                    , _tableName     = t.TABLE_NAME
                    , _viewName      = 'v' + t.TABLE_NAME
                    , _schema        = t.TABLE_SCHEMA
                    , _tableFullName = t.TABLE_SCHEMA + '.' + t.TABLE_NAME
                    , _viewFullName  = t.TABLE_SCHEMA + '.' + 'v' + t.TABLE_NAME
                    , _column        = STUFF((   SELECT     CASE WHEN c.COLUMN_NAME = REPLACE(t.TABLE_NAME, 'n_', '') + '_key' THEN ', t1.' ELSE ', t2.' END + c.COLUMN_NAME
                                                 FROM       INFORMATION_SCHEMA.COLUMNS c
                                                 WHERE      c.TABLE_NAME = t.TABLE_NAME
                                                   AND      c.TABLE_SCHEMA    = t.TABLE_SCHEMA
                                                   AND      c.TABLE_CATALOG   = t.TABLE_CATALOG
                                                 ORDER BY   c.ORDINAL_POSITION
                                                 FOR XML PATH(''))
                                             , 1
                                             , 1
                                             , '')
                    , _type          = CASE WHEN EXISTS (   SELECT      *
                                                            FROM        INFORMATION_SCHEMA.COLUMNS c
                                                            WHERE       c.TABLE_NAME = t.TABLE_NAME
                                                              AND       c.TABLE_SCHEMA     = t.TABLE_SCHEMA
                                                              AND       c.TABLE_CATALOG    = t.TABLE_CATALOG
                                                              AND       c.COLUMN_NAME      = REPLACE(t.TABLE_NAME, 'n_', '') + '_key') THEN 'Dim' ELSE 'Fact' END
            FROM    DWH_2_Norm.INFORMATION_SCHEMA.TABLES t
            WHERE   t.TABLE_TYPE = 'BASE TABLE') t


OPEN sqlCreateView

FETCH NEXT FROM sqlCreateView INTO @sqldrop, @sqlcreate

WHILE @@FETCH_STATUS = 0
BEGIN
    
	PRINT @sqldrop
	EXEC(@sqldrop)

	PRINT @sqlcreate
	EXEC(@sqlcreate)
    FETCH NEXT FROM sqlCreateView INTO @sqldrop, @sqlcreate
END

CLOSE sqlCreateView
DEALLOCATE sqlCreateView