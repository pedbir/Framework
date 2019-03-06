



CREATE VIEW [Marketing].[d_Channel]
AS

SELECT Channel_key = pr.Project_key      
      ,ChannelCode = pr.ProjectCode
      ,Channel =     IIF(pr.Project_key = -1, pr.ProjectCode , pr.ProjectName )	
FROM Fact.d_Project pr
INNER JOIN  (SELECT DISTINCT Channel_key  FROM Marketing.f_FinanceMarketMetrics ) fmm ON pr.Project_key = fmm.Channel_key