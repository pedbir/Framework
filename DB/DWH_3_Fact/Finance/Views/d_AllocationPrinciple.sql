CREATE VIEW Finance.d_AllocationPrinciple
AS
SELECT dap.AllocationPrinciple_key
      ,AllocationPrincipleCode = dap.AllocationPrinciple_bkey
      ,AllocationPrinciple = dap.AllocationPrincipleName 
FROM Fact.d_AllocationPrinciple dap
WHERE dap.AllocationPrinciple_key <> -1