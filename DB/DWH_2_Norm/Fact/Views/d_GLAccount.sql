




CREATE VIEW [Fact].[d_GLAccount]
AS

SELECT nga.GLAccount_key
      ,nga.SysDatetimeDeletedUTC
      ,nga2.SysModifiedUTC
      ,nga.SysIsInferred
      ,nga.SysSrcGenerationDateTime
      ,nga.SysValidFromDateTime
      ,nga.GLAccount_bkey
      ,nga2.GLAccountName
	  ,nga2.GLAccountGroupCode
      ,nga2.GLAccountGroup
      ,nga2.GLAccountType   
	  ,nga2.GLAccountCode
	  ,nga2.GLAccountHierarchy1Code
      ,nga2.GLAccountHierarchy1Name
      ,nga2.GLAccountHierarchy2Code
      ,nga2.GLAccountHierarchy2Name
      ,nga2.GLAccountHierarchy3Code
      ,nga2.GLAccountHierarchy3Name
      ,nga2.LegalEntity_bkey   
      ,nga2.Status
FROM Norm.n_GLAccount nga
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_GLAccount nga2 WHERE nga2.GLAccount_bkey = nga.GLAccount_bkey ORDER BY nga2.SysValidFromDateTime DESC) nga2