





CREATE  PROCEDURE [Finance].[Test that Local Currency Amount in General Ledger per ReportStructureItem stay persistent after new changes]
AS
BEGIN


------Execution
	

        
		SELECT 	ReportStructureLvl1Name		= rs.ReportStructureLvl1Name,
		        ReportStructureLvl2Name		= rs.ReportStructureLvl2Name,
				ReportStructureLvl3Name		= rs.ReportStructureLvl3Name,
				Period						= CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY					= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
		INTO #actual
		
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_GLAccountLegalEntity gal ON gl.GLAccountLegalEntity_key = gal.GLAccountLegalEntity_key 
		INNER JOIN  DWH_3_Fact.Finance.f_BridgeReportStructure brs ON gal.GLAccountLegalEntity_key = brs.GLAccountLegalEntity_key
		INNER JOIN  DWH_3_Fact.Finance.d_ReportStructure rs ON brs.ReportStructure_key = rs.ReportStructure_key
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY rs.ReportStructureLvl1Name,
				 rs.ReportStructureLvl2Name,
				 rs.ReportStructureLvl3Name,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)
	



------Assertion
        
		SELECT *
		INTO #expected
		FROM    OPENQUERY (DWH_PROD, '
		   
	 
	
		SELECT 	ReportStructureLvl1Name		= rs.ReportStructureLvl1Name,
		        ReportStructureLvl2Name		= rs.ReportStructureLvl2Name,
				ReportStructureLvl3Name		= rs.ReportStructureLvl3Name,
				Period						= CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY					= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
			
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_GLAccountLegalEntity gal ON gl.GLAccountLegalEntity_key = gal.GLAccountLegalEntity_key 
		INNER JOIN  DWH_3_Fact.Finance.f_BridgeReportStructure brs ON gal.GLAccountLegalEntity_key = brs.GLAccountLegalEntity_key
		INNER JOIN  DWH_3_Fact.Finance.d_ReportStructure rs ON brs.ReportStructure_key = rs.ReportStructure_key
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY rs.ReportStructureLvl1Name,
				 rs.ReportStructureLvl2Name,
				 rs.ReportStructureLvl3Name,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)
		' ) oq


		
		EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;