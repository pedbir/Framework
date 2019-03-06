
CREATE VIEW [Norm].[PLLoanApplication]
AS
SELECT  rpla.SysDatetimeDeletedUTC
       ,rpla.SysModifiedUTC
       ,rpla.SysValidFromDateTime
       ,rpla.SysSrcGenerationDateTime
       ,rpla.PLLoanApplication_bkey
       ,rpla.ApplicationSourceId
       ,rpla.ApplicationId
       ,Calendar_Registration_bkey           = rpla.RegistrationDate
       ,Calendar_Decision_bkey               = rpla.DecisionDate
       ,UcapLkp_LatestS1Decision_bkey        = CAST(ISNULL('LatestS1DecisionType#' + CAST(rpla.LatestS1DecisionId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_CurrentDecision_bkey         = CAST(ISNULL('CurrentDecisionType#' + CAST(rpla.CurrentDecisionId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_SelectedProduct_bkey         = CAST(ISNULL('ProductType#' + CAST(rpla.SelectedProductId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_RegistrationChannelType_bkey = CAST(ISNULL('RegistrationChannelType#' + CAST(rpla.RegistrationChannelTypeId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_RepaymentPeriodCategory_bkey = CAST(ISNULL('RepaymentPeriodCategory#' + CAST(rpla.RepaymentPeriodCategoryId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_LoanPurposeType              = CAST(ISNULL('LoanPurposeType#' + CAST(rpla.LoanPurposeTypeId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_MediaChannelType_bkey        = CAST(ISNULL('MediaChannelType#' + CAST(rpla.MediaChannelTypeId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_DWHPosition_bkey             = CAST(ISNULL('DWHPosition#' + CAST(rpla.DWHPositionId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,UcapLkp_DWHPositionStatus_bkey       = CAST(ISNULL('DWHPositionStatus#' + CAST(rpla.DWHPositionId AS NVARCHAR(50)), '-1') AS NVARCHAR(100))
       ,AppliedAmount                        = ISNULL(rpla.AppliedAmount, 0)
       ,GrantedAmount                        = ISNULL(rpla.GrantedAmount, 0)
FROM    ( SELECT  *,_isFirst = LEAD(0, 1, 1) OVER (PARTITION BY rpla.PLLoanApplication_bkey ORDER BY rpla.SysValidFromDateTime DESC) FROM    UCAP_RawTyped.r_PLLoanApplication rpla) rpla
WHERE   rpla._isFirst = 1 AND rpla.PLLoanApplication_bkey <> -1