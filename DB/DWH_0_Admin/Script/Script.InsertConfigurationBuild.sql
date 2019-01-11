

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

UNION SELECT 	'Agresso_SourceFolderPath',		'C:\DW\Agresso\Data',		'\Package.Variables[User::Agresso_SourceFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Agresso_ArchiveFolderPath',	'C:\DW\Agresso\Archive',	'\Package.Variables[User::Agresso_ArchiveFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Agresso_ErrorFolderPath',		'C:\DW\Agresso\Error',	'\Package.Variables[User::Agresso_ErrorFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Agresso_NoOfPeriods',			'3',	'\Package.Variables[User::Agresso_NoOfPeriods].Properties[Value]',	'String'
UNION SELECT 	'Agresso_LastUpdateDaysOffset',	'',	'\Package.Variables[User::Agresso_LastUpdateDaysOffset].Properties[Value]',	'String'

UNION SELECT 	'Manual_ArchiveFolderPath',	'C:\DW\Manual\Archive',	'\Package.Variables[User::Manual_ArchiveFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Manual_SourceFolderPath',	'C:\DW\Manual\Data',	'\Package.Variables[User::Manual_SourceFolderPath].Properties[Value]',	'String'
UNION SELECT 	'Manual_ErrorFolderPath',	'C:\DW\Manual\Error',	'\Package.Variables[User::Manual_ErrorFolderPath].Properties[Value]',	'String'

UNION SELECT 	'Agresso_ExecFilePath',			'C:\API\Agresso\AgressoAPI.exe'								,'\Package.Variables[User::Agresso_ExecFilePath].Properties[Value]',	'String'
