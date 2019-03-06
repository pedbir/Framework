CREATE VIEW Finance.d_CostCenter
AS
SELECT CostCenter_key
      ,CostCenterCode
      ,CostCenter
      ,CostCenterManagerCode
      ,CostCenterManger
      ,SecondLineApproverCode
      ,SecondLineApprover
      ,DepartmentCode
      ,Department 
FROM [Fact].[d_CostCenter]