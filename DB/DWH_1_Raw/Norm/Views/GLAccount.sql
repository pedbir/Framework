








CREATE  VIEW [Norm].[GLAccount]
AS

WITH DimRelationer AS (
		SELECT Client = rdr3.Client 
			,rdr3.SysSrcGenerationDateTime
			,rdr3Relatedattr = rdr3.Relatedattr  
			,rdr3Relvalue = rdr3.Relvalue
			,rdr2Relatedattr = rdr2.Relatedattr
			,rdr2Relvalue = rdr2.Relvalue 
			,rdr1Relatedattr = rdr1.Relatedattr   
			,rdr1Relvalue = rdr1.Relvalue 
  			,rdr1Attvalue = rdr1.Attvalue
		FROM  Agresso_RawTyped.vrt_DimRelationer_01 rdr3
		INNER JOIN  Agresso_RawTyped.vrt_DimRelationer_01 rdr2
		ON rdr3.Attvalue = rdr2.Relvalue
		AND rdr3.Client = rdr2.Client 
		INNER JOIN  Agresso_RawTyped.vrt_DimRelationer_01 rdr1
		ON rdr2.Attvalue = rdr1.Relvalue
		AND rdr2.Client = rdr1.Client 
		WHERE   
		rdr3.Relatedattr = 'RAPSEG3'
		AND rdr2.Relatedattr = 'RAPSEG2'
		AND rdr1.Relatedattr = 'RAPSEG1'
		AND rdr2.Attname = 'RAPSEG1'
		AND rdr1.Attname = 'KONTO'
		GROUP BY
			 rdr3.Client 
			,rdr3.SysSrcGenerationDateTime
			,rdr3.Relatedattr  
			,rdr3.Relvalue 
			,rdr2.Relatedattr 
			,rdr2.Relvalue 
			,rdr1.Relatedattr
			,rdr1.Relvalue 
			,rdr1.Attvalue

)
   

SELECT  vk.SysDatetimeDeletedUTC
       ,vk.SysSrcGenerationDateTime
       ,SysValidFromDateTime		= CAST(vk.Lastupdate AS DATETIME2(0))
       ,vk.SysModifiedUTC
	   ,GLAccount_bkey				= CAST(CAST(ISNULL(vk.Account, '-1') AS NVARCHAR(50)) + '#' + ISNULL(vk.Client, '-1') AS NVARCHAR(100))
       ,GLAccountName				= CAST(COALESCE(vk.Description, vkbfab.Description, 'N/A') AS NVARCHAR(300))
       ,GLAccountGroupCode			= CAST(ISNULL(vk.Account_grp,'N/A') AS NVARCHAR(50))
       ,GLAccountGroup				= CAST(COALESCE(vk.Xaccount_grp, vkbfab.Xaccount_grp, 'N/A') AS NVARCHAR(200))
	   ,GLAccountType				= CAST(ISNULL(vk.Account_type,'N/A') AS NVARCHAR(10)) 
	   ,GLAccountCode				= CAST(ISNULL(vk.Account,'N/A') AS NVARCHAR(50))
	   ,GLAccountHierarchy1Code		= CAST(ISNULL(dr.rdr1Relvalue, 'N/A') AS NVARCHAR(100))
       ,GLAccountHierarchy1Name		= CAST(ISNULL(vd1.DimDescription, 'N/A') AS NVARCHAR(100))
	   ,GLAccountHierarchy2Code		= CAST(ISNULL(dr.rdr2Relvalue, 'N/A') AS NVARCHAR(100))
       ,GLAccountHierarchy2Name		= CAST(ISNULL(vd2.DimDescription, 'N/A') AS NVARCHAR(100))
	   ,GLAccountHierarchy3Code		= CAST(ISNULL(dr.rdr3Relvalue, 'N/A') AS NVARCHAR(100))
       ,GLAccountHierarchy3Name		= CAST(ISNULL(vd3.DimDescription, 'N/A') AS NVARCHAR(100))
	   ,LegalEntity_bkey			= CAST(ISNULL(vk.Client, '-1') AS NVARCHAR(100))
	   ,Status						= CAST(ISNULL(vk.Status,'N/A') AS NVARCHAR(3))
FROM		Agresso_RawTyped.vrt_Kontoplan_01 vk
LEFT JOIN (SELECT  Client,Account,Description,Xaccount_grp FROM Agresso_RawTyped.vrt_Kontoplan_01 WHERE Client = 'BFAB')  vkbfab ON  vk.Account = vkbfab.Account  
LEFT JOIN   DimRelationer dr ON vk.Account = dr.rdr1Attvalue AND vk.Client = dr.Client
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd3 ON dr.rdr3Relatedattr   = vd3.Attname AND dr.rdr3Relvalue = vd3.DimValue AND vk.Client = vd3.Client  
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd2 ON dr.rdr2Relatedattr   = vd2.Attname AND dr.rdr2Relvalue = vd2.DimValue AND vk.Client = vd2.Client  
LEFT JOIN Agresso_RawTyped.vrt_Dimension_01 vd1 ON dr.rdr1Relatedattr   = vd1.Attname AND dr.rdr1Relvalue = vd1.DimValue AND vk.Client = vd1.Client