
CREATE VIEW [Finance].[d_Project]
AS
SELECT Project_key      
      ,ProjectCode
      ,Project = IIF(Project_key = -1, ProjectCode, ProjectCode  + ' ' + ProjectName )
FROM [Fact].[d_Project]