DECLARE @dataDirectory NVARCHAR(MAX) = 'C:\Users\pedram.birounvand\Dropbox (EQT AB)\DataWarehouse\Input\Talentsoft\Data\'
DECLARE @FormatDirectory NVARCHAR(MAX) = 'C:\Temp\'

SELECT 'bcp ' + t.TABLE_CATALOG + '.' + t.TABLE_SCHEMA + '.' + t.TABLE_NAME + ' out "' + @dataDirectory + t.TABLE_NAME + '.csv" -T -t; -c'
FROM INFORMATION_SCHEMA.TABLES t
WHERE t.TABLE_TYPE = 'BASE TABLE'
UNION ALL 
SELECT 'bcp ' + t.TABLE_CATALOG + '.' + t.TABLE_SCHEMA + '.' + t.TABLE_NAME + ' format nul -f "' + @FormatDirectory + t.TABLE_NAME + '.xml" -T -t; -c -x'
FROM INFORMATION_SCHEMA.TABLES t
WHERE t.TABLE_TYPE = 'BASE TABLE'