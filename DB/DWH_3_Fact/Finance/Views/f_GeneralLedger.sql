
CREATE VIEW [Finance].[f_GeneralLedger]
AS
SELECT  Vouchertype
       ,Voucherno
       ,Sequenceno
       ,GLDescription
       ,ExtInvoiceRef
       ,Voucherdate_key        = CAST(Calender_Voucherdate_bkey AS DATE)
       ,Period_key             = CAST(Calender_ReportingPeriod_bkey AS DATE)
       ,GLAccount_key
       ,LegalEntity_key
       ,CostCenter_key
       ,Project_key
       ,FinanceProduct_key
       ,FinanceAnalysis_key
       ,FinanceCounterparty_key
       ,FinanceSegment_key
       ,FinanceCustomer_key
       ,FinanceVendor_key
       ,Currency_key
       ,AllocationPrinciple_key
       ,AmountLCY = CAST(AmountLCY AS MONEY)
       ,AmountTCY = CAST(AmountTCY AS MONEY)
	   ,GLAccountLegalEntity_key
FROM    Fact.f_GeneralLedger
UNION ALL
SELECT  Vouchertype = ''
       ,Voucherno= ''
       ,Sequenceno= ''
       ,GLDescription= ''
       ,ExtInvoiceRef= ''
       ,Voucherdate_key        = CAST('1900-01-01' AS DATE)
       ,Period_key             = CAST(Calender_ReportingPeriod_bkey AS DATE)
       ,GLAccount_key
       ,LegalEntity_key
       ,CostCenter_key
       ,Project_key
       ,FinanceProduct_key
       ,FinanceAnalysis_key
       ,FinanceCounterparty_key
       ,FinanceSegment_key
       ,FinanceCustomer_key
       ,FinanceVendor_key
       ,Currency_key
       ,AllocationPrinciple_key
       ,AmountLCY = CAST(AmountLCY AS MONEY)
       ,AmountTCY = CAST(AmountTCY AS MONEY)
	   ,GLAccountLegalEntity_key
FROM    Fact.f_GeneralLedgerAllocation fgla