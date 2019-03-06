CREATE VIEW Fact.f_GeneralLedgerAllocation
AS
WITH AllocationValues AS (
	SELECT ngla.AllocationPrinciple_bkey
			,t.GLAccount_bkey
			,t.LegalEntity_bkey
			,t.Calender_ReportingPeriod_bkey
			,t.CostCenter_bkey
			,t.Project_bkey
			,t.FinanceProduct_bkey
			,t.FinanceAnalysis_bkey
			,t.FinanceCounterparty_bkey
			,FinanceSegment_From_bkey    = t.FinanceSegment_bkey
			,FinanceSegment_To_bkey      = CAST(FinanceSegment_To_bkey + '#' + t.LegalEntity_bkey AS NVARCHAR(100))
			,t.FinanceCustomer_bkey
			,t.FinanceVendor_bkey
			,t.Currency_bkey
			,AmountLCY                   = t.AmountLCY * ngla.AllocationPercent
			,AmountTCY                   = t.AmountTCY * ngla.AllocationPercent
			,ngla.GLAccountLegalEntity_bkey
	FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY ngla.GeneralLedgerAllocation_bkey ORDER BY ngla.SysValidFromDateTime DESC) FROM Norm.n_GeneralLedgerAllocation ngla) ngla
	INNER JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY ngl.GeneralLedger_bkey ORDER BY ngl.SysValidFromDateTime DESC) FROM Norm.n_GeneralLedger ngl WHERE (ngl.FinanceSegment_bkey Like ('1#%') or ngl.FinanceSegment_bkey Like ('-1')) AND ngl.GLAccount_bkey <> '-1') t 
		ON ngla.GLAccount_From_bkey = t.GLAccount_bkey AND ngla.LegalEntity_From_bkey = t.LegalEntity_bkey AND t.Calender_ReportingPeriod_bkey = ngla.Calender_From_bkey AND t.FinanceVendor_bkey LIKE ngla.FinanceVendor_From_bkey	AND t._isFirst = 1
	WHERE  ngla._isFirst = 1
	), CounterAllocation AS (
SELECT    av1.AllocationPrinciple_bkey
         ,av1.GLAccount_bkey
         ,av1.LegalEntity_bkey
         ,av1.Calender_ReportingPeriod_bkey
         ,av1.CostCenter_bkey
         ,av1.Project_bkey
         ,av1.FinanceProduct_bkey
         ,av1.FinanceAnalysis_bkey
         ,av1.FinanceCounterparty_bkey
         ,FinanceSegment_bkey = av1.FinanceSegment_To_bkey
         ,av1.FinanceCustomer_bkey
         ,av1.FinanceVendor_bkey
         ,av1.Currency_bkey
         ,av1.GLAccountLegalEntity_bkey
         ,AmountLCY           = SUM(av1.AmountLCY)
         ,AmountTCY           = SUM(av1.AmountTCY)
FROM      AllocationValues av1
GROUP BY  av1.AllocationPrinciple_bkey
         ,av1.GLAccount_bkey
         ,av1.LegalEntity_bkey
         ,av1.Calender_ReportingPeriod_bkey
         ,av1.CostCenter_bkey
         ,av1.Project_bkey
         ,av1.FinanceProduct_bkey
         ,av1.FinanceAnalysis_bkey
         ,av1.FinanceCounterparty_bkey
         ,av1.FinanceSegment_To_bkey
         ,av1.FinanceCustomer_bkey
         ,av1.FinanceVendor_bkey
         ,av1.Currency_bkey
         ,av1.GLAccountLegalEntity_bkey
UNION ALL
-- Counter Allocation
SELECT    AllocationPrinciple_bkey = -99
         ,av1.GLAccount_bkey
         ,av1.LegalEntity_bkey
         ,av1.Calender_ReportingPeriod_bkey
         ,av1.CostCenter_bkey
         ,av1.Project_bkey
         ,av1.FinanceProduct_bkey
         ,av1.FinanceAnalysis_bkey
         ,av1.FinanceCounterparty_bkey
         ,FinanceSegment_bkey      = av1.FinanceSegment_From_bkey
         ,av1.FinanceCustomer_bkey
         ,av1.FinanceVendor_bkey
         ,av1.Currency_bkey
		 ,av1.GLAccountLegalEntity_bkey
         ,AmountLCY                = -SUM(av1.AmountLCY)
         ,AmountTCY                = -SUM(av1.AmountTCY)         
FROM      AllocationValues av1
GROUP BY  av1.GLAccount_bkey
         ,av1.LegalEntity_bkey
         ,av1.Calender_ReportingPeriod_bkey
         ,av1.CostCenter_bkey
         ,av1.Project_bkey
         ,av1.FinanceProduct_bkey
         ,av1.FinanceAnalysis_bkey
         ,av1.FinanceCounterparty_bkey
         ,av1.FinanceSegment_From_bkey
         ,av1.FinanceCustomer_bkey
         ,av1.FinanceVendor_bkey
         ,av1.Currency_bkey
         ,av1.GLAccountLegalEntity_bkey
)
SELECT   SysValidFromDateTime     = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
       ,SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
       ,SysSrcGenerationDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
	   ,GeneralLedgerAllocation_key = CAST(NEWID() AS NVARCHAR(50))
	   ,ngl.AllocationPrinciple_bkey
       ,ngl.GLAccount_bkey
       ,ngl.LegalEntity_bkey
       ,ngl.Calender_ReportingPeriod_bkey
       ,ngl.CostCenter_bkey
       ,ngl.Project_bkey
       ,ngl.FinanceProduct_bkey
       ,ngl.FinanceAnalysis_bkey
       ,ngl.FinanceCounterparty_bkey
       ,ngl.FinanceSegment_bkey
       ,ngl.FinanceCustomer_bkey
       ,ngl.FinanceVendor_bkey
       ,nga.GLAccount_key
       ,nle.LegalEntity_key
       ,ncc.CostCenter_key
       ,np.Project_key
       ,nfp.FinanceProduct_key
       ,nfa.FinanceAnalysis_key
       ,nfc.FinanceCounterparty_key
       ,nfs.FinanceSegment_key
       ,nfc2.FinanceCustomer_key
       ,nfv.FinanceVendor_key
       ,nc.Currency_key
       ,nap.AllocationPrinciple_key
       ,ngl.AmountLCY
       ,ngl.AmountTCY
       ,ngale.GLAccountLegalEntity_key
FROM    CounterAllocation ngl
OUTER APPLY (SELECT TOP 1 nga.GLAccount_key FROM Norm.n_GLAccount nga WHERE nga.GLAccount_bkey = ngl.GLAccount_bkey ORDER BY nga.SysValidFromDateTime DESC) nga
OUTER APPLY (SELECT TOP 1 nle.LegalEntity_key FROM Norm.n_LegalEntity nle WHERE nle.LegalEntity_bkey = ngl.LegalEntity_bkey ORDER BY nle.SysValidFromDateTime DESC) nle
OUTER APPLY (SELECT TOP 1 ncc.CostCenter_key FROM Norm.n_CostCenter ncc WHERE ncc.CostCenter_bkey = ngl.CostCenter_bkey ORDER BY ncc.SysValidFromDateTime DESC) ncc
OUTER APPLY (SELECT TOP 1 np.Project_key FROM Norm.n_Project np WHERE np.Project_bkey = ngl.Project_bkey ORDER BY np.SysValidFromDateTime DESC) np
OUTER APPLY (SELECT TOP 1 nfp.FinanceProduct_key FROM Norm.n_FinanceProduct nfp WHERE nfp.FinanceProduct_bkey = ngl.FinanceProduct_bkey ORDER BY nfp.SysValidFromDateTime DESC) nfp
OUTER APPLY (SELECT TOP 1 nfa.FinanceAnalysis_key FROM Norm.n_FinanceAnalysis nfa WHERE nfa.FinanceAnalysis_bkey = ngl.FinanceAnalysis_bkey ORDER BY nfa.SysValidFromDateTime DESC) nfa
OUTER APPLY (SELECT TOP 1 nfc.FinanceCounterparty_key FROM Norm.n_FinanceCounterparty nfc WHERE nfc.FinanceCounterparty_bkey = ngl.FinanceCounterparty_bkey ORDER BY nfc.SysValidFromDateTime DESC) nfc
OUTER APPLY (SELECT TOP 1 nfs.FinanceSegment_key FROM Norm.n_FinanceSegment nfs WHERE nfs.FinanceSegment_bkey = ngl.FinanceSegment_bkey ORDER BY nfs.SysValidFromDateTime DESC) nfs
OUTER APPLY (SELECT TOP 1 nfc2.FinanceCustomer_key FROM Norm.n_FinanceCustomer nfc2 WHERE nfc2.FinanceCustomer_bkey = ngl.FinanceCustomer_bkey ORDER BY nfc2.SysValidFromDateTime DESC) nfc2
OUTER APPLY (SELECT TOP 1 nfv.FinanceVendor_key FROM Norm.n_FinanceVendor nfv WHERE nfv.FinanceVendor_bkey = ngl.FinanceVendor_bkey ORDER BY nfv.SysValidFromDateTime DESC) nfv
OUTER APPLY (SELECT TOP 1 nc.Currency_key FROM Norm.n_Currency nc WHERE nc.Currency_bkey = ngl.Currency_bkey ORDER BY nc.SysValidFromDateTime DESC) nc
OUTER APPLY (SELECT TOP 1 nap.AllocationPrinciple_key FROM Norm.n_AllocationPrinciple nap WHERE nap.AllocationPrinciple_bkey = ngl.AllocationPrinciple_bkey ORDER BY nap.SysValidFromDateTime DESC) nap
OUTER APPLY (SELECT TOP 1 ngale.GLAccountLegalEntity_key FROM Norm.n_GLAccountLegalEntity ngale WHERE ngale.GLAccountLegalEntity_bkey = ngl.GLAccountLegalEntity_bkey ORDER BY ngale.SysValidFromDateTime DESC) ngale