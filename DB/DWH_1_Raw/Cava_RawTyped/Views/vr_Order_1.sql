CREATE VIEW Cava_RawTyped.vr_Order AS
							WITH temp AS (SELECT *, _isLast = LEAD(0,1,1) OVER (PARTITION BY Order_bkey ORDER BY SysValidFromDateTime) FROM   Cava_RawTyped.r_Order)
							SELECT  t1.Order_key, t2.SysExecutionLog_key, t2.SysDatetimeInsertedUTC, t2.SysDatetimeUpdatedUTC, t2.SysDatetimeDeletedUTC, t2.SysModifiedUTC, t2.SysIsInferred, t2.SysValidFromDateTime, t2.SysSrcGenerationDateTime, t2.Order_bkey, t2.CustomerID, t2.CompanyID, t2.TypeID, t2.OrderNumber, t2.NRCC, t2.MRCC, t2.Currency, t2.InitialTerm, t2.ArrivalDate, t2.InstallationReady, t2.OrderEstimatedMRC, t2.TotalMRCofReplacedOrder, t2.Salesuser, t2.OrderadminID, t2.AdditionalRenegotiatedMonths, t2.ReasonID, t1._isLast
							FROM temp t1 
							INNER JOIN temp t2 ON t2.Order_bkey = t1.Order_bkey AND t2._isLast = 1