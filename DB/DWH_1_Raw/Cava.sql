EXEC dbo.sp_addlinkedserver @server = N'Cava', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'SEBOT0001-IS5\SEBOT0001IS5'

GO

EXEC dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Cava',@useself=N'False',@locallogin=NULL,@rmtuser=N'dw_service',@rmtpassword='rHXnVByjQ6k7C9WH'