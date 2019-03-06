CREATE VIEW [Sales].[f_LoanApplicationMetrics]
AS
SELECT      LoanApplication_key      = CAST(CAST(fmlam.MLLoanApplication_key AS NVARCHAR(100)) + '#ML' AS NVARCHAR(100))
           ,Calendar_Contact_key     = fmlam.Calendar_Contact_key
           ,Calendar_Milestone_key   = fmlam.Calendar_MilestoneStart_key
           ,FinanceSegment_key       = fmlam.FinanceSegment_key
           ,LoanApplicationStatus    = fmlam.MLLoanApplicationStatus
           ,MilestoneStatusName      = SUBSTRING(fmlam.MilestoneStatusName, CHARINDEX('-', fmlam.MilestoneStatusName) + 1, 100)
           ,MilestoneStatusSort      = ISNULL(NULLIF(SUBSTRING(fmlam.MilestoneStatusName, 0, CHARINDEX('-', fmlam.MilestoneStatusName)), ''), -1)
           ,LoanApplicationSource    = fmlam.LoanApplicationSource
           ,PayoutAmount             = fmlam.PayoutAmount
           ,NoOfPayout               = fmlam.NoOfPayout
           ,ApplicationAmount        = fmlam.ApplicationAmount
           ,NoOfApplication          = fmlam.NoOfApplication
           ,NoOfDeclined             = fmlam.NoOfDeclined
           ,Interest                 = fmlam.Interest
           ,BaseRate                 = fmlam.BaseRate
           ,InterestMargin           = ISNULL(fmlam.ManualInterestMargin, fmlam.InterestMargin)
           ,ManualInterestMargin     = fmlam.ManualInterestMargin
           ,RiskInterestRate         = fmlam.RiskInterestRate
           ,InterestRateTotal        = fmlam.InterestRateTotal
           ,ApplicationDurationDay   = DATEDIFF(DAY, fmlam.Calendar_MilestoneStart_key, fmlam.Calendar_MilestoneEnd_key)
           ,PayoutAmountB            = 0
           ,NoOfPayoutB              = 0
           ,Scenario                 = 'A'
           ,LoanApplication_bkey     = CAST(CAST(fmlam.MLLoanApplication_bkey AS NVARCHAR(100)) + '#ML' AS NVARCHAR(100))
           ,CurrentPeriod_key        = CASE WHEN CONVERT(NVARCHAR(6), fmlam.Calendar_MilestoneStart_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, -1, GETDATE()), 112) THEN 1
                                            WHEN CONVERT(NVARCHAR(6), fmlam.Calendar_MilestoneStart_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 0, GETDATE()), 112) THEN 2
                                            WHEN CONVERT(NVARCHAR(6), fmlam.Calendar_MilestoneStart_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 1, GETDATE()), 112) THEN 3 ELSE -1 END
           ,fmlam.IsPreAppLoanPromise
           ,AgingApplicationToPayout = CASE WHEN t.DaysUntilPayout < 60 THEN '2M'
                                            WHEN t.DaysUntilPayout BETWEEN 60 AND 119 THEN '4M'
                                            WHEN t.DaysUntilPayout BETWEEN 120 AND 210 THEN '7M'
                                            WHEN t.DaysUntilPayout > 210 OR fmlam.NoOfPayout = 1 THEN '7M<' ELSE 'N/A' END
FROM        Fact.f_MLLoanApplicationMetrics                                                                     fmlam
LEFT JOIN   ( SELECT    fmlam.MLLoanApplication_bkey
                       ,ApplicationDate = MIN(fmlam.Calendar_MilestoneStart_key)
              FROM      Fact.f_MLLoanApplicationMetrics fmlam
              WHERE     fmlam.MilestoneStatusName = '40-Application'
              GROUP BY  fmlam.MLLoanApplication_bkey)                                                            fmlam1 ON fmlam.MLLoanApplication_bkey = fmlam1.MLLoanApplication_bkey
                                                                                                                           AND fmlam.NoOfPayout = 1
OUTER APPLY (SELECT DaysUntilPayout = DATEDIFF(DAY, fmlam1.ApplicationDate, fmlam.Calendar_MilestoneStart_key)) t
UNION ALL
SELECT      LoanApplication_key      = CAST(fplam.PLLoanApplicationMetrics_key + '#PL' AS NVARCHAR(100))
           ,Calendar_Contact_key     = CAST(fplam.SysSrcGenerationDateTime AS DATE)
           ,Calendar_Milestone_key   = CAST(fplam.SysSrcGenerationDateTime AS DATE)
           ,FinanceSegment_key       = fplam.FinanceSegment_key
           ,LoanApplicationStatus    = 'N/A'
           ,MilestoneStatusName      = 'N/A'
           ,MilestoneStatusSort      = -1
           ,LoanApplicationSource    = 'BCF'
           ,PayoutAmount             = ISNULL(IIF(dul.UcapLkpValue = 'PoSentLetter', fplam.GrantedAmount, 0), 0)
           ,NoOfPayout               = ISNULL(IIF(dul.UcapLkpValue = 'PoSentLetter', 1, 0), 0)
           ,ApplicationAmount        = fplam.GrantedAmount
           ,NoOfApplication          = IIF(dul.UcapLkpValue IN ( 'PoSentLetter', 'Declined' ), 0, 1)
           ,NoOfDeclined             = IIF(dul.UcapLkpValue = 'Declined', 1, 0)
           ,Interest                 = 0
           ,BaseRate                 = 0
           ,InterestMargin           = 0
           ,ManualInterestMargin     = 0
           ,RiskInterestRate         = 0
           ,InterestRateTotal        = 0
           ,ApplicationDurationDay   = DATEDIFF(DAY, fplam.SysSrcGenerationDateTime, fplam.Calendar_bkey)
           ,PayoutAmountB            = 0
           ,NoOfPayoutB              = 0
           ,Scenario                 = 'A'
           ,LoanApplication_bkey     = CAST(fplam.PLLoanApplicationMetrics_key + '#PL' AS NVARCHAR(100))
           ,CurrentPeriod_key        = CASE WHEN CONVERT(NVARCHAR(6), fplam.Calendar_bkey, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, -1, GETDATE()), 112) THEN 1
                                            WHEN CONVERT(NVARCHAR(6), fplam.Calendar_bkey, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 0, GETDATE()), 112) THEN 2
                                            WHEN CONVERT(NVARCHAR(6), fplam.Calendar_bkey, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 1, GETDATE()), 112) THEN 3 ELSE -1 END
           ,IsPreAppLoanPromise      = 0
           ,AgingApplicationToPayout = 'N/A'
FROM        Fact.f_PLLoanApplicationMetrics fplam
INNER JOIN  Fact.d_UcapLkp                  dul ON dul.UcapLkp_key = fplam.UcapLkp_DWHPositionStatus_key
UNION ALL
SELECT  LoanApplication_key      = '-1#ML'
       ,Calendar_Contact_key     = CAST(fps.Calendar_Period_key AS DATE)
       ,Calendar_Milestone_key   = CAST(fps.Calendar_Period_key AS DATE)
       ,FinanceSegment_key       = fps.FinanceSegment_key
       ,LoanApplicationStatus    = 'N/A'
       ,MilestoneStatusName      = 'N/A'
       ,MilestoneStatusSort      = -1
       ,LoanApplicationSource    = 'BCF'
       ,PayoutAmount             = 0
       ,NoOfPayout               = 0
       ,ApplicationAmount        = 0
       ,NoOfApplication          = 0
       ,NoOfDeclined             = 0
       ,Interest                 = 0
       ,BaseRate                 = 0
       ,InterestMargin           = 0
       ,ManualInterestMargin     = 0
       ,RiskInterestRate         = 0
       ,InterestRateTotal        = 0
       ,ApplicationDurationDay   = 0
       ,PayoutAmountB            = IIF(fps.PlanningMetricCode = 'PayoutAmount', fps.PlanningAmount, 0)
       ,NoOfPayoutB              = IIF(fps.PlanningMetricCode = 'NrPayoutLoans', fps.PlanningAmount, 0)
       ,Scenario                 = RIGHT(fps.PlanningScenarioCode, 1)
       ,LoanApplication_key      = '-1#ML'
       ,CurrentPeriod_key        = CASE WHEN CONVERT(NVARCHAR(6), fps.Calendar_Period_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, -1, GETDATE()), 112) THEN 1
                                        WHEN CONVERT(NVARCHAR(6), fps.Calendar_Period_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 0, GETDATE()), 112) THEN 2
                                        WHEN CONVERT(NVARCHAR(6), fps.Calendar_Period_key, 112) = CONVERT(NVARCHAR(6), DATEADD(MONTH, 1, GETDATE()), 112) THEN 3 ELSE -1 END
       ,IsPreAppLoanPromise      = 0
       ,AgingApplicationToPayout = 'N/A'
FROM    Fact.f_PlanningSales fps
GO
