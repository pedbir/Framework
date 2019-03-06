





CREATE VIEW [Marketing].[f_FinanceMarketMetrics]
AS


SELECT  fgl.Vouchertype,
        fgl.Voucherno,
        fgl.Sequenceno,
        VoucherDescription		= fgl.GLDescription,
        InvoiceNo				= fgl.ExtInvoiceRef,
		ChannelCategory_key		= fgl.GLAccount_key,
		Channel_key				= fgl.Project_key,
		fgl.FinanceProduct_key,
		fgl.FinanceVendor_key,
		Period_key             = CAST(Calender_ReportingPeriod_bkey AS DATE),
		AmountLCY = CAST(fgl.AmountLCY AS MONEY),
        AmountTCY = CAST(fgl.AmountTCY AS MONEY)
FROM    Fact.f_GeneralLedger fgl
INNER JOIN Fact.d_GLAccount ga ON fgl.GLAccount_key = ga.GLAccount_key
INNER JOIN Fact.d_Project fdp ON fdp.Project_key = fgl.Project_key
WHERE   fgl.LegalEntity_bkey = 'BFAB' 
AND     ga.GLAccountCode LIKE  '59%'
AND fdp.ProjectCode NOT IN ('1082','1083','1084','1085','1086','5059','5060','5061','5062','5063','5064','5065','5066','5067','5069','5070','5071','5072','5073','5074','5075','6015','6018')