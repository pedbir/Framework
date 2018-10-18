﻿/*
Deployment script for DWH_0_Admin

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DWH_0_Admin"
:setvar DefaultFilePrefix "DWH_0_Admin"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
-- Test
/*
IF 'Local' = '$(Environment)'
BEGIN
PRINT '***** Creating Test Data for UTV Enviroment *****';
:r .\Script.InsertConfigurationLocal.sql

END
*/




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

GO

GO
PRINT N'Update complete.';


GO