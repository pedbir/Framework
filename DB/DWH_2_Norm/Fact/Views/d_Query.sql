CREATE VIEW [Fact].[d_Query]
AS
SELECT 
	    Query_key = ndq.DailyQueries_bkey,
	   	ndq.SysDatetimeDeletedUTC,
		ndq2.SysModifiedUTC,
		ndq.SysValidFromDateTime,
		ndq.SysSrcGenerationDateTime,
		ndq.SqlQuery,
		ndq.DatabaseName
		--använde bkey som primary... Hittade ingen lämpligare... För i denna fall har källan ingen key.
FROM [Norm].[n_DailyQueries] ndq
OUTER APPLY (SELECT TOP 1 * FROM [Norm].[n_DailyQueries] ndq2 WHERE ndq2.DailyQueries_bkey = ndq.DailyQueries_bkey ORDER BY ndq2.[SysValidFromDateTime] DESC) ndq2