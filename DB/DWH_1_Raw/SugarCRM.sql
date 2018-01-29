

EXECUTE sp_addlinkedserver @server = N'SUGAR', @srvproduct=N'MySQL ODBC 5.3 ANSI Driver', @provider=N'MSDASQL', @datasrc=N'sugar'

GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname=N'SUGAR',@useself=N'False',@locallogin=NULL,@rmtuser=N'dw_service',@rmtpassword='rHXnVByjQ6k7C9WH'

Go