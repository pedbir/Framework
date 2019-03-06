
CREATE VIEW [Fact].[d_CostCenter]
AS

SELECT  ncc.CostCenter_key
       ,ncc.SysDatetimeDeletedUTC
       ,ncc.SysDatetimeReprocessedUTC
       ,ncc2.SysModifiedUTC
       ,ncc.SysIsInferred
       ,ncc.SysValidFromDateTime
       ,ncc.SysSrcGenerationDateTime
       ,ncc.CostCenter_bkey
       ,ncc2.CostCenterCode
       ,CostCenter = ncc2.CostCenterName       
       ,ncc2.Status
       ,ncc2.UpdatedBy
       ,ncc2.CostCenterManagerCode
       ,ncc2.CostCenterManger
       ,ncc2.SecondLineApproverCode
       ,ncc2.SecondLineApprover
       ,ncc2.DepartmentCode
       ,ncc2.Department
FROM    Norm.n_CostCenter ncc
OUTER APPLY (SELECT TOP 1 * FROM Norm.n_CostCenter ncc2 WHERE ncc2.CostCenter_bkey = ncc.CostCenter_bkey ORDER BY ncc2.SysValidFromDateTime DESC) ncc2