CREATE VIEW Norm_d.Agreement
AS
SELECT  SysValidFromDateTime         
        , SysSrcGenerationDateTime		
        , SysDatetimeDeletedUTC					
        , SysModifiedUTC					
        , Agreement_bkey						= Order_bkey
		, Customer_bkey							= CAST(ISNULL(CustomerID, '-1') AS NVARCHAR(100))
		, Employee_SalesPerson_bkey				= LTRIM(RTRIM(ISNULL(UPPER(SalesUser), '-1')))
		, AgreementType_bkey					= ISNULL(TypeID, -1)
		, OrderNumber							= ISNULL(OrderNumber, 'N/A')
		, AgreementDate							= ArrivalDate
FROM    Cava_RawTyped.r_Order o
WHERE   o.Order_bkey <> '-1'