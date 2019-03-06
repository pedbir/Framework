
--DIM_Fields
CREATE VIEW [Fact].[d_Fields]
AS
SELECT 
	nf.Fields_key,
	nf.SysDatetimeDeletedUTC,
	nf2.SysModifiedUTC,
	nf.SysValidFromDateTime,
	nf.SysSrcGenerationDateTime,
	nf.Fields_bkey,
	nf2.TableName,
	nf2.ColumnName,
	nf2.Category
FROM [Norm].[n_Fields] nf
OUTER APPLY (SELECT TOP 1 * FROM [Norm].[n_Fields] nf2 WHERE nf2.Fields_bkey = nf.Fields_bkey ORDER BY nf2.[SysValidFromDateTime] DESC) nf2