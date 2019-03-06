


CREATE VIEW [Finance].[d_Account]
AS

SELECT  GLAccount_key
       ,AccountCode				= GLAccountCode
       ,Account					= IIF(GLAccount_key = -1, GLAccountName, GLAccountCode + ' ' + GLAccountName)
       ,AccountGroup			= GLAccountGroup
       ,AccountType				= GLAccountType 
	   ,AccountHierarchy1Code   = GLAccountHierarchy1Code
	   ,AccountHierarchy1Name	= GLAccountHierarchy1Name
	   ,AccountHierarchy2Code	= GLAccountHierarchy2Code 
	   ,AccountHierarchy2Name	= GLAccountHierarchy2Name
	   ,AccountHierarchy3Code	= GLAccountHierarchy3Code 
	   ,AccountHierarchy3Name	= GLAccountHierarchy3Name
FROM    Fact.d_GLAccount