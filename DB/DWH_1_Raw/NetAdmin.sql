
EXEC dbo.sp_addlinkedserver @server = N'NETADMIN', @srvproduct=N'MySQL ODBC 5.3 ANSI Driver', @provider=N'MSDASQL', @datasrc=N'netadmin'

GO

EXEC dbo.sp_addlinkedsrvlogin @rmtsrvname=N'NETADMIN',@useself=N'False',@locallogin=NULL,@rmtuser=N'bi_prod',@rmtpassword='NBoPh2nfJ61wZLLKdj5f'