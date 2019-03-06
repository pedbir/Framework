
CREATE VIEW [Fact].[d_MLLoanApplication]
AS
WITH CSE AS
  (
  SELECT    ncse.CustomerSupportEmployee_key
           ,nmlae.CustomerSupportEmployee_bkey
           ,nmlae.EmployeeRole
           ,nmlae.MLLoanApplication_bkey
           ,SysModifiedUTC = MAX(nmlae.SysModifiedUTC) OVER (PARTITION BY nmlae.MLLoanApplication_bkey)
  FROM      ( SELECT  nmlae.SysModifiedUTC
                     ,nmlae.CustomerSupportEmployee_bkey
                     ,nmlae.EmployeeRole
                     ,nmlae.MLLoanApplication_bkey
                     ,_isFirst = ROW_NUMBER() OVER (PARTITION BY nmlae.MLLoanApplication_bkey, nmlae.EmployeeRole ORDER BY nmlae.SysValidFromDateTime DESC)
              FROM    Norm.n_MLLoanApplicationEmployee nmlae) nmlae
  LEFT JOIN ( SELECT  ncse.CustomerSupportEmployee_key
                     ,ncse.CustomerSupportEmployee_bkey
                     ,_isFirst = ROW_NUMBER() OVER (PARTITION BY ncse.CustomerSupportEmployee_bkey ORDER BY ncse.SysValidFromDateTime DESC)
              FROM    Norm.n_CustomerSupportEmployee ncse)       ncse ON nmlae.CustomerSupportEmployee_bkey = ncse.CustomerSupportEmployee_bkey
                                                                         AND ncse._isFirst                  = 1
  WHERE     nmlae._isFirst = 1
  )
    ,Customer AS
  (
  SELECT    nmlc.MLLoanCustomer_key
           ,nmlac.MLLoanCustomer_bkey
           ,nmlac.IsMainApplicant
           ,nmlac.MLLoanApplication_bkey
  --,SysModifiedUTC = MAX(nmlac.SysModifiedUTC) OVER (PARTITION BY nmlac.MLLoanApplication_bkey)
  FROM      ( SELECT  nmlac.SysModifiedUTC
                     ,nmlac.MLLoanCustomer_bkey
                     ,nmlac.IsMainApplicant
                     ,nmlac.MLLoanApplication_bkey
                     ,_isFirst = ROW_NUMBER() OVER (PARTITION BY nmlac.MLLoanApplication_bkey, nmlac.IsMainApplicant ORDER BY nmlac.SysValidFromDateTime DESC)
              FROM    Norm.n_MLLoanApplicationCustomer nmlac) nmlac
  LEFT JOIN ( SELECT  nmlc.MLLoanCustomer_key
                     ,nmlc.MLLoanCustomer_bkey
                     ,_isFirst = ROW_NUMBER() OVER (PARTITION BY nmlc.MLLoanCustomer_bkey ORDER BY nmlc.SysValidFromDateTime DESC)
              FROM    Norm.n_MLLoanCustomer nmlc)                nmlc ON nmlc.MLLoanCustomer_bkey = nmlac.MLLoanCustomer_bkey
                                                                         AND nmlc._isFirst        = 1
  WHERE     nmlac._isFirst = 1
  )
SELECT      MLLoanApplication_key              = nla.MLLoanApplication_key
           ,SysDatetimeDeletedUTC              = nla1.SysDatetimeDeletedUTC
           ,SysModifiedUTC                     = nla1.SysModifiedUTC
           ,SysIsInferred                      = nla.SysIsInferred
           ,SysValidFromDateTime               = nla.SysValidFromDateTime
           ,SysSrcGenerationDateTime           = nla.SysSrcGenerationDateTime
           ,MLLoanApplication_bkey             = nla.MLLoanApplication_bkey
           ,ApplicationNumber                  = nla1.ApplicationNumber
           ,ApplicationLoanObjectId            = ISNULL(nla1.ApplicationLoanObjectId, '-1')
           ,ApplicationLoanObject              = ISNULL(IIF(nla1.ApplicationLoanObject = '', 'N/A', nla1.ApplicationLoanObject), 'N/A')
           ,ApplicationPurposeId               = ISNULL(nla1.ApplicationPurposeId, '-1')
           ,ApplicationPurpose                 = ISNULL(nla1.ApplicationPurpose, 'N/A')
           ,ApplicationRefusalId               = ISNULL(nla1.ApplicationRefusalId, '-1')
           ,ApplicationRefusal                 = ISNULL(nla1.ApplicationRefusal, 'N/A')
           ,FinanceSegment_bkey                = ISNULL(nla1.FinanceSegment_bkey, '-1')
           ,ContactWayId                       = ISNULL(nla1.ContactWayId, '-1')
           ,ContactWay                         = ISNULL(nla1.ContactWay, 'N/A')
           ,MediaCode                          = ISNULL(nla.MediaCode, '-1')
           ,Media                              = ISNULL(nla.Media, 'N/A')
           ,MediaCategoryCode                  = ISNULL(nla.MediaCategoryCode, '-1')
           ,MediaCategoryName                  = ISNULL(nla.MediaCategoryName, 'N/A')
           ,MediaTypeCode                      = ISNULL(nla.MediaTypeCode, '-1')
           ,MediaType                          = ISNULL(nla.MediaType, 'N/A')
           ,InterestBondCODE                   = ISNULL(nla1.InterestBondCODE, '-1')
           ,InterestBond                       = ISNULL(nla1.InterestBond, 'N/A')
           ,ApplicationLoanTypeCODE            = ISNULL(nla1.ApplicationLoanTypeCODE, '-1')
           ,ApplicationLoanType                = ISNULL(nla1.ApplicationLoanType, '-1')
           ,PriceLevel                         = ISNULL(nla1.PriceLevel, 'N/A')
           ,ExportedToCerdoDate                = nla1.ExportedToCerdoDate
           ,PaidOutDate                        = nla1.Calendar_PaidOutDate_bkey
           ,ContactDate                        = nla1.Calendar_ContactDate_bkey
           ,LoanApplicationSource              = nla.LoanApplicationSource
           ,IsDeclined                         = IIF(nla1.ApplicationRefusalId = '-1', 0, 1)
           ,IsPayoutPlanned                    = IIF(nla1.Calendar_PaidOutDate_bkey IS NULL, 0, 1)
           ,CustomerSupportEmployee_CS_key     = IIF(nla.LoanApplicationSource = 'BAMS', COALESCE(cs.CustomerSupportEmployee_key, ncse.CustomerSupportEmployee_key, -1), -1)
           ,CustomerSupportEmployee_CSG_key    = COALESCE(Scr.CustomerSupportEmployee_key, ncse.CustomerSupportEmployee_key, -1)
           ,CustomerSupportEmployee_Credit_key = COALESCE(cre.CustomerSupportEmployee_key, -1)
           ,CampaignCODE                       = ISNULL(nla1.CampaignCODE, '-1')
           ,CampaignName                       = ISNULL(nla1.CampaignName, 'N/A')
           ,CustomerMainApplicant_key          = ISNULL(mainApplicant.MLLoanCustomer_key, -1)
           ,CustomerCoApplicant_key            = ISNULL(coApplicant.MLLoanCustomer_key, -1)
FROM        Norm.n_MLLoanApplication                   nla
LEFT JOIN ( SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nla1.MLLoanApplication_bkey ORDER BY nla1.SysValidFromDateTime DESC) FROM Norm.n_MLLoanApplication nla1) nla1 ON nla1.MLLoanApplication_bkey = nla.MLLoanApplication_bkey AND nla1._isFirst = 1
LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY nfs.FinanceSegment_bkey ORDER BY nfs.SysValidFromDateTime DESC) FROM Norm.n_FinanceSegment nfs ) nfs ON nla.FinanceSegment_bkey = nfs.FinanceSegment_bkey AND nfs._isFirst = 1
LEFT JOIN   CSE                                         cs ON nla1.MLLoanApplication_bkey                  = cs.MLLoanApplication_bkey
                                                              AND cs.EmployeeRole                          = 'Customer Service'
LEFT JOIN   CSE                                         Scr ON nla1.MLLoanApplication_bkey                 = Scr.MLLoanApplication_bkey
                                                               AND Scr.EmployeeRole                        = 'Screening'
LEFT JOIN   CSE                                         cre ON nla1.MLLoanApplication_bkey                 = cre.MLLoanApplication_bkey
                                                               AND cre.EmployeeRole                        = 'Credit'
LEFT JOIN   ( SELECT  ncse.CustomerSupportEmployee_bkey
                     ,ncse.CustomerSupportEmployee_key
                     ,_isFirst = ROW_NUMBER() OVER (PARTITION BY ncse.CustomerSupportEmployee_bkey ORDER BY ncse.SysValidFromDateTime DESC)
              FROM    Norm.n_CustomerSupportEmployee ncse) ncse ON nla1.CustomerSupportEmployee_bkey          = ncse.CustomerSupportEmployee_bkey
                                                                   AND ncse._isFirst                          = 1
LEFT JOIN   Customer                                    mainApplicant ON nla1.MLLoanApplication_bkey       = mainApplicant.MLLoanApplication_bkey
                                                                         AND mainApplicant.IsMainApplicant = 1
LEFT JOIN   Customer                                    coApplicant ON nla1.MLLoanApplication_bkey         = coApplicant.MLLoanApplication_bkey
                                                                       AND coApplicant.IsMainApplicant     = 0