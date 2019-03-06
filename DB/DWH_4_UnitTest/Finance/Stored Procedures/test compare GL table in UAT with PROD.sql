

CREATE PROC [Finance].[test compare GL table in UAT with PROD]
AS
BEGIN	

  ------Execution 
  SELECT dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, Department = ISNULL(dcc.Department, 'N/A'), AmountLCY = SUM(fgl.AmountLCY) 
  INTO #actual
  FROM DWH_3_Fact.Fact.f_GeneralLedger fgl
  INNER JOIN DWH_3_Fact.Fact.d_Calendar dc ON dc.Calendar_key = fgl.Calender_ReportingPeriod_bkey  
  INNER JOIN DWH_3_Fact.Fact.d_GLAccount dga ON fgl.GLAccount_key = dga.GLAccount_key
  INNER JOIN DWH_3_Fact.Fact.d_CostCenter dcc ON fgl.CostCenter_key = dcc.CostCenter_key
  WHERE fgl.Calender_ReportingPeriod_bkey  BETWEEN EOMONTH(DATEADD(MONTH, -3, GETDATE())) AND EOMONTH(DATEADD(MONTH, -1, GETDATE()))
  GROUP BY dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, dcc.Department
  HAVING SUM(fgl.AmountLCY)  <> 0
  ORDER BY dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, dcc.Department
  
   
  ------Assertion 
  SELECT *
  INTO #expected
  FROM OPENQUERY(DWH_PROD, 
  'SELECT dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, Department = ISNULL(dcc.Department, ''N/A''), AmountLCY = SUM(fgl.AmountLCY)   
  FROM DWH_3_Fact.Fact.f_GeneralLedger fgl
  INNER JOIN DWH_3_Fact.Fact.d_Calendar dc ON dc.Calendar_key = fgl.Calender_ReportingPeriod_bkey  
  INNER JOIN DWH_3_Fact.Fact.d_GLAccount dga ON fgl.GLAccount_key = dga.GLAccount_key
  INNER JOIN DWH_3_Fact.Fact.d_CostCenter dcc ON fgl.CostCenter_key = dcc.CostCenter_key
  WHERE fgl.Calender_ReportingPeriod_bkey  BETWEEN EOMONTH(DATEADD(MONTH, -3, GETDATE())) AND EOMONTH(DATEADD(MONTH, -1, GETDATE()))
  GROUP BY dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, dcc.Department
  HAVING SUM(fgl.AmountLCY)  <> 0
  ORDER BY dc.YearMonth, dga.GLAccountGroup, fgl.LegalEntity_bkey, dcc.Department'
  ) oq



  EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
                         
   
END;