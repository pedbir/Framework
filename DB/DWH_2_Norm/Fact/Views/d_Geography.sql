

CREATE VIEW [Fact].[d_Geography]
AS

SELECT ng.Geography_key
     , ng.SysDatetimeDeletedUTC
     , ng.SysModifiedUTC
     , ng.SysIsInferred
     , ng.SysValidFromDateTime
     , ng.SysSrcGenerationDateTime
     , ng.Geography_bkey
     , ng.GeographyName
     , SugarEnum_Municipality_key		= SugarEnum_Municipality_bkey.SugarEnum_key
	 , SugarEnum_State_key				= SugarEnum_State_bkey.SugarEnum_key
	 , SugarEnum_Region_key				= SugarEnum_Region_bkey.SugarEnum_key
FROM Norm.n_Geography ng
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = ng.SugarEnum_Municipality_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_Municipality_bkey
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = ng.SugarEnum_State_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_State_bkey
CROSS APPLY (SELECT TOP 1 * FROM Norm.n_SugarEnum nse WHERE nse.SugarEnum_bkey = ng.SugarEnum_Region_bkey ORDER BY nse.SysValidFromDateTime DESC) SugarEnum_Region_bkey