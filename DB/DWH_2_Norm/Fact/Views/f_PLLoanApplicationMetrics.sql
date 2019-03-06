CREATE VIEW Fact.f_PLLoanApplicationMetrics
AS

SELECT  npla.SysDatetimeDeletedUTC
       ,npla.SysModifiedUTC
       ,npla.SysValidFromDateTime
       ,npla.SysSrcGenerationDateTime
       ,PLLoanApplicationMetrics_key        = npla.ApplicationSourceId
       ,ApplicationNumber                   = npla.ApplicationSourceId
       ,npla.ApplicationId
       ,Calendar_bkey                       = CAST(npla.SysSrcGenerationDateTime AS DATE)
       ,UcapLkp_LatestS1Decision_key        = u1.UcapLkp_key
       ,UcapLkp_CurrentDecision_key         = u2.UcapLkp_key
       ,UcapLkp_SelectedProduct_key         = u3.UcapLkp_key
       ,UcapLkp_RegistrationChannelType_key = u4.UcapLkp_key
       ,UcapLkp_RepaymentPeriodCategory_key = u5.UcapLkp_key
       ,UcapLkp_LoanPurposeType_key         = u6.UcapLkp_key
       ,UcapLkp_MediaChannelType_key        = u7.UcapLkp_key
       ,UcapLkp_DWHPosition_key             = u8.UcapLkp_key
       ,UcapLkp_DWHPositionStatus_key       = u9.UcapLkp_key
	   ,nfs.FinanceSegment_bkey
	   ,nfs.FinanceSegment_key
       ,npla.AppliedAmount
       ,npla.GrantedAmount
FROM    Norm.n_PLLoanApplication npla
INNER JOIN (SELECT npla.PLLoanApplication_bkey, npla.SysValidFromDateTime, _isFirst = LAG(0,1,1) OVER (PARTITION BY npla.ApplicationSourceId ORDER BY npla.SysValidFromDateTime DESC) FROM Norm.n_PLLoanApplication npla) npla1 ON npla.PLLoanApplication_bkey = npla1.PLLoanApplication_bkey AND npla.SysValidFromDateTime = npla1.SysValidFromDateTime AND npla1._isFirst = 1
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_LatestS1Decision_bkey ORDER BY nul.SysValidFromDateTime DESC) u1
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_CurrentDecision_bkey ORDER BY nul.SysValidFromDateTime DESC) u2
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_SelectedProduct_bkey ORDER BY nul.SysValidFromDateTime DESC) u3
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_RegistrationChannelType_bkey ORDER BY nul.SysValidFromDateTime DESC) u4
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_RepaymentPeriodCategory_bkey ORDER BY nul.SysValidFromDateTime DESC) u5
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_LoanPurposeType ORDER BY nul.SysValidFromDateTime DESC) u6
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_MediaChannelType_bkey ORDER BY nul.SysValidFromDateTime DESC) u7
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_DWHPosition_bkey ORDER BY nul.SysValidFromDateTime DESC) u8
OUTER APPLY (SELECT TOP 1 nul.UcapLkp_key FROM Norm.n_UcapLkp nul WHERE nul.UcapLkp_bkey = UcapLkp_DWHPositionStatus_bkey ORDER BY nul.SysValidFromDateTime DESC) u9
OUTER APPLY (SELECT TOP 1 nfs.FinanceSegment_bkey, nfs.FinanceSegment_key FROM Norm.n_FinanceSegment nfs WHERE nfs.FinanceSegment_bkey = '3#BFAB' ORDER BY nfs.SysValidFromDateTime DESC) nfs
WHERE npla.PLLoanApplication_bkey <> -1