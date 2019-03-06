CREATE VIEW Sales.d_CustomerSupportEmployee
AS
SELECT  dcse.CustomerSupportEmployee_key       
       ,Employee         = IIF(dcse.CustomerSupportEmployee_key = -1, 'N/A', dcse.FirstName + ' ' + dcse.SurName)
	   ,EmployeedAccount = ISNULL(dcse.UserName, 'N/A')
       ,EmployeeEmail    = ISNULL(dcse.PrimaryEmailAddress, 'N/A')
FROM    Fact.d_CustomerSupportEmployee dcse