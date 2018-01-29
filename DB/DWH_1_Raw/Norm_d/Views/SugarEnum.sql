CREATE VIEW Norm_d.SugarEnum
AS

SELECT SysDatetimeDeletedUTC = CASE WHEN re.Deleted = 1 THEN GETUTCDATE() ELSE NULL END
     , re.SysModifiedUTC
     , re.SysIsInferred
     , re.SysValidFromDateTime
     , re.SysSrcGenerationDateTime
     , SugarEnum_bkey = CAST(UPPER(LTRIM(RTRIM(re.ModuleName + '#' + re.ModuleField + '#' + re.FieldKey))) AS NVARCHAR(250))
     , re.FieldValue
FROM Sugar_RawTyped.r_Enum re
WHERE re.Enum_bkey <> '-1'