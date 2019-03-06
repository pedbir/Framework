
EXEC dbo.sp_addlinkedserver @server = N'DWH_PROD', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'STO-DB-04', @catalog = 'DWH_3_Fact'
GO
EXEC dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DWH_PROD',@useself=N'False',@locallogin=NULL,@rmtuser='DWH_UnitTest_Read',@rmtpassword='I.GO&?JW_gwo+*8UT#Dz2YBG^yh]OsYLrPI'
GO