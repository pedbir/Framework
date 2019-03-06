CREATE VIEW Finance.d_Counterparty
AS
SELECT FinanceCounterparty_key
      ,CounterpartyCode = FinanceCounterpartyCode
      ,CounterpartyName = FinanceCounterpartyName      
FROM [Fact].[d_FinanceCounterparty]