CREATE VIEW Fact.d_AllocationPrinciple
AS

SELECT nap.AllocationPrinciple_key
      ,nap.SysDatetimeDeletedUTC
      ,nap2.SysModifiedUTC
      ,nap.SysIsInferred
      ,nap.SysValidFromDateTime
      ,nap.SysSrcGenerationDateTime
      ,nap2.AllocationPrinciple_bkey
      ,nap2.AllocationPrincipleName 
FROM Norm.n_AllocationPrinciple nap
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_AllocationPrinciple nap2 WHERE nap2.AllocationPrinciple_bkey = nap.AllocationPrinciple_bkey ORDER BY nap2.SysValidFromDateTime DESC) nap2