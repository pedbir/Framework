
CREATE VIEW [CityNetwork].[d_Employee_SalesResponsible]
AS

SELECT	Employee_SalesResponsible_key		= de.Employee_key
		, SalesResponsible					= ISNULL(de.EmployeeName, 'N/A')
FROM	[$(DWH_3_Fact)].Fact.d_Employee de