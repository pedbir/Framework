

CREATE VIEW Sugar.[User]
AS
SELECT  SysValidFromDateTime       = CAST(date_modified AS DATETIME2(0))
        , SysSrcGenerationDateTime = CAST(date_entered AS DATETIME2(0))
        , SysDatetimeDeletedUTC    = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC           = CAST(GETUTCDATE() AS DATETIME2(0))
        , User_bkey                = CONVERT(NVARCHAR(100), Id)
        , Username                 = CONVERT(NVARCHAR(100), user_name)
        , Deleted                  = CONVERT(INT, deleted)
        , FirstName                = CONVERT(NVARCHAR(30), first_name)
        , LastName                 = CONVERT(NVARCHAR(30), last_name)
        , Title                    = CONVERT(NVARCHAR(50), Title)
        , Department               = CONVERT(NVARCHAR(50), Department)
        , EmployeeStatus           = CONVERT(NVARCHAR(100), employee_status)
FROM    OPENQUERY (SUGAR
                   , '
SELECT 
	id
	, user_name
    , date_entered
    , date_modified
    , deleted
	, first_name
	, last_name
    , title
    , department
    , employee_status
FROM users;
'   ) AS oq;