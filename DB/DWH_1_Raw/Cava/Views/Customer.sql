CREATE VIEW [Cava].[Customer]
AS

SELECT  SysValidFromDateTime = CAST(GETUTCDATE() AS DATETIME2(0))
      , SysSrcGenerationDateTime = CAST(CreatedDate AS DATETIME2(0))
      , SysDatetimeDeletedUTC = CAST(null AS DATETIME2(0))
      , SysModifiedUTC = CAST(GETUTCDATE() AS DATETIME2(0))

      , Customer_bkey = CONVERT(INT, CustomerID)
	  , FullName = CONVERT(NVARCHAR(255), Full_name)
	  , OrgNo = CONVERT(NVARCHAR(255), [Org no])
	  , SuperOfficeUser = CONVERT(NVARCHAR(50), SuperOfficeUser)
	  , SegmentID = CONVERT(INT, SegmentID)
	  , MasterSystemID = CONVERT(NVARCHAR(50), MasterSystemID)
--select *
FROM    OPENQUERY(Cava, '
SELECT 
	CustomerID
	, CreatedDate
	, Full_name
	, [Org no]
	, SuperOfficeUser
	, SegmentID
	, MasterSystemID
FROM [NDB].[dbo].[Customer]
') oq;