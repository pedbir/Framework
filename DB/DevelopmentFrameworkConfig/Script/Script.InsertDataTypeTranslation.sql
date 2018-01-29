SELECT id = 1, SQLServer = N'bigint', SSIS = N'DT_I8', Biml = N'Int64', DataTypeGroup = N'Numeric'
INTO #DataTypeTranslation 
UNION ALL SELECT 2, N'binary', N'DT_BYTES', N'Binary', N'Binary'
UNION ALL SELECT 3, N'bit', N'DT_BOOL', N'Boolean', N'Boolean'
UNION ALL SELECT 4, N'char', N'DT_STR', N'AnsiStringFixedLength', N'Text'
UNION ALL SELECT 5, N'date', N'DT_DBDATE', N'Date', N'Date'
UNION ALL SELECT 6, N'datetime', N'DT_DBTIMESTAMP', N'DateTime', N'Date'
UNION ALL SELECT 7, N'datetime2', N'DT_DBTIMESTAMP2', N'DateTime2', N'Date'
UNION ALL SELECT 8, N'datetimeoffset', N'DT_DBTIMESTAMPOFFSET', N'DateTimeOffset', N'Date'
UNION ALL SELECT 9, N'decimal', N'DT_DECIMAL', N'Decimal', N'Numeric'
UNION ALL SELECT 10, N'float', N'DT_R8', N'Double', N'Numeric'
UNION ALL SELECT 11, N'image', N'DT_IMAGE', N'Binary', N'Binary'
UNION ALL SELECT 12, N'int', N'DT_I4', N'Int32', N'Numeric'
UNION ALL SELECT 13, N'money', N'DT_CY', N'Currency', N'Numeric'
UNION ALL SELECT 14, N'nchar', N'DT_WSTR', N'StringFixedLength', N'Text'
UNION ALL SELECT 15, N'ntext', N'DT_NTEXT', N'String', N'Text'
UNION ALL SELECT 16, N'numeric', N'DT_NUMERIC', N'Decimal', N'Numeric'
UNION ALL SELECT 17, N'nvarchar', N'DT_WSTR', N'String', N'Text'
UNION ALL SELECT 18, N'real', N'DT_R4', N'Single', N'Numeric'
UNION ALL SELECT 19, N'smalldatetime', N'DT_DBTIMESTAMP', N'DateTime', N'Date'
UNION ALL SELECT 20, N'smallint', N'DT_I2', N'Int16', N'Numeric'
UNION ALL SELECT 21, N'smallmoney', N'DT_CY', N'Currency', N'Numeric'
UNION ALL SELECT 22, N'sql_variant', N'DT_WSTR', N'Object', N'Object'
UNION ALL SELECT 23, N'text', N'DT_TEXT', N'AnsiString', N'Text'
UNION ALL SELECT 24, N'time', N'DT_DBTIME2', N'Time', N'Date'
UNION ALL SELECT 25, N'tinyint', N'DT_UI1', N'Byte', N'Numeric'
UNION ALL SELECT 26, N'uniqueidentifier', N'DT_GUID', N'Guid', N'Guid'
UNION ALL SELECT 27, N'varbinary', N'DT_BYTES', N'Binary', N'Binary'
UNION ALL SELECT 28, N'varchar', N'DT_STR', N'AnsiString', N'Text'
UNION ALL SELECT 29, N'xml', N'DT_WSTR', N'Xml', N'XML'


SET IDENTITY_INSERT Metadata.DataTypeTranslation ON

INSERT Metadata.DataTypeTranslation (Id, SQLServer, SSIS, Biml, DataTypeGroup)
SELECT dtt.id
       , dtt.SQLServer
       , dtt.SSIS
       , dtt.Biml
       , dtt.DataTypeGroup
FROM   #DataTypeTranslation dtt
WHERE  dtt.id NOT IN (SELECT Id FROM Metadata.DataTypeTranslation)

SET IDENTITY_INSERT Metadata.DataTypeTranslation OFF
