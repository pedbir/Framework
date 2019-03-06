CREATE VIEW [Norm].[MLLoanApplicationMilestone]
AS
-- Sweden ML
-- Contact
SELECT  SysValidFromDateTime            = CAST(IIF(rla.SysValidFromDateTime < rola.SysValidFromDateTime, DATEADD(MINUTE, -5, rla.SysValidFromDateTime), rola.SysValidFromDateTime) AS DATETIME2(0))
       ,SysModifiedUTC                  = rola.SysModifiedUTC
       ,SysDatetimeDeletedUTC           = rola.SysDatetimeDeletedUTC
       ,SysSrcGenerationDateTime        = rola.SysSrcGenerationDateTime
       ,MLLoanApplicationMilestone_bkey = CAST(rola.OpocLoanApplication_bkey + '#SE#Contact' AS NVARCHAR(100))
       ,MLLoanApplication_bkey          = CAST(rola.OpocLoanApplication_bkey + '#SE' AS NVARCHAR(100))
       ,ApplicationNumber               = COALESCE(rla.ApplicationNumber, rola.ApplicationNumber, -1)
       ,MLLoanApplicationStatus		    = CAST(ISNULL(rola.ApplicationRefusal, 'N/A') AS NVARCHAR(150))
       ,CustomerSupportEmployee_bkey    = CAST(ISNULL(NULLIF(rola.ExportedByUserId, 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'), rola.UpdatedByUserId) + '#SE' AS NVARCHAR(100))
       ,Calendar_Milestone_bkey         = CAST(CAST(IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime, rola.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,Calendar_Contact_bkey           = CAST(CAST(IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime, rola.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,MilestoneDate                   = IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, DATEADD(MINUTE, -1, rla.SysSrcGenerationDateTime), rola.SysSrcGenerationDateTime)
       ,IsContact                       = IsContact
       ,IsLead                          = 0
       ,IsQLead                         = 0
       ,IsApplication                   = 0
       ,IsPayout                        = 0
       ,IsPreAppLoanPromise             = 0
       ,IsDeclined                      = IIF(rola.ApplicationRefusalCODE IS NOT NULL AND rola.ApplicationRefusal NOT LIKE 'Expo%', 1, 0)
       ,LoanApplicationSource           = CAST('OPOC' AS NVARCHAR(100))
	   ,FinanceSegment_bkey				= CAST('SE_ML' AS NVARCHAR(100))
	   ,'Contact' AS Comment
FROM   (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY OpocLoanApplication_bkey ORDER BY rola.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication rola WHERE rola.OPOCProduct = 'Bostadslån') rola
OUTER APPLY (SELECT IsContact = IIF((ApplicationRefusal IN ( 'Dubblett', 'BPL 01 Dubblett', 'BPL 18 Övrigt', 'Allm. frågor - Kriterier - möjligheter', 'Allm. frågor - Bluestep', 'BPL Allm. frågor', 'Ej sökt lån', 'Allm. frågor - Inväntar svar bank' )
									OR MediaCode = '60FDF617-39B4-4A12-8F61-F32DDA4BDF7E'),0,1))             t
LEFT JOIN (SELECT rlas.ApplicationId, rlas.SysValidFromDateTime, rlas.SysSrcGenerationDateTime, rlas.ApplicationNumber,   _isLast = LEAD(0,1,1) OVER (PARTITION BY rlas.ApplicationId ORDER BY rlas.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas) rla ON rla.ApplicationId = rola.OpocLoanApplication_bkey AND rla._isLast = 1
WHERE rola._isFirst = 1 AND rola.SysSrcGenerationDateTime > '2017-12-31' 
UNION ALL
-- Lead
SELECT  SysValidFromDateTime            = CAST(DATEADD(SECOND, 1, IIF(rla.SysValidFromDateTime < rola.SysValidFromDateTime, DATEADD(MINUTE, -4, rla.SysValidFromDateTime), rola.SysValidFromDateTime)) AS DATETIME2(0))
       ,SysModifiedUTC                  = rola.SysModifiedUTC
       ,SysDatetimeDeletedUTC           = rola.SysDatetimeDeletedUTC
       ,SysSrcGenerationDateTime        = rola.SysSrcGenerationDateTime
       ,MLLoanApplicationMilestone_bkey = CAST(rola.OpocLoanApplication_bkey + '#SE#Lead' AS NVARCHAR(100))
       ,MLLoanApplication_bkey          = CAST(rola.OpocLoanApplication_bkey + '#SE' AS NVARCHAR(100))
       ,ApplicationNumber               = COALESCE(rla.ApplicationNumber, rola.ApplicationNumber, -1)
       ,MLLoanApplicationStatus		    = CAST(ISNULL(rola.ApplicationRefusal, 'N/A') AS NVARCHAR(150))
       ,CustomerSupportEmployee_bkey    = CAST(ISNULL(NULLIF(rola.ExportedByUserId, 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF'), rola.UpdatedByUserId) + '#SE' AS NVARCHAR(100))
       ,Calendar_Milestone_bkey         = CAST(CAST(IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime, rola.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,Calendar_Contact_bkey           = CAST(CAST(IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime, rola.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,MilestoneDate                   = DATEADD(SECOND, 1, IIF(rla.SysSrcGenerationDateTime < rola.SysSrcGenerationDateTime, DATEADD(MINUTE, -1, rla.SysSrcGenerationDateTime), rola.SysSrcGenerationDateTime))
       ,IsContact                       = IsContact
       ,IsLead                          = IIF(IsContact = 1 AND rola.Amount > 0, 1, 0) 
       ,IsQLead                         = 0
       ,IsApplication                   = 0
       ,IsPayout                        = 0
       ,IsPreAppLoanPromise             = 0
       ,IsDeclined                      = IIF(rola.ApplicationRefusalCODE IS NOT NULL AND rola.ApplicationRefusal NOT LIKE 'Expo%', 1, 0)
       ,LoanApplicationSource           = CAST('OPOC' AS NVARCHAR(100))
	   ,FinanceSegment_bkey				= CAST('SE_ML' AS NVARCHAR(100))
	   ,'Lead' AS Comment
FROM   (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY OpocLoanApplication_bkey ORDER BY rola.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication rola WHERE rola.OPOCProduct = 'Bostadslån') rola
OUTER APPLY (SELECT IsContact = IIF((ApplicationRefusal IN ( 'Dubblett', 'BPL 01 Dubblett', 'BPL 18 Övrigt', 'Allm. frågor - Kriterier - möjligheter', 'Allm. frågor - Bluestep', 'BPL Allm. frågor', 'Ej sökt lån', 'Allm. frågor - Inväntar svar bank' )
									OR MediaCode = '60FDF617-39B4-4A12-8F61-F32DDA4BDF7E'),0,1))             t
LEFT JOIN (SELECT rlas.ApplicationId, rlas.SysValidFromDateTime, rlas.SysSrcGenerationDateTime, rlas.ApplicationNumber,   _isLast = LEAD(0,1,1) OVER (PARTITION BY rlas.ApplicationId ORDER BY rlas.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas) rla ON rla.ApplicationId = rola.OpocLoanApplication_bkey AND rla._isLast = 1
WHERE rola._isFirst = 1 AND ISNULL(rola.ApplicationRefusal, 'Export') LIKE 'Export%' AND rola.SysSrcGenerationDateTime > '2017-12-31' 
UNION ALL
-- QLead, Application and PreAppLoanPromise
SELECT  SysValidFromDateTime            = rlas.SysValidFromDateTime 
       ,SysModifiedUTC                  = rlas.SysModifiedUTC
       ,SysDatetimeDeletedUTC           = rlas.SysDatetimeDeletedUTC
       ,SysSrcGenerationDateTime        = rlas.SysSrcGenerationDateTime
       ,MLLoanApplicationMilestone_bkey = ISNULL(rlas.LoanApplicationStatus_bkey, '-1')
       ,MLLoanApplication_bkey          = CAST(ISNULL(rla.LoanApplication_bkey + '#SE', '-1') AS NVARCHAR(100))
       ,ApplicationNumber               = ISNULL(rlas.ApplicationNumber, -1)
       ,MLLoanApplicationStatus		    = CAST(ISNULL(NULLIF(rlas.StatusName, ''), 'N/A') AS NVARCHAR(150))
       ,CustomerSupportEmployee_bkey    = CAST(ISNULL(rlas.CompletedByEmployeeID + '#SE', '-1') AS NVARCHAR(100))
       ,Calendar_Milestone_bkey         = CAST(CAST(rlas.SysSrcGenerationDateTime AS DATE) AS DATETIME)
       ,Calendar_Contact_bkey           = CAST(CAST(ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
       ,MilestoneDate                   = rlas.SysSrcGenerationDateTime
       ,IsContact                       = 1
       ,IsLead                          = 1
       ,IsQLead                         = IIF(ISNULL(rlas2.IsApplication, 0) + IIF(rlas.StatusName = 'Lånelöfte Pre Application', 1, 0)  > 0, 1, q.IsQLead) 
       ,IsApplication                   = IIF(ISNULL(rlas2.IsApplication, 0) > 0, 1, 0) 
       ,IsPayout                        = 0
       ,IsPreAppLoanPromise             = IIF(rlas.StatusName = 'Lånelöfte Pre Application', 1, 0) 
       ,IsDeclined                      = IIF(rlas.StatusName LIKE 'Decline%', 1, 0)
       ,LoanApplicationSource           = CAST('BAMS' AS NVARCHAR(100))
	   ,FinanceSegment_bkey				= CAST('SE_ML' AS NVARCHAR(100))
	   ,'QLead, Application and PreAppLoanPromise' AS Comment	   	   
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rlas.LoanApplicationStatus_bkey ORDER BY rlas.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas) rlas
INNER JOIN (SELECT rla.Amount, rla.LoanApplication_bkey, rla.ApplicationPurpose, rla.ApplicationRefusal, rla.Media, rla.SysSrcGenerationDateTime, rla.PaidOutDate, rla.ApplicationRefusalCODE, _isFist = LAG(0,1,1) OVER (PARTITION BY rla.LoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplication rla) rla ON rlas.ApplicationId = rla.LoanApplication_bkey AND rla._isFist = 1
LEFT JOIN (SELECT ola.SysSrcGenerationDateTime, ola.SysValidFromDateTime, OpocLoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY ola.OpocLoanApplication_bkey ORDER BY ola.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication ola ) ola ON ola.OpocLoanApplication_bkey = rla.LoanApplication_bkey AND ola._isFirst = 1
OUTER APPLY (SELECT IsContact = CASE WHEN (rla.ApplicationRefusal IN ( 'Dubblett', 'Återskapad från Kre' )
							OR ( rla.Media = 'Befintlig kund' AND rla.ApplicationRefusal = 'Befintlig kund/kontakt' AND ApplicationPurpose = 'Annat')
							OR ( rla.Media = 'SparkontoPlus' AND rla.ApplicationRefusal IN ( 'Övrigt', 'Allmänna frågor' ))
							OR ( rla.Media = 'Ej kundrelaterat' AND rla.ApplicationRefusal IN ( 'Befintlig kund/kontakt', 'Allmänna frågor', 'Övrigt' ))) THEN 0 ELSE 1 END) t
OUTER APPLY (SELECT IsLead = CASE WHEN (t.IsContact = 1 AND rla.ApplicationPurpose NOT IN ('Annat', 'Undefined')) THEN 1 ELSE 0 END) il
OUTER APPLY (SELECT TOP 1 IsScreening = 1 FROM BamsSe_RawTyped.r_ApplicationUser rau WHERE rau.OwnerRole = 'Screening' AND rau.ApplicationId = rla.LoanApplication_bkey ORDER BY rau.SysValidFromDateTime DESC) s
OUTER APPLY (SELECT TOP 1 IsFinalizeApplication = 1 FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas1 WHERE rlas1.ApplicationId = rla.LoanApplication_bkey AND rlas1.StatusName = 'Finalize Application' AND ISNULL(rlas.SysSrcGenerationDateTime, '2999-12-31') >= ISNULL(rlas1.SysSrcGenerationDateTime, '2999-12-31')) rlas1
OUTER APPLY (SELECT TOP 1 IsApplication = 1 FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas2 INNER JOIN  BamsSe_RawTyped.r_LoanApplication rla10 ON rlas2.ApplicationId = rla10.LoanApplication_bkey  WHERE  rla10.InterestMargin > 0 AND ISNULL(rla10.ApplicationPurpose, 'N/A') NOT IN ( 'N/A') AND rla10.ApplicationLoanObject IS NOT NULL AND rlas2.StatusName  = 'Application' AND rlas2.ApplicationId   = rla.LoanApplication_bkey AND ISNULL(rlas.SysSrcGenerationDateTime, '2999-12-31') >= ISNULL(rlas2.SysSrcGenerationDateTime, '2999-12-31') ) rlas2
--OUTER APPLY (SELECT TOP 1 IsPreAppLoanPromise = 1 FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas6 WHERE rlas6.ApplicationId = rla.LoanApplication_bkey AND rlas6.StatusName = 'Lånelöfte Pre Application' AND ISNULL(rlas.SysSrcGenerationDateTime, '2999-12-31') >= ISNULL(rlas6.SysSrcGenerationDateTime, '2999-12-31')) rlas6
OUTER APPLY (SELECT IsQLead = CASE WHEN (il.IsLead = 1 AND s.IsScreening =1 AND rlas1.IsFinalizeApplication = 1) OR rlas2.IsApplication = 1 THEN 1 ELSE 0 END) q
WHERE rlas._isFirst = 1 AND ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) > '2017-12-31' AND rlas.StatusName NOT IN ('CCC', 'CCC Family Purchase', 'CCC Verify Valuation', 'PPC', 'PPC Family Purchase', 'PPC Pruchase', 'CCC Purchase', 'Application closed') 
UNION ALL
-- Payout
SELECT  SysValidFromDateTime            =  rlas.SysValidFromDateTime
		,SysModifiedUTC                  = rlas.SysModifiedUTC
		,SysDatetimeDeletedUTC           = rla.SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime        = rla.SysSrcGenerationDateTime
		,MLLoanApplicationMilestone_bkey = CAST(rla.LoanApplication_bkey + '#SE#PaidOut' AS NVARCHAR(100))
		,MLLoanApplication_bkey          = CAST(ISNULL(rla.LoanApplication_bkey + '#SE', '-1') AS NVARCHAR(100))
		,ApplicationNumber               = ISNULL(rla.ApplicationNumber, -1)
		,MLLoanApplicationStatus		 = CAST(rlas.StatusName AS NVARCHAR(150))
		,CustomerSupportEmployee_bkey    = CAST(rla.UpdatedByUser + '#SE' AS NVARCHAR(100))
		,Calendar_Milestone_bkey         = CAST(CAST(rla.PaidOutDate AS DATE) AS DATETIME)
		,Calendar_Contact_bkey           = CAST(CAST(ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
		,MilestoneDate                   = rla.PaidOutDate
		,IsContact                       = 1
		,IsLead                          = 1
		,IsQLead                         = 1
		,IsApplication                   = 1
		,IsPayout                        = 1 
		,IsPreAppLoanPromise			 = 0
		,IsDeclined						 = IIF(rlas2.StatusName LIKE 'Decline%' AND rlas2.CompletedDate IS NULL, 1, 0)
		,LoanApplicationSource           = CAST('BAMS' AS NVARCHAR(100))
		,FinanceSegment_bkey			 = CAST('SE_ML' AS NVARCHAR(100))
		,'Payout' AS Comment
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.LoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_LoanApplication rla WHERE rla.PaidOutDate IS NOT NULL) rla 
CROSS APPLY (SELECT TOP 1 rlas.SysValidFromDateTime, rlas.SysModifiedUTC, rlas.StatusID, rlas.StatusName FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas WHERE rlas.ApplicationId = rla.LoanApplication_bkey AND rlas.StatusName IN ('CCC', 'CCC Family Purchase', 'CCC Verify Valuation', 'PPC', 'PPC Family Purchase', 'PPC Pruchase')) rlas
CROSS APPLY (SELECT TOP 1 rlas.SysValidFromDateTime, rlas.SysModifiedUTC, rlas.StatusID, rlas.CompletedDate, rlas.StatusName FROM BamsSe_RawTyped.r_LoanApplicationStatus rlas WHERE rlas.ApplicationId = rla.LoanApplication_bkey ORDER BY rlas.SysValidFromDateTime DESC) rlas2
LEFT JOIN (SELECT ola.SysSrcGenerationDateTime, ola.SysValidFromDateTime, OpocLoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY ola.OpocLoanApplication_bkey ORDER BY ola.SysValidFromDateTime DESC) FROM BamsSe_RawTyped.r_OpocLoanApplication ola ) ola ON ola.OpocLoanApplication_bkey = rla.LoanApplication_bkey AND ola._isFirst = 1
WHERE rla._isFirst = 1 AND  rla.PaidOutDate > '2017-12-31' 
-- Norway ML
UNION ALL
-- Payout
SELECT  SysValidFromDateTime            =  rlas.SysValidFromDateTime
		,SysModifiedUTC                  = rlas.SysModifiedUTC
		,SysDatetimeDeletedUTC           = rla.SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime        = rla.SysSrcGenerationDateTime
		,MLLoanApplicationMilestone_bkey = CAST(rla.LoanApplication_bkey + '#NO#PaidOut' AS NVARCHAR(100))
		,MLLoanApplication_bkey          = CAST(ISNULL(rla.LoanApplication_bkey + '#NO', '-1') AS NVARCHAR(100))
		,ApplicationNumber               = ISNULL(rla.ApplicationNumber, -1)
		,MLLoanApplicationStatus	     = CAST(rlas.StatusName AS NVARCHAR(150))
		,CustomerSupportEmployee_bkey    = CAST(rla.UpdatedByUser + '#NO' AS NVARCHAR(100))
		,Calendar_Milestone_bkey         = CAST(CAST(rla.PaidOutDate AS DATE) AS DATETIME)
		,Calendar_Contact_bkey           = CAST(CAST(ISNULL(ola.SysSrcGenerationDateTime, rla.SysSrcGenerationDateTime) AS DATE) AS DATETIME)
		,MilestoneDate                   = rla.PaidOutDate
		,IsContact                       = 1
		,IsLead                          = 1
		,IsQLead                         = 1
		,IsApplication                   = 1
		,IsPayout                        = 1 
		,IsPreAppLoanPromise			 = 0		
		,IsDeclined						 = 0   
		,LoanApplicationSource           = CAST('BAMS' AS NVARCHAR(100))
		,FinanceSegment_bkey			 = CAST('NO_ML' AS NVARCHAR(100))
		,'NO Payout' AS Comment
FROM    (SELECT *, _isFirst = ROW_NUMBER() OVER (PARTITION BY rla.LoanApplication_bkey ORDER BY rla.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_LoanApplication rla WHERE rla.PaidOutDate IS NOT NULL) rla 
CROSS APPLY (SELECT TOP 1 rlas.SysValidFromDateTime, rlas.SysModifiedUTC, rlas.StatusID, rlas.StatusName, rlas.CompletedDate FROM BamsNo_RawTyped.r_LoanApplicationStatus rlas WHERE rlas.ApplicationId = rla.LoanApplication_bkey AND rlas.StatusName IN ('Application Closed Purchase' , 'Application Closed Remortage', 'PPC Purchase', 'PPC Remortage')) rlas
LEFT JOIN (SELECT ola.SysSrcGenerationDateTime, ola.SysValidFromDateTime, OpocLoanApplication_bkey, _isFirst = ROW_NUMBER() OVER (PARTITION BY ola.OpocLoanApplication_bkey ORDER BY ola.SysValidFromDateTime DESC) FROM BamsNo_RawTyped.r_OpocLoanApplication ola ) ola ON ola.OpocLoanApplication_bkey = rla.LoanApplication_bkey AND ola._isFirst = 1
WHERE rla._isFirst = 1 AND  rla.PaidOutDate > '2017-12-31' AND NOT (rlas.StatusName LIKE 'Decline%' AND rlas.CompletedDate IS NULL)
GO


