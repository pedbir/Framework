
CREATE VIEW Marketing.[d_LoanApplication]
AS
SELECT  LoanApplication_key  = CAST(CAST(dla.MLLoanApplication_key AS NVARCHAR(50)) + '#ML' AS NVARCHAR(100))
       ,LoanApplication_bkey = CAST(dla.MLLoanApplication_bkey AS NVARCHAR(100))
       ,dla.ApplicationNumber
       ,dla.ApplicationLoanObject
       ,dla.ApplicationPurpose
       ,dla.ApplicationRefusal
       ,IsRefusal            = IIF(dla.ApplicationRefusal IN ( 'N/A', '' ), 0, 1)
       ,IsPayoutPlanned      = IIF(dla.PaidOutDate IS NULL, 'N', 'Y')
       ,dla.ContactWay
       ,Media                = dla.Media
       ,MediaCategoryName    = dla.MediaCategoryName
       ,MediaType            = dla.MediaType
       ,dla.InterestBond
       ,dla.ApplicationLoanType
       ,dla.CustomerSupportEmployee_CS_key
       ,dla.CustomerSupportEmployee_CSG_key
       ,dla.CustomerSupportEmployee_Credit_key
       ,Campaign             = dla.CampaignName
	   ,dla.PriceLevel
	   ,dla.CustomerMainApplicant_key
	   ,dla.CustomerCoApplicant_key
FROM    Fact.d_MLLoanApplication dla
--WHERE   dla.MLLoanApplication_key <> -1
UNION ALL
SELECT  LoanApplication_key                = CAST(fplam.PLLoanApplicationMetrics_key + '#PL' AS NVARCHAR(100))
       ,LoanApplication_bkey               = CAST(fplam.PLLoanApplicationMetrics_key + '#PL' AS NVARCHAR(100))
       ,fplam.ApplicationNumber
       ,ApplicationLoanObject              = UPPER(dul2.UcapLkpValue)
       ,ApplicationPurpose                 = UPPER(dul3.UcapLkpValue)
       ,ApplicationRefusal                 = IIF(dul.UcapLkpValue = 'Declined', dul1.UcapLkpValue, 'N/A')
       ,IsRefusal                          = IIF(dul.UcapLkpValue = 'Declined', 1, 0)
       ,IsPayoutPlanned                    = IIF(dul.UcapLkpValue = 'PoSentLetter', 'Y', 'N')
       ,ContactWay                         = 'N/A'
       ,Media                              = 'N/A'
       ,MediaCategoryName                  = 'N/A'
       ,MediaType                          = 'N/A'
       ,InterestBond                       = 'N/A'
       ,ApplicationLoanType                = 'N/A'
       ,CustomerSupportEmployee_CS_key     = -1
       ,CustomerSupportEmployee_CSG_key    = -1
       ,CustomerSupportEmployee_Credit_key = -1
       ,Campaign                           = 'N/A'
       ,PriceLevel                         = 'N/A'
	   ,CustomerMainApplicant_key		   = -1
	   ,CustomerCoApplicant_key			   = -1
FROM    Fact.f_PLLoanApplicationMetrics fplam
INNER JOIN  Fact.d_UcapLkp                  dul ON dul.UcapLkp_key   = fplam.UcapLkp_DWHPositionStatus_key
INNER JOIN  Fact.d_UcapLkp                  dul1 ON dul1.UcapLkp_key = fplam.UcapLkp_DWHPosition_key
INNER JOIN  Fact.d_UcapLkp                  dul2 ON dul2.UcapLkp_key = fplam.UcapLkp_LoanPurposeType_key
INNER JOIN  Fact.d_UcapLkp                  dul3 ON dul3.UcapLkp_key = fplam.UcapLkp_SelectedProduct_key