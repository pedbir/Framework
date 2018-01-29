CREATE VIEW Norm_d.Customer
AS
SELECT	c.SysDatetimeDeletedUTC
		, c.SysModifiedUTC
		, c.SysValidFromDateTime
		, c.SysSrcGenerationDateTime
		, Customer_bkey				= CAST(c.Customer_bkey AS NVARCHAR(100))
		, CustomerName				= CAST(c.FullName AS NVARCHAR(255))
		, PersonalIdentityNumber	= CAST('N/A' AS NVARCHAR(20))
		, OrganizationNumber		= CAST(ISNULL(NULLIF(c.OrgNo, ''), 'Unknown') AS NVARCHAR(50))
		, Age						= NULL
		, Gender					= 'Unknow'
FROM	Cava_RawTyped.r_Customer c
WHERE	c.Customer_bkey <> -1
UNION ALL
SELECT	rb.SysDatetimeDeletedUTC
		, rb.SysModifiedUTC
		, rb.SysValidFromDateTime
		, rb.SysSrcGenerationDateTime
		, Customer_bkey			 = rb.Bestallning_bkey
		, CustomerName			 = CAST(rb.Fornamnc + ' ' + rb.Efternamnc AS NVARCHAR(255))
		, PersonalIdentityNumber = CAST(ISNULL(NULLIF(rb.Personnummerc, ''), 'N/A') AS NVARCHAR(20))
		, OrganizationNumber	 = CAST(ISNULL(NULLIF(rb.Orgnummerc, ''), 'N/A') AS NVARCHAR(50))
		, Age					 = DATEDIFF(YEAR
											,	TRY_CAST(LEFT(CASE WHEN LEN(rb.Personnummerc) = 0 THEN NULL
																	WHEN LEFT(rb.Personnummerc, 2) = '19'
																		OR	LEFT(rb.Personnummerc, 2) = '20' THEN rb.Personnummerc ELSE '19' + rb.Personnummerc END, 8) AS DATE)
											, GETDATE())
		, Gender				 = CASE WHEN LEN(LTRIM(RTRIM(ISNULL(rb.Orgnummerc, '')))) > 0 THEN 'Unknown'
										WHEN LEN(rb.Personnummerc) = 0 THEN NULL
										WHEN LEFT(RIGHT(rb.Personnummerc, 2), 1) IN ( '1', '3', '5', '7', '9' ) THEN 'Male' ELSE 'Female' END
FROM	Sugar_RawTyped.r_Bestallning rb
WHERE	rb.Bestallning_bkey <> '-1'