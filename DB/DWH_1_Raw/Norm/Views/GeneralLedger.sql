



CREATE VIEW [Norm].[GeneralLedger]
AS
SELECT  SysSrcGenerationDateTime
       ,SysModifiedUTC
       ,SysValidFromDateTime          = CAST(Lastupdate AS DATETIME2(0))
       ,SysDatetimeDeletedUTC
       ,GeneralLedger_bkey            = CAST(Client + '#' + CAST(Voucherno AS NVARCHAR(50)) + '#' + CAST(Sequenceno AS NVARCHAR(50)) AS NVARCHAR(250))
       ,Vouchertype
       ,Voucherno
       ,Sequenceno
       ,GLAccount_bkey                = CAST(CAST(ISNULL(Account, -1) AS NVARCHAR(50)) + '#' + ISNULL(Client, '-1') AS NVARCHAR(100))
       ,LegalEntity_bkey              = CAST(ISNULL(RTRIM(LTRIM(UPPER(Client))), '-1') AS NVARCHAR(100))
       ,Calender_Voucherdate_bkey     = Voucherdate
       ,Calender_ReportingPeriod_bkey = CAST(ISNULL(EOMONTH(TRY_CAST(CAST(PERIOD AS NVARCHAR(6)) + '01' AS DATE)), '1900-01-01') AS DATETIME)
       ,CostCenter_bkey               = CAST(CASE WHEN Dim1 IS NULL THEN '-1' ELSE  Dim1  + '#' + ISNULL(Client, '-1') END AS NVARCHAR(100))
	   ,Project_bkey                  = CAST(ISNULL(Dim2 + '#' + Client, '-1') AS NVARCHAR(100))
       ,FinanceProduct_bkey           = CAST(CASE Att3id WHEN 'ZZPR' THEN Dim3 + '#' + Client ELSE '-1' END AS NVARCHAR(100))
       ,FinanceAnalysis_bkey          = CAST(CASE Att3id WHEN 'F0' THEN Dim3 + '#' + Client ELSE '-1' END AS NVARCHAR(100))
       ,FinanceCounterparty_bkey      = CAST(ISNULL(Dim6 + '#' + Client, '-1') AS NVARCHAR(100))
       ,FinanceSegment_bkey           = CAST(ISNULL(Dim7 + '#' + Client, '-1') AS NVARCHAR(100))
       ,FinanceCustomer_bkey          = CAST(CASE Apartype WHEN 'R' THEN Aparid + '#' + Client ELSE '-1' END AS NVARCHAR(100))
       ,FinanceVendor_bkey            = CAST(CASE Apartype WHEN 'P' THEN Aparid + '#' + Client ELSE '-1' END AS NVARCHAR(100))
       ,GLAccountLegalEntity_bkey     = CAST(CAST(ISNULL(Account, -1) AS NVARCHAR(50)) + '#' + ISNULL(Client, '-1') AS NVARCHAR(100))
       ,Currency_bkey                 = Currency
       ,GLDescription                 = Description
       ,ExtInvoiceRef                 = Extinvref
       ,AmountLCY                     = Amount
       ,AmountTCY                     = Curamount
FROM    Agresso_RawTyped.vrt_Huvudbok_01