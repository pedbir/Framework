


CREATE VIEW [Norm_d].[Opportunity]
AS
SELECT	SysValidFromDateTime = rm.SysValidFromDateTime
		, SysSrcGenerationDateTime = rm.SysSrcGenerationDateTime
		, SysDatetimeDeletedUTC = CASE WHEN rm.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
		, SysModifiedUTC = rm.SysModifiedUTC
		, Opportunity_bkey = rm.Mojlighet_bkey
		, Area_bkey = ISNULL(rm.Ipomradeipmojligheteripomradeida, '-1')
		, Access_bkey = ISNULL(rm.Netadminaddressidc, -1)
		, Address_bkey = ISNULL(NULLIF(CONVERT(NVARCHAR(100), rm.Adressmasteridc), '-1'), rm.Mojlighet_bkey)
		, Employee_SalesResponsible_bkey = ISNULL(rm.ContactsIpMojligheter1ContactsIda, '-1')
		, OpportunityName = rm.Name
		, SugarEnum_BusinessType_bkey = CAST(ISNULL(UPPER(LTRIM(RTRIM('IP_Mojligheter#kundtyp_c#' + NULLIF(rm.Kundtypc, '')))), '-1') AS NVARCHAR(250))
		, CustomerType = CAST(UPPER(LTRIM(RTRIM(rm.Tjanstetypc))) AS NVARCHAR(150))
		, rm.Fastighetsbeteckningc
		, AcquiredAccess = CASE rm.Forvarvadhpc WHEN 'Nej' THEN 'No'
												WHEN 'Ja' THEN 'Yes' ELSE 'Unknown' END
FROM	Sugar_RawTyped.r_Mojlighet rm
WHERE	rm.Mojlighet_bkey <> '-1'