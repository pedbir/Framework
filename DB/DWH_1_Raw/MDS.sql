EXECUTE sp_addlinkedserver @server = N'MDS', @srvproduct=N'SQLServer', @provider=N'SQLNCLI11', @datasrc=N'Ipo-dw-dev-2'

GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname=N'MDS',@useself=N'false',@locallogin=NULL,@rmtuser='MDS_LinkedServer',@rmtpassword='cChtCwzBK6hzY9GiMgwV'

GO
