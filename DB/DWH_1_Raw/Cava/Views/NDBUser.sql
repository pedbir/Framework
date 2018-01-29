
CREATE VIEW [Cava].[NDBUser]
AS

SELECT	SysValidFromDateTime			= CAST(GETUTCDATE() AS DATETIME2(0))
		, SysSrcGenerationDateTime		= CAST(Created AS DATETIME2(0))
		, SysDatetimeDeletedUTC			= CAST(null AS DATETIME2(0))
		, SysModifiedUTC				= CAST(GETUTCDATE() AS DATETIME2(0))
		, NDBUser_bkey					= CONVERT(NVARCHAR(50), UserName)
		, NDBUserID						= CONVERT(INT, NDBUserID)
		, ObjectGUID					= CONVERT(uniqueidentifier, ObjectGUID)
		, FirstName						= CONVERT(NVARCHAR(50), FirstName)
		, LastName						= CONVERT(NVARCHAR(50), LastName)
		, Active						= CONVERT(BIT, Active)
		, Email							= CONVERT(NVARCHAR(150), Email)
		, MobilePhone					= CONVERT(NVARCHAR(100), MobilePhone)
		, TelephoneNumber				= CONVERT(NVARCHAR(100), TelephoneNumber)
		, Department					= CONVERT(NVARCHAR(250), Department)
		, Title							= CONVERT(NVARCHAR(250), Title)
FROM    OPENQUERY(Cava, '
SELECT 
	   [NDBUserID]
      ,[ObjectGUID]
      ,[UserName]
      ,[FirstName]
      ,[LastName]
      ,[Active]
      ,[Email]
      ,[MobilePhone]
      ,[Department]
      ,[TelephoneNumber]
      ,[Title]
      ,[Created]
      ,[deleted]
FROM [NDB].[dbo].[NDBUser]
WHERE ISNULL(Deleted, 0) = 0
') oq;