
CREATE VIEW Fact.f_GeneralLedger
AS
SELECT  ngl.SysDatetimeDeletedUTC
       ,ngl.SysModifiedUTC
       ,ngl.SysSrcGenerationDateTime
       ,ngl.SysValidFromDateTime
       ,GeneralLedger_key = ngl.GeneralLedger_bkey
       ,ngl.Vouchertype
       ,ngl.Voucherno
       ,ngl.Sequenceno
       ,ngl.GLDescription
       ,ngl.ExtInvoiceRef
       ,ngl.GLAccount_bkey
       ,ngl.LegalEntity_bkey
       ,ngl.Calender_Voucherdate_bkey
       ,ngl.Calender_ReportingPeriod_bkey
       ,ngl.CostCenter_bkey
       ,ngl.Project_bkey
       ,ngl.FinanceProduct_bkey
       ,ngl.FinanceAnalysis_bkey
       ,ngl.FinanceCounterparty_bkey
       ,ngl.FinanceSegment_bkey
       ,ngl.FinanceCustomer_bkey
       ,ngl.FinanceVendor_bkey
       ,ngl.Currency_bkey
       ,ngl.GLAccountLegalEntity_bkey
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
       ,ngale.GLAccountLegalEntity_key
       ,nc.Currency_key
       ,ngl.AmountLCY
       ,ngl.AmountTCY
       ,nap.AllocationPrinciple_key
FROM    ( SELECT  *,_isFirst = LAG(0, 1, 1) OVER (PARTITION BY ngl.GeneralLedger_bkey ORDER BY ngl.SysValidFromDateTime DESC) FROM    Norm.n_GeneralLedger ngl) ngl
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
OUTER APPLY (SELECT TOP 1 nap.AllocationPrinciple_key FROM Norm.n_AllocationPrinciple nap WHERE nap.AllocationPrinciple_bkey = -999) nap
OUTER APPLY (SELECT TOP 1 ngale.GLAccountLegalEntity_key FROM Norm.n_GLAccountLegalEntity ngale WHERE ngale.GLAccountLegalEntity_bkey = ngl.GLAccountLegalEntity_bkey ORDER BY ngale.SysValidFromDateTime DESC) ngale
WHERE ngl._isFirst = 1