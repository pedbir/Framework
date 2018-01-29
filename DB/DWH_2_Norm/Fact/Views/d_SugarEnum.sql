CREATE VIEW Fact.d_SugarEnum
AS

SELECT nse.SugarEnum_key
     , nse.SysDatetimeDeletedUTC
     , nse.SysModifiedUTC
     , nse.SysIsInferred
     , nse.SysValidFromDateTime
     , nse.SysSrcGenerationDateTime
     , nse.SugarEnum_bkey
     , nse.FieldValue 
FROM Norm.n_SugarEnum nse