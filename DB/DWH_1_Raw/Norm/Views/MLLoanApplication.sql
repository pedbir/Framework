CREATE VIEW Norm.MLLoanApplication
AS
SELECT  rla.SysDatetimeDeletedUTC
       ,SysModifiedUTC                    = (SELECT SysModifiedUTC = MAX(v.SysModifiedUTC) FROM (VALUES (rla.SysModifiedUTC), (rlas.SysModifiedUTC), (ola.SysModifiedUTC)) v (SysModifiedUTC) )
       ,SysValidFromDateTime              = ( SELECT  SysValidFromDateTime = DATEADD(SECOND, 1, MAX(v.SysValidFromDateTime)) FROM    ( VALUES (rla.SysValidFromDateTime) ,(rlas.SysValidFromDateTime),(ola.SysValidFromDateTime)) v (SysValidFromDateTime) )
       ,rla.SysSrcGenerationDateTime
       ,MLLoanApplication_bkey            = CAST(rla.LoanApplication_bkey + '#NO' AS NVARCHAR(100))
       ,ApplicationNumber                 = rla.ApplicationNumber
       ,Amount                            = ISNULL(rla.Amount, 0)
       ,Calendar_PaidOutDate_bkey         = CAST(CAST(rla.PaidOutDate AS DATE) AS DATETIME)
       ,Calendar_ExportedToCerdoDate_bkey = CAST(CAST(rla.ExportedToCerdoDate AS DATE) AS DATETIME)
       ,Interest                          = ISNULL(rla.Interest, 0)
       ,ApplicationLoanObjectId           = ISNULL(NULLIF(rla.ApplicationLoanObjectCODE, ''), '-1')
       ,ApplicationLoanObject             = ISNULL(NULLIF(rla.ApplicationLoanObject, ''), 'N/A')
       ,ApplicationPurposeId              = ISNULL(rla.ApplicationPurposeCODE, '-1')
       ,ApplicationPurpose                = ISNULL(rla.ApplicationPurpose, 'N/A')
       ,ApplicationRefusalId              = CASE WHEN rlas.StatusName LIKE 'Decline%' AND rlas.CompletedDate IS NULL THEN ISNULL(rla.ApplicationRefusalCODE, '-1') ELSE '-1' END
       ,ApplicationRefusal                = CASE WHEN rlas.StatusName LIKE 'Decline%' AND rlas.CompletedDate IS NULL THEN ISNULL(rla.ApplicationRefusal, 'N/A') ELSE 'N/A' END
       ,CustomerSupportEmployee_bkey      = CAST(ISNULL(rla.UpdatedByUser, '-1') + '#NO' AS NVARCHAR(100))
       ,FinanceSegment_bkey               = CAST('NO_ML' AS NVARCHAR(100))
       ,ContactWayId                      = ISNULL(rla.ContactWayCODE, '-1')
       ,ContactWay                        = ISNULL(NULLIF(rla.ContactWay, ''), 'N/A')
       ,MediaCode                         = ISNULL(rla.MediaCode, '-1')
       ,Media                             = ISNULL(NULLIF(rm.Name, ''), 'N/A')
       ,MediaCategoryCode                 = ISNULL(rm.MediaCategoryCode, '-1')
       ,MediaCategoryName                 = ISNULL(NULLIF(rm.MediaCategoryName, ''), 'N/A')
       ,MediaTypeCode                     = ISNULL(rm.MediaTypeCode, '-1')
       ,MediaType                         = ISNULL(NULLIF(rm.MediaType, ''), 'N/A')
       ,ExportedToCerdoDate               = rla.ExportedToCerdoDate
       ,BaseRate                          = ISNULL(rla.BaseRate, 0)
       ,InterestMargin                    = ISNULL(rla.InterestMargin, 0)
       ,ManualInterestMargin              = ISNULL(rla.ManualInterestMargin, 0)
       ,InterestBondCODE                  = ISNULL(rla.InterestBondCODE, 'N/A')
       ,InterestBond                      = ISNULL(rla.InterestBond, 'N/A')
       ,ApplicationLoanTypeCODE           = ISNULL(rla.ApplicationLoanTypeCODE, 'N/A')
       ,ApplicationLoanType               = ISNULL(rla.ApplicationLoanType, 'N/A')
       ,PriceLevel                        = CAST(ISNULL(rc.PriceLevelText, 'N/A') AS NVARCHAR(50))
       ,Calendar_ContactDate_bkey         = CAST(CAST(ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,LoanApplicationSource             = CAST('BAMS' AS NVARCHAR(100))
       ,RiskInterestRate                  = ISNULL(rla.RiskInterestRate, 0)
       ,RiskInterestDuration              = ISNULL(rla.RiskInterestDuration, 0)
       ,RiskInterestAmount                = ISNULL(rla.RiskInterestAmount, 0)
       ,InterestRateTotal                 = ISNULL(rla.InterestRateTotal, 0)
       ,LockRiskInterestRate              = ISNULL(rla.LockRiskInterestRate, 0)
       ,CampaignCODE                      = ISNULL(rla.CampaignCODE, '-1')
       ,CampaignName                      = ISNULL(rla.CampaignName, 'N/A')
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.LoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_LoanApplication rla) rla
LEFT JOIN (SELECT ola.OpocLoanApplication_bkey, ola.SysValidFromDateTime, ola.SysSrcGenerationDateTime, ola.SysModifiedUTC, _isFirst = ROW_NUMBER() OVER (PARTITION BY ola.OpocLoanApplication_bkey ORDER BY ola.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_OpocLoanApplication ola) ola ON ola.OpocLoanApplication_bkey = rla.LoanApplication_bkey  AND ola._isFirst = 1
LEFT JOIN (SELECT rlas.StatusName, rlas.CompletedDate, rlas.SysModifiedUTC, rlas.ApplicationId, rlas.SysValidFromDateTime, _isFirst = ROW_NUMBER() OVER (PARTITION BY rlas.ApplicationId ORDER BY rlas.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_LoanApplicationStatus rlas) rlas ON rlas.ApplicationId = rla.LoanApplication_bkey AND rlas._isFirst = 1
LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rm.Media_bkey ORDER BY rm.SysValidFromDateTime) FROM BamsNo_RawTyped.r_Media rm) rm ON rm.Media_bkey = rla.MediaCode AND rm._isFirst = 1
LEFT JOIN (SELECT rac.ApplicationId, rac.CustomerId, _isFirst = ROW_NUMBER() OVER (PARTITION BY rac.ApplicationId ORDER BY rac.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_ApplicationCustomer rac WHERE rac.IsMainApplicant = 1) rac ON rla.LoanApplication_bkey = rac.ApplicationId AND rac._isFirst = 1
LEFT JOIN (SELECT rc.PriceLevelText, Customer_bkey, _isLast = ROW_NUMBER() OVER (PARTITION BY rc.Customer_bkey ORDER BY rc.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_Customer rc ) rc ON rc.Customer_bkey = rac.CustomerId AND rc._isLast = 1
WHERE   rla.LoanApplication_bkey <> '-1' AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31' AND rla._isFirst = 1
UNION ALL
SELECT  rla.SysDatetimeDeletedUTC
       ,SysModifiedUTC                    = (SELECT MAX(v.SysModifiedUTC) AS SysModifiedUTC FROM (VALUES (rla.SysModifiedUTC), (rlas.SysModifiedUTC), (ola.SysModifiedUTC)) AS v(SysModifiedUTC)) 
       ,SysValidFromDateTime              = (SELECT DATEADD(SECOND, 1, MAX(v.SysValidFromDateTime)) AS SysValidFromDateTime FROM (VALUES (rla.SysValidFromDateTime), (rlas.SysValidFromDateTime), (ola.SysValidFromDateTime)) AS v(SysValidFromDateTime)) 
       ,rla.SysSrcGenerationDateTime
       ,MLLoanApplication_bkey            = CAST(rla.LoanApplication_bkey + '#SE' AS NVARCHAR(100))
       ,ApplicationNumber                 = rla.ApplicationNumber
       ,Amount                            = ISNULL(rla.Amount, 0)
       ,Calendar_PaidOutDate_bkey         = CAST(CAST(rla.PaidOutDate AS DATE) AS DATETIME)
       ,Calendar_ExportedToCerdoDate_bkey = CAST(CAST(rla.ExportedToCerdoDate AS DATE) AS DATETIME)
       ,Interest                          = ISNULL(rla.Interest, 0)
       ,ApplicationLoanObjectId           = ISNULL(rla.ApplicationLoanObjectCODE, '-1')
       ,ApplicationLoanObject             = ISNULL(rla.ApplicationLoanObject, 'N/A')
       ,ApplicationPurposeId              = ISNULL(rla.ApplicationPurposeCODE, '-1')
       ,ApplicationPurpose                = ISNULL(rla.ApplicationPurpose, 'N/A')
       ,ApplicationRefusalId              = CASE WHEN rlas.StatusName LIKE 'Decline%' AND rlas.CompletedDate IS NULL THEN ISNULL(rla.ApplicationRefusalCODE, '-1') ELSE '-1' END
       ,ApplicationRefusal                = CASE WHEN rlas.StatusName LIKE 'Decline%' AND rlas.CompletedDate IS NULL THEN ISNULL(rla.ApplicationRefusal, 'N/A') ELSE 'N/A' END
       ,CustomerSupportEmployee_bkey	  = CAST(ISNULL(rla.UpdatedByUser, '-1') + '#SE' AS NVARCHAR(100))
       ,FinanceSegment_bkey               = CAST('SE_ML' AS NVARCHAR(100))
       ,ContactWayId                      = ISNULL(rla.ContactWayCODE, '-1')
       ,ContactWay                        = ISNULL(NULLIF(rla.ContactWay, ''), 'N/A')
       ,MediaCode                         = ISNULL(rla.MediaCode, '-1')
       ,Media                             = ISNULL(NULLIF(rm.Name, ''), 'N/A')
       ,MediaCategoryCode                 = ISNULL(rm.MediaCategoryCode, '-1')
       ,MediaCategoryName                 = ISNULL(NULLIF(rm.MediaCategoryName, ''), 'N/A')
       ,MediaTypeCode                     = ISNULL(rm.MediaTypeCode, '-1')
       ,MediaType                         = ISNULL(NULLIF(rm.MediaType, ''), 'N/A')
       ,ExportedToCerdoDate               = rla.ExportedToCerdoDate
       ,BaseRate                          = ISNULL(rla.BaseRate, 0)
       ,InterestMargin                    = ISNULL(rla.InterestMargin, 0)
       ,ManualInterestMargin              = ISNULL(rla.ManualInterestMargin, 0)
       ,InterestBondCODE                  = ISNULL(rla.InterestBondCODE, 'N/A')
       ,InterestBond                      = ISNULL(rla.InterestBond, 'N/A')
       ,ApplicationLoanTypeCODE           = ISNULL(rla.ApplicationLoanTypeCODE, 'N/A')
       ,ApplicationLoanType               = ISNULL(rla.ApplicationLoanType, 'N/A')
       ,PriceLevel                        = CAST(ISNULL(rc.PriceLevelText, 'N/A') AS NVARCHAR(50))
       ,Calendar_ContactDate_bkey         = CAST(CAST(ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,LoanApplicationSource             = CAST('BAMS' AS NVARCHAR(100))
	   ,RiskInterestRate                  = ISNULL(rla.RiskInterestRate, 0)
       ,RiskInterestDuration              = ISNULL(rla.RiskInterestDuration, 0)
       ,RiskInterestAmount                = ISNULL(rla.RiskInterestAmount, 0)
       ,InterestRateTotal                 = ISNULL(rla.InterestRateTotal, 0)
       ,LockRiskInterestRate              = ISNULL(rla.LockRiskInterestRate, 0)
	   ,CampaignCODE                      = ISNULL(rla.CampaignCODE, '-1')
       ,CampaignName                      = ISNULL(rla.CampaignName, 'N/A')
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.LoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplication rla) rla
LEFT JOIN (SELECT ola.OpocLoanApplication_bkey, ola.SysValidFromDateTime, ola.SysSrcGenerationDateTime, ola.SysModifiedUTC, _isFirst = ROW_NUMBER() OVER (PARTITION BY ola.OpocLoanApplication_bkey ORDER BY ola.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication ola) ola ON ola.OpocLoanApplication_bkey = rla.LoanApplication_bkey  AND ola._isFirst = 1
LEFT JOIN (SELECT rlas.StatusName, rlas.CompletedDate, rlas.SysModifiedUTC, rlas.ApplicationId, SysValidFromDateTime, _isFirst = ROW_NUMBER() OVER (PARTITION BY rlas.ApplicationId ORDER BY rlas.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas) rlas ON rlas.ApplicationId = rla.LoanApplication_bkey AND rlas._isFirst = 1
LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rm.Media_bkey ORDER BY rm.SysValidFromDateTime) FROM BamsSe_RawTyped.r_Media rm) rm ON rm.Media_bkey = rla.MediaCode AND rm._isFirst = 1
LEFT JOIN (SELECT rac.ApplicationId, rac.CustomerId, _isFirst = ROW_NUMBER() OVER (PARTITION BY rac.ApplicationId ORDER BY rac.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_ApplicationCustomer rac WHERE rac.IsMainApplicant = 1) rac ON rla.LoanApplication_bkey = rac.ApplicationId AND rac._isFirst = 1
LEFT JOIN (SELECT rc.PriceLevelText, Customer_bkey, _isLast = ROW_NUMBER() OVER (PARTITION BY rc.Customer_bkey ORDER BY rc.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_Customer rc ) rc ON rc.Customer_bkey = rac.CustomerId AND rc._isLast = 1
WHERE   rla.LoanApplication_bkey <> '-1' AND ISNULL(rla.PaidOutDate, rla.SysSrcGenerationDateTime) > '2016-12-31' AND rla._isFirst = 1 
UNION ALL 
SELECT  rla.SysDatetimeDeletedUTC
       ,SysModifiedUTC                    = rla.SysModifiedUTC
       ,SysValidFromDateTime			  = rla.SysValidFromDateTime
       ,rla.SysSrcGenerationDateTime
       ,MLLoanApplication_bkey            = CAST(rla.OpocLoanApplication_bkey + '#SE' AS NVARCHAR(100))
       ,ApplicationNumber                 = -1
       ,Amount                            = ISNULL(rla.Amount, 0)
       ,Calendar_PaidOutDate_bkey         = CAST(NULL AS DATETIME)
       ,Calendar_ExportedToCerdoDate_bkey = CAST(NULL AS DATETIME)
       ,Interest                          = CAST(0 AS DECIMAL(18, 8))
       ,ApplicationLoanObjectId           = '-1'
       ,ApplicationLoanObject             = 'N/A'
       ,ApplicationPurposeId              = ISNULL(rla.ApplicationPurposeCODE, '-1')
       ,ApplicationPurpose                = ISNULL(rla.ApplicationPurpose, 'N/A')
       ,ApplicationRefusalId              = ISNULL(rla.ApplicationRefusalCODE, '-1')
       ,ApplicationRefusal                = ISNULL(rla.ApplicationRefusal, 'N/A')
       ,CustomerSupportEmployee_bkey	  = CAST(ISNULL(NULLIF(rla.ExportedByUserId, 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'), rla.UpdatedByUserId) + '#SE' AS NVARCHAR(100))
       ,FinanceSegment_bkey               = CAST(ISNULL(rla2.FinanceSegment_bkey, (CASE WHEN rla.OPOCProduct IN ( 'Bluestep privatlån', 'Spring privatlån' ) THEN 'SE_PL' WHEN rla.OPOCProduct IN ( 'Bostadslån' ) THEN 'SE_ML' ELSE '-1' END)) AS NVARCHAR(100))
       ,ContactWayId                      = ISNULL(rla.ContactWayCODE, '-1')
       ,ContactWay                        = ISNULL(NULLIF(rla.ContactWay, ''), 'N/A')
       ,MediaCode                         = ISNULL(rla.MediaCode, '-1')
       ,Media                             = ISNULL(NULLIF(rm.Name, ''), 'N/A')
       ,MediaCategoryCode                 = ISNULL(rm.MediaCategoryCode, '-1')
       ,MediaCategoryName                 = ISNULL(NULLIF(rm.MediaCategoryName, ''), 'N/A')
       ,MediaTypeCode                     = ISNULL(rm.MediaTypeCode, '-1')
       ,MediaType                         = ISNULL(NULLIF(rm.MediaType, ''), 'N/A')
       ,ExportedToCerdoDate               = CAST(NULL AS DATETIME)
       ,BaseRate                          = CAST(0 AS DECIMAL(18, 8))
       ,InterestMargin                    = CAST(0 AS DECIMAL(18, 8))
       ,ManualInterestMargin              = CAST(0 AS DECIMAL(18, 8))
       ,InterestBondCODE                  = 'N/A'
       ,InterestBond                      = 'N/A'
       ,ApplicationLoanTypeCODE           = 'N/A'
       ,ApplicationLoanType               = 'N/A'
       ,PriceLevel                        = 'N/A'
       ,Calendar_ContactDate_bkey         = CAST(CAST(rla.SysSrcGenerationDateTime AS DATE) AS DATETIME)
       ,LoanApplicationSource             = CAST('OPOC' AS NVARCHAR(100))
	   ,RiskInterestRate                  = 0
       ,RiskInterestDuration              = 0
       ,RiskInterestAmount                = 0
       ,InterestRateTotal                 = 0
       ,LockRiskInterestRate              = 0
	   ,CampaignCODE                      = '-1'
       ,CampaignName                      = 'N/A'
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.OpocLoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication rla WHERE rla.OPOCProduct IN ( 'Bostadslån' )) rla 
LEFT JOIN (SELECT TOP 1 'SE_ML' AS FinanceSegment_bkey, rla2.LoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla2.LoanApplication_bkey ORDER BY rla2.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplication rla2) rla2 ON rla2.LoanApplication_bkey = rla.OpocLoanApplication_bkey AND rla2._isFirst = 1
LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rm.Media_bkey ORDER BY rm.SysValidFromDateTime) FROM BamsSe_RawTyped.r_Media rm) rm ON rm.Media_bkey = rla.MediaCode AND rm._isFirst = 1
WHERE  rla.OpocLoanApplication_bkey <> '-1' AND rla.SysSrcGenerationDateTime > '2016-12-31' AND rla._isFirst = 1 
UNION ALL 
SELECT  rla.SysDatetimeDeletedUTC
       ,SysModifiedUTC                    = rla.SysModifiedUTC
       ,SysValidFromDateTime              = rla.SysValidFromDateTime
       ,rla.SysSrcGenerationDateTime
       ,MLLoanApplication_bkey            = CAST(rla.OpocLoanApplication_bkey + '#NO' AS NVARCHAR(100))
       ,ApplicationNumber                 = -1
       ,Amount                            = ISNULL(rla.Amount, 0)
       ,Calendar_PaidOutDate_bkey         = CAST(NULL AS DATETIME)
       ,Calendar_ExportedToCerdoDate_bkey = CAST(NULL AS DATETIME)
       ,Interest                          = CAST(0 AS DECIMAL(18, 8))
       ,ApplicationLoanObjectId           = '-1'
       ,ApplicationLoanObject             = 'N/A'
       ,ApplicationPurposeId              = ISNULL(rla.ApplicationPurposeCODE, '-1')
       ,ApplicationPurpose                = ISNULL(rla.ApplicationPurpose, 'N/A')
       ,ApplicationRefusalId              = ISNULL(rla.ApplicationRefusalCODE, '-1')
       ,ApplicationRefusal                = ISNULL(rla.ApplicationRefusal, 'N/A')
       ,CustomerSupportEmployee_bkey      = CAST(ISNULL(NULLIF(rla.ExportedByUserId, 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'), rla.UpdatedByUserId) + '#NO' AS NVARCHAR(100))
       ,FinanceSegment_bkey               = 'NO_ML'
       ,ContactWayId                      = ISNULL(rla.ContactWayCODE, '-1')
       ,ContactWay                        = ISNULL(NULLIF(rla.ContactWay, ''), 'N/A')
       ,MediaCode                         = ISNULL(rla.MediaCode, '-1')
       ,Media                             = ISNULL(NULLIF(rm.Name, ''), 'N/A')
       ,MediaCategoryCode                 = ISNULL(rm.MediaCategoryCode, '-1')
       ,MediaCategoryName                 = ISNULL(NULLIF(rm.MediaCategoryName, ''), 'N/A')
       ,MediaTypeCode                     = ISNULL(rm.MediaTypeCode, '-1')
       ,MediaType                         = ISNULL(NULLIF(rm.MediaType, ''), 'N/A')
       ,ExportedToCerdoDate               = CAST(NULL AS DATETIME)
       ,BaseRate                          = CAST(0 AS DECIMAL(18, 8))
       ,InterestMargin                    = CAST(0 AS DECIMAL(18, 8))
       ,ManualInterestMargin              = CAST(0 AS DECIMAL(18, 8))
       ,InterestBondCODE                  = 'N/A'
       ,InterestBond                      = 'N/A'
       ,ApplicationLoanTypeCODE           = 'N/A'
       ,ApplicationLoanType               = 'N/A'
       ,PriceLevel                        = 'N/A'
       ,Calendar_ContactDate_bkey         = CAST(CAST(rla.SysSrcGenerationDateTime AS DATE) AS DATETIME)
       ,LoanApplicationSource             = CAST('OPOC' AS NVARCHAR(100))
       ,RiskInterestRate                  = 0
       ,RiskInterestDuration              = 0
       ,RiskInterestAmount                = 0
       ,InterestRateTotal                 = 0
       ,LockRiskInterestRate              = 0
	   ,CampaignCODE                      = '-1'
       ,CampaignName                      = 'N/A'
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.OpocLoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_OpocLoanApplication rla) rla
LEFT JOIN (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rm.Media_bkey ORDER BY rm.SysValidFromDateTime) FROM BamsNo_RawTyped.r_Media rm) rm ON rm.Media_bkey = rla.MediaCode AND rm._isFirst = 1
WHERE  rla.OpocLoanApplication_bkey <> '-1' AND rla.SysSrcGenerationDateTime > '2016-12-31' AND rla._isFirst = 1
GO
