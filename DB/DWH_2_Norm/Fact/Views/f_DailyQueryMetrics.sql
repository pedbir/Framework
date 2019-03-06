CREATE VIEW [Fact].[f_DailyQueryMetrics]
AS

SELECT DailyQueryMetrics_key = DailyQueries_bkey
	, Query_key = dq.DailyQueries_bkey
	, Calendar_key = CAST(dq.Calendar_bkey AS DATE)
	, dq.SysDatetimeDeletedUTC	-- mandatory när man generer tabellen med sp
	, dq.SysModifiedUTC			-- mandatory när man genererar ssis med BIML
	, f.Fields_key
	, User_key = dq.LoginName
	, NoOfQueries = CAST(1 AS INT)
FROM [Norm].[n_DailyQueries] dq
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Fields f WHERE f.Fields_bkey = dq.Fields_bkey ORDER BY f.SysValidFromDateTime DESC) f