




CREATE VIEW [Norm_d].[AgreementService]
AS
SELECT  SysValidFromDateTime         
        , SysSrcGenerationDateTime		
        , SysDatetimeDeletedUTC					
        , SysModifiedUTC					
        , AgreementService_bkey					= OrderService_bkey
		, Agreement_bkey						= ISNULL(OrderID, -1)
		, Service_bkey							= ISNULL(ServiceID, -1)
		, ServiceStatus_bkey					= ISNULL(ServicestatusID, -1)
		, Unit_bkey								= ISNULL(UnitID, -1)
		, Site_bkey								= ISNULL(SiteID, -1)
		, Connection_bkey						= ISNULL(ConnectionID, '-1') 
		, FirstInvoiceDate						= FirstInvoiceDate
		, InstallationReadyDate					= InstallationReady
		, LastInvoiceDate						= LastInvoiceDate
		, TerminationNoticeDate					= TerminationNoticeDate
		, ReplaceNoticeDate						= ReplaceNoticeDate
		, Currency								= LTRIM(RTRIM(ISNULL(Currency, 'N/A')))
		, MRC									= ISNULL(MRCC, 0)
		, NRC									= ISNULL(NRCC, 0)
		, Quantity								= ISNULL(Cap, 0)
		, IsReneg								= ISNULL(IsReneg, 0)
FROM    Cava_RawTyped.r_OrderService o
WHERE   o.OrderService_bkey <> '-1'