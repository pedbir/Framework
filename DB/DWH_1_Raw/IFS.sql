EXECUTE sp_addlinkedserver @server = N'IFSPROD', @srvproduct=N'OracleOLEDB', @provider=N'OraOLEDB.Oracle', @datasrc=N'PROD'
GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname=N'IFSPROD',@useself=N'False',@locallogin=NULL,@rmtuser=N'ifs_reports',@rmtpassword='ifs1p0nly'
GO