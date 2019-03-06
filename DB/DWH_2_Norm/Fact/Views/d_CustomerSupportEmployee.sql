CREATE VIEW Fact.d_CustomerSupportEmployee
AS

SELECT ncse.CustomerSupportEmployee_key
      ,ncse0.SysDatetimeDeletedUTC
      ,ncse0.SysModifiedUTC
      ,ncse.SysIsInferred
      ,ncse.SysValidFromDateTime
      ,ncse.SysSrcGenerationDateTime
      ,ncse.CustomerSupportEmployee_bkey
      ,ncse0.UserName
      ,ncse0.FirstName
      ,ncse0.SurName
      ,ncse0.PrimaryEmailAddress 
FROM Norm.n_CustomerSupportEmployee ncse
OUTER APPLY (SELECT TOP 1 ncse0.* FROM Norm.n_CustomerSupportEmployee ncse0 WHERE ncse0.CustomerSupportEmployee_bkey = ncse.CustomerSupportEmployee_bkey ORDER BY ncse0.SysValidFromDateTime DESC) ncse0