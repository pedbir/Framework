CREATE VIEW Finance.d_LegalEntity
AS
SELECT LegalEntity_key
      ,LegalEntityCode = LegalEntity_bkey
      ,LegalEntity = LegalEntityName       
FROM [Fact].[d_LegalEntity]