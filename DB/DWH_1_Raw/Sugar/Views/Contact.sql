

CREATE VIEW Sugar.Contact
AS
SELECT  SysValidFromDateTime       = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , Contact_bkey             = CONVERT(NVARCHAR(100), Id)
        , deleted                  = CONVERT(INT, deleted)
        , FirstName                = CONVERT(NVARCHAR(100), first_name)
        , LastName                 = CONVERT(NVARCHAR(100), last_name)
        , Title                    = CONVERT(NVARCHAR(100), Title)
        , ContactDescription       = CONVERT(NVARCHAR(500), description)
        , AssignedUserId           = CONVERT(NVARCHAR(100), assigned_user_id)
FROM    OPENQUERY (SUGAR, '
SELECT 	id
	, date_entered
    , date_modified
    , deleted
	, first_name
	, last_name
    , title
    , description
    , assigned_user_id
FROM contacts;
'   ) AS oq;