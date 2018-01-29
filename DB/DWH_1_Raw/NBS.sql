EXEC dbo.sp_addlinkedserver @server = N'NBS', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'iponbs2'

GO

EXEC dbo.sp_addlinkedsrvlogin @rmtsrvname=N'NBS',@useself=N'False',@locallogin=NULL,@rmtuser=N'dw_service',@rmtpassword='rHXnVByjQ6k7C9WH'