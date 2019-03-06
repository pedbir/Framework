CREATE VIEW Fact.f_MLLoanApplicationMetrics
AS

WITH OneValuePerDay AS 
  (
	SELECT  nmlam.SysDatetimeDeletedUTC
		   ,SysModifiedUTC                    = MAX(nmlam.SysModifiedUTC) OVER (PARTITION BY nmlam.MLLoanApplication_bkey)
		   ,nmlam.SysValidFromDateTime
		   ,nmlam.SysSrcGenerationDateTime
		   ,nmla.MLLoanApplication_key
		   ,nmlam.MilestoneDate
		   ,nmla.ExportedToCerdoDate
		   ,nmlam.MLLoanApplication_bkey
		   ,nmlam.ApplicationNumber
		   ,Calendar_MilestoneStart_key       = CAST(nmlam.Calendar_Milestone_bkey AS DATE)
		   ,Calendar_MilestoneEnd_key         = CAST(LEAD(nmlam.Calendar_Milestone_bkey, 1, IIF(nmlam.IsPayout + nmlam.IsPreAppLoanPromise + nmlam.IsDeclined > 0 OR (DATEDIFF(DAY, nmlam.Calendar_Milestone_bkey, GETUTCDATE()) > 120), nmlam.Calendar_Milestone_bkey, GETUTCDATE())) OVER (PARTITION BY nmlam.MLLoanApplication_bkey ORDER BY nmlam.MilestoneDate) AS DATE)
		   ,Calendar_Contact_key              = CAST(nmlam.Calendar_Contact_bkey AS DATE)
		   ,Calendar_ExportedToCerdoDate_bkey = CAST(nmla.Calendar_ExportedToCerdoDate_bkey AS DATE)
		   ,nmlam.MLLoanApplicationStatus
		   ,nfs.FinanceSegment_key
		   ,MilestoneStatusName               = CAST(t.MilestoneStatusName AS NVARCHAR(100))
		   ,nmlam.LoanApplicationSource
		   ,PayoutAmount                      = ISNULL(CAST(nmlam.IsPayout * nmla.Amount AS MONEY), 0)
		   ,ApplicationAmount                 = ISNULL(CAST(nmla.Amount AS MONEY), 0)
		   ,Interest                          = ISNULL(nmla.Interest, 0)
		   ,BaseRate                          = ISNULL(nmla.BaseRate, 0)
		   ,InterestMargin                    = ISNULL(nmla.InterestMargin, 0)
		   ,ManualInterestMargin              = ISNULL(nmla.ManualInterestMargin, 0)
		   ,RiskInterestRate                  = ISNULL(nmla.RiskInterestRate, 0)
		   ,InterestRateTotal                 = ISNULL(nmla.InterestRateTotal, 0)
		   ,nmlam.IsPayout
		   ,IsDeclined						  = IIF(nmlam1.MLLoanApplication_bkey IS NOT NULL, 1, 0)
		   ,nmlam.IsPreAppLoanPromise
		   ,_isFirst                          = ROW_NUMBER() OVER (PARTITION BY nmla.MLLoanApplication_bkey, nmlam.Calendar_Milestone_bkey, t.MilestoneStatusName ORDER BY nmlam.MilestoneDate DESC)
	FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmlam.MLLoanApplicationMilestone_bkey ORDER BY nmlam.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplicationMilestone nmlam) nmlam  
	LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nmla.MLLoanApplication_bkey ORDER BY nmla.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplication nmla) nmla ON nmlam.MLLoanApplication_bkey = nmla.MLLoanApplication_bkey AND nmla._isFirst = 1
	LEFT JOIN (SELECT nfs.FinanceSegment_bkey, nfs.FinanceSegment_key, _isFirst = ROW_NUMBER() OVER (PARTITION BY nfs.FinanceSegment_bkey ORDER BY nfs.SysValidFromDateTime DESC) FROM Norm.n_FinanceSegment nfs) nfs ON nmlam.FinanceSegment_bkey = nfs.FinanceSegment_bkey AND nfs._isFirst = 1
	LEFT JOIN (SELECT ncse.CustomerSupportEmployee_key, CustomerSupportEmployee_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY ncse.CustomerSupportEmployee_bkey ORDER BY ncse.SysValidFromDateTime DESC) FROM Norm.n_CustomerSupportEmployee ncse ) ncse ON ncse.CustomerSupportEmployee_bkey = nmlam.CustomerSupportEmployee_bkey AND ncse._isFirst = 1
	LEFT JOIN (SELECT nmlam.MLLoanApplication_bkey, SysValidFromDateTime = MAX(nmlam.SysValidFromDateTime) FROM Norm.n_MLLoanApplicationMilestone nmlam WHERE nmlam.IsDeclined = 1 GROUP BY nmlam.MLLoanApplication_bkey) nmlam1 ON nmlam.MLLoanApplication_bkey = nmlam1.MLLoanApplication_bkey AND nmlam.SysValidFromDateTime = nmlam1.SysValidFromDateTime
	OUTER APPLY (SELECT MilestoneStatusName = CASE WHEN nmlam.IsPayout = 1 THEN '50-Payout' WHEN nmlam.IsApplication = 1 THEN '40-Application' WHEN nmlam.IsQLead = 1 THEN '30-QLead' WHEN nmlam.IsLead = 1 THEN '20-Lead' WHEN nmlam.IsContact = 1 THEN '10-Contact' ELSE 'N/A' END) t
	WHERE nmlam._isFirst = 1 AND (nmlam.IsPayout + nmlam.IsApplication + nmlam.IsContact + nmlam.IsPreAppLoanPromise + nmlam.IsQLead) > 0
	)
SELECT  t.SysDatetimeDeletedUTC
       ,t.SysModifiedUTC
       ,SysValidFromDateTime         = CAST(t.MilestoneDate AS DATETIME2(0))
       ,t.SysSrcGenerationDateTime
       ,MLLoanApplicationMetrics_key = CAST(t.MLLoanApplication_bkey + '#' + CONVERT(NVARCHAR(8), t.MilestoneDate, 112) + '#' + t.MilestoneStatusName AS NVARCHAR(100))
       ,t.MLLoanApplication_key
       ,t.MilestoneDate
       ,t.ExportedToCerdoDate
       ,t.MLLoanApplication_bkey
       ,t.ApplicationNumber
       ,t.Calendar_MilestoneStart_key
       ,Calendar_MilestoneEnd_key    = CASE WHEN t.IsPayout + t.IsDeclined > 0 THEN t.Calendar_MilestoneStart_key
                                            WHEN t.Calendar_MilestoneStart_key > DATEADD(DAY, -1, t.Calendar_MilestoneEnd_key) THEN t.Calendar_MilestoneStart_key ELSE DATEADD(DAY, -1, t.Calendar_MilestoneEnd_key) END
       ,t.Calendar_Contact_key
       ,t.Calendar_ExportedToCerdoDate_bkey
       ,t.MLLoanApplicationStatus
       ,t.FinanceSegment_key
       ,t.MilestoneStatusName
       ,t.LoanApplicationSource
       ,t.PayoutAmount
       ,ApplicationAmount            = t.ApplicationAmount * LAG(0, 1, 1) OVER (PARTITION BY t.MLLoanApplication_bkey, t.MilestoneStatusName ORDER BY t.MilestoneDate)
       ,NoOfPayout                   = CASE WHEN t.IsPayout = 1 THEN 1 ELSE 0 END
       ,NoOfDeclined                 = t.IsDeclined
       ,NoOfApplication              = LAG(0, 1, 1) OVER (PARTITION BY t.MLLoanApplication_bkey, t.MilestoneStatusName ORDER BY t.MilestoneDate)
       ,t.Interest
       ,t.BaseRate
       ,t.InterestMargin
       ,t.ManualInterestMargin
       ,t.RiskInterestRate
       ,t.InterestRateTotal
       ,t.IsPreAppLoanPromise
FROM    OneValuePerDay t
WHERE   t._isFirst = 1