

/*
SELECT 'UNION SELECT '
	  ,'''' + [ConfigurationFilter]+ ''','
      ,'''' + [ConfiguredValue]+ ''','
      ,'''' + [PackagePath]+ ''','
      ,'''' + [ConfiguredValueType]+ ''''
  FROM [dbo].[SSISConfigurations]
*/



TRUNCATE TABLE dbo.SSISConfigurations

INSERT INTO dbo.SSISConfigurations(ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
SELECT 			'DWH_3_Fact',	'Data Source=localhost;Initial Catalog=DWH_3_Fact;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;',	'\Package.Connections[DWH_3_Fact].Properties[ConnectionString]',	'String'
UNION SELECT 	'DWH_2_Norm',	'Data Source=localhost;Initial Catalog=DWH_2_Norm;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;',	'\Package.Connections[DWH_2_Norm].Properties[ConnectionString]',	'String'
UNION SELECT 	'DWH_1_Raw',	'Data Source=localhost;Initial Catalog=DWH_1_Raw;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;',	'\Package.Connections[DWH_1_Raw].Properties[ConnectionString]',	'String'
UNION SELECT	'SSAS_Server',	'Data Source=localhost;PROVIDER=MSOLAP;Impersonation Level=Impersonate;',	'\Package.Connections[SSAS_Server].Properties[ConnectionString]',	'String'
UNION SELECT 	'DWH_0_MDM',	'Data Source=localhost;Initial Catalog=DWH_0_MDM;Provider=SQLNCLI11.1;Integrated Security=SSPI;Auto Translate=False;',	'\Package.Connections[DWH_0_MDM].Properties[ConnectionString]',	'String'
UNION SELECT 	'MoveFileWhenComplete',	'true',	'\Package.Variables[User::MoveFileWhenComplete].Properties[Value]',	'Boolean'

UNION SELECT 	'ConvertExcelToCsv_ArchiveFolderPath',	'C:\DW\se_credit_deposits\Archive\RawExcel',	'\Package.Variables[User::ConvertExcelToCsv_ArchiveFolderPath].Properties[Value]',	'String'
UNION SELECT 	'ConvertExcelToCsv_DestinationFolderPath',	'C:\DW\se_credit_deposits\Source',	'\Package.Variables[User::ConvertExcelToCsv_DestinationFolderPath].Properties[Value]',	'String'
UNION SELECT 	'ConvertExcelToCsv_ErrorFolderPath',	'C:\DW\se_credit_deposits\Error\RawExcel',	'\Package.Variables[User::ConvertExcelToCsv_ErrorFolderPath].Properties[Value]',	'String'
UNION SELECT 	'ConvertExcelToCsv_SourceFolderPath',	'C:\DW\se_credit_deposits\Source\RawExcel',	'\Package.Variables[User::ConvertExcelToCsv_SourceFolderPath].Properties[Value]',	'String'
UNION SELECT 	'ConvertExcelToCsv_ExeFilePath',	'C:\Users\pedram.birounvand\Source\Repos\Datawarehouse\ConsoleApplication1\ConsoleApplication1\bin\Debug\ConvertExcelToCsv.exe',	'\Package.Variables[User::ConvertExcelToCsv_ExeFilePath].Properties[Value]',	'String'
UNION SELECT 	'Deposit_ArchiveFolderPath',	'C:\DW\se_credit_deposits\Archive',	'\Package.Variables[User::Deposit_ArchiveFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Deposit_SourceFolderPath',	'C:\DW\se_credit_deposits\Source',	'\Package.Variables[User::Deposit_SourceFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Deposit_ErrorFolderPath',	'C:\DW\se_credit_deposits\Error',	'\Package.Variables[User::Deposit_ErrorFolderPath].Properties[Value]',	'String'
