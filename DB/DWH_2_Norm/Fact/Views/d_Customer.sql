CREATE VIEW Fact.d_Customer
AS

SELECT  nso.SysSrcGenerationDateTime
        , nso.SysValidFromDateTime
        , nso.SysModifiedUTC
        , nso.SysDatetimeDeletedUTC
        , Customer_key = nso.SalesOrder_key
        , CustomerName = nso.FirstName + ' ' + nso.Surname
        , nso.Email
        , nso.MobilePhoneNo
        , nso.PersonalIdentityNumber
        , nso.OrganizationNumber
        , nso.Age
        , nso.Gender
FROM    Norm.n_SalesOrder nso