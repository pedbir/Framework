﻿




CREATE  PROCEDURE [Finance].[Test that Local Currency Amount in General Ledger per Segment stay persistent after new changes]
AS
BEGIN


------Execution
	
        
		SELECT 	Segment						= a.SegmentCode,
				Period						= CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY					= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
		INTO #actual
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Segment a ON gl.FinanceSegment_key = a.FinanceSegment_key 
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY a.SegmentCode,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)
	



------Assertion
        
		SELECT *
		INTO #expected
		FROM    OPENQUERY (DWH_PROD, '
		SELECT 	Segment						= a.SegmentCode,
				Period						= CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY					= CONVERT(DECIMAL(18,0),(SUM(AmountLCY)))  	
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Segment a ON gl.FinanceSegment_key = a.FinanceSegment_key 
		WHERE  CONVERT(NVARCHAR(6), gl.Period_key, 112) > CONVERT(NVARCHAR(6),DATEADD(MM,-4,GETDATE()), 112)
		AND CONVERT(NVARCHAR(6), gl.Period_key, 112) < CONVERT(NVARCHAR(6),GETDATE(), 112)
		GROUP BY a.SegmentCode,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)


		' ) oq


		
		EXEC tSQLt.AssertEqualsTable '#expected', '#actual';

END;