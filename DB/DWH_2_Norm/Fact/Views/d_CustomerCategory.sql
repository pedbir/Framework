CREATE VIEW Fact.d_CustomerCategory
AS

SELECT	ncc.CustomerCategory_key
		, ncc.SysModifiedUTC
		, ncc.SysValidFromDateTime
		, ncc.SysSrcGenerationDateTime
		, ncc.SysDatetimeDeletedUTC
		, ncc.CustomerCategory_bkey
		, ncc.CustomerCategoryCode
		, ncc.CustomerCategory
		, ncc.SalesHierarchy
FROM	Norm.n_CustomerCategory ncc