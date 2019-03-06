
CREATE PROCEDURE [Finance].[Test that historical Local Currency Amount in General Ledger stay persistent]
AS
BEGIN

------Execution
		
        SELECT 	Account		= a.AccountCode,
				Period      = CONVERT(NVARCHAR(6), gl.Period_key, 112),
				AmountLCY	= CONVERT(INT,(SUM(AmountLCY)))  	
		INTO #actual
		FROM  DWH_3_Fact.Finance.f_GeneralLedger gl
		INNER JOIN  DWH_3_Fact.Finance.d_Account a ON gl.GLAccount_key = a.GLAccount_key 
		WHERE Period_key between '2018-06-30' and '2018-11-30' 
		AND   a.AccountCode IN('5286','5800','5930','6421','6910','7530') 
		GROUP BY a.AccountCode,
				 CONVERT(NVARCHAR(6), gl.Period_key, 112)
		

------Assertion
        
		CREATE TABLE #expected ([Account] NVARCHAR(50),[Period] NVARCHAR(6), AmountLCY  INT)
		INSERT INTO #expected
		VALUES
		( N'5286', N'201806',165687),
		( N'5286', N'201807',162330),
		( N'5286', N'201808',161243),
		( N'5286', N'201809',179206),
		( N'5286', N'201810',160805),
		( N'5286', N'201811',194139),
		( N'5800', N'201806',362545),
		( N'5800', N'201807',249282),
		( N'5800', N'201808',102698),
		( N'5800', N'201809',170906),
		( N'5800', N'201810',290216),
		( N'5800', N'201811',343939),
		( N'5930', N'201806',67427),
		( N'5930', N'201807',46011),
		( N'5930', N'201808',104905),
		( N'5930', N'201809',68906),
		( N'5930', N'201810',60128),
		( N'5930', N'201811',70349),
		( N'6910', N'201806',2532652),
		( N'6910', N'201807',1910285),
		( N'6910', N'201808',2342997),
		( N'6910', N'201809',2549711),
		( N'6910', N'201810',1914525),
		( N'6910', N'201811',2883175),
		( N'7530', N'201806',211639),
		( N'7530', N'201807',23870),
		( N'7530', N'201808',195460),
		( N'7530', N'201809',343020),
		( N'7530', N'201810',238510),
		( N'7530', N'201811',249098)

	EXEC tSQLt.AssertEqualsTable '#expected', '#actual';
END;