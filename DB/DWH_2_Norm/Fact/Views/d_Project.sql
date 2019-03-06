CREATE VIEW Fact.d_Project
AS
SELECT np.Project_key
      ,np.SysDatetimeDeletedUTC
      ,np2.SysModifiedUTC
      ,np.SysIsInferred
      ,np.SysValidFromDateTime
      ,np.SysSrcGenerationDateTime
      ,np.Project_bkey
      ,np2.ProjectCode
      ,np2.ProjectName      
      ,np2.Status
      ,np2.UpdatedBy
FROM Norm.n_Project np
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_Project np2 WHERE np2.Project_bkey = np.Project_bkey ORDER BY np2.SysValidFromDateTime DESC) np2