CREATE VIEW Finance.d_GLAccountLegalEntity
AS
SELECT dgale.GLAccountLegalEntity_key
      ,dgale.GLAccountLegalEntity_bkey      
FROM Fact.d_GLAccountLegalEntity dgale