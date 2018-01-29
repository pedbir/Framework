CREATE VIEW Fact.d_AccessCategory
AS

SELECT nac.AccessCategory_key
		 , nac.SysDatetimeDeletedUTC
		 , nac.SysModifiedUTC
		 , nac.SysIsInferred
		 , nac.SysValidFromDateTime		 
		 , nac.AccessCategory_bkey
		 , nac.AccessCategory 
FROM Norm.n_AccessCategory nac