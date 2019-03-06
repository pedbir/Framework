/*This is project codes in agresso. This list contains both new and old project that are not activ.*/


CREATE VIEW Norm.Project
AS

SELECT 	SysValidFromDateTime = CAST(Lastupdate AS DATETIME2(0))
		,SysModifiedUTC
		,SysDatetimeDeletedUTC
		,SysSrcGenerationDateTime	
		,Project_bkey = CAST(DimValue + '#' + Client AS NVARCHAR(100))
		,ProjectCode = DimValue
		,ProjectName = DimDescription
		,LegalEntity_bkey = Client					
		,Status
		,UpdatedBy = Userid					
FROM Agresso_RawTyped.vrt_Dimension_01
WHERE Attributeid = 'B0'