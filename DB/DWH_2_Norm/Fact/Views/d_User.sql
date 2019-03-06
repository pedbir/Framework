CREATE VIEW [Fact].[d_User]
AS
SELECT   User_key = ndq.LoginName
		,SysDatetimeDeletedUTC = MAX(ndq.SysDatetimeDeletedUTC) 	-- mandatory när man generer tabellen med sp
		,SysModifiedUTC = MAX(ndq.SysModifiedUTC)					-- mandatory när man genererar ssis med BIML
FROM [Norm].[n_DailyQueries] ndq
GROUP BY ndq.LoginName