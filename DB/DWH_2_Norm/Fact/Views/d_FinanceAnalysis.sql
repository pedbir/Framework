
CREATE VIEW Fact.d_FinanceAnalysis
AS
SELECT nfa.FinanceAnalysis_key
      ,nfa.SysDatetimeDeletedUTC
      ,nfa2.SysModifiedUTC
      ,nfa.SysIsInferred
      ,nfa.SysValidFromDateTime
      ,nfa.SysSrcGenerationDateTime
      ,nfa.FinanceAnalysis_bkey
      ,nfa2.FinanceAnalysisCode
      ,nfa2.FinanceAnalysisName      
      ,nfa2.Status
      ,nfa2.UpdatedBy
FROM Norm.n_FinanceAnalysis nfa
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_FinanceAnalysis nfa2 WHERE nfa2.FinanceAnalysis_bkey = nfa.FinanceAnalysis_bkey ORDER BY nfa2.SysValidFromDateTime DESC) nfa2