


EXECUTE sp_addlinkedserver @server = N'DW_SERVER', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'Localhost'

GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname=N'DW_SERVER',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL

GO

