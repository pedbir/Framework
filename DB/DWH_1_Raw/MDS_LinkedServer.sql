EXEC dbo.sp_addlinkedserver @server = N'MDS', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'STO-BIT-01'
GO	
EXEC dbo.sp_addlinkedsrvlogin @rmtsrvname=N'MDS',@useself=N'False',@locallogin=NULL,@rmtuser=N'MDS_LinkedServer',@rmtpassword='6xpWtG14ZjKif70G38XD'