


CREATE VIEW Finance.d_Currency
AS
SELECT Currency_key
      ,CurrencyISOCode = Currency_bkey
      ,Currency = CurrencyName 
FROM [Fact].[d_Currency]