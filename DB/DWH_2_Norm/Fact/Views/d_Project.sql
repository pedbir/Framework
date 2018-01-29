CREATE VIEW Fact.d_Project
AS

SELECT  np.Project_key
        , np.SysDatetimeDeletedUTC
        , np.SysModifiedUTC
        , np.SysIsInferred
        , np.SysValidFromDateTime
        , np.SysSrcGenerationDateTime
        , np.Project_bkey
        , ProjectName = ISNULL(np.ProjectName, 'Unknown')
        , ProgramID   = ISNULL(np.ProgramID, 'N/A')
        , Category1ID = ISNULL(np.Category1ID, 'N/A')
        , Category2ID = ISNULL(np.Category2ID, 'N/A')
        , np.PlanFinish
        , np.CloseDate
FROM    Norm.n_Project np