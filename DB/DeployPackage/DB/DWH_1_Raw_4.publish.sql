﻿/*
Deployment script for DWH_1_Raw

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DevelopmentFrameworkConfig "v"
:setvar DatabaseName "DWH_1_Raw"
:setvar DefaultFilePrefix "DWH_1_Raw"
:setvar DefaultDataPath "E:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "E:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\"

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
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

--TRUNCATE TABLE [Manual_RawTyped].[rt_ReportStructure_01]
GO

GO
PRINT N'Creating [MDS]...';


GO
EXECUTE sp_addlinkedserver @server = N'MDS', @srvproduct = N'SQLServer', @provider = N'SQLNCLI11', @datasrc = N'Ipo-dw-dev-2';


GO
PRINT N'Creating [MDS]...';


GO
EXECUTE sp_addlinkedsrvlogin @rmtsrvname = N'MDS';


GO
PRINT N'Creating [Sugar_RawTyped].[r_Mojlighet].[IX_Netadminaddressidc]...';


GO
CREATE NONCLUSTERED INDEX [IX_Netadminaddressidc]
    ON [Sugar_RawTyped].[r_Mojlighet]([Netadminaddressidc] ASC, [SysValidFromDateTime] DESC);


GO
PRINT N'Altering [Norm_d].[Access]...';


GO

ALTER VIEW [Norm_d].[Access]
AS

SELECT ra.SysDatetimeDeletedUTC
     , ra.SysModifiedUTC     
     , ra.SysValidFromDateTime
     , ra.SysSrcGenerationDateTime    
	 , Access_bkey = ra.Adress_bkey     
     , Calenar_Installed_bkey = CAST(ra.ipo_installed_date AS DATETIME)
	 , Opportunity_bkey = CAST(ISNULL(rm.Mojlighet_bkey, '-1') AS NVARCHAR(100))	 
     , AccessCategory_Lvl1_bkey = ISNULL(NULLIF(ra.adrkodid1, 0), -1)
     , AccessCategory_Lvl2_bkey = ISNULL(NULLIF(ra.adrkodid2, 0), -1)
     , AccessCategory_Lvl3_bkey = ISNULL(NULLIF(ra.adrkodid3, 0), -1)
     , AccessCategory_Lvl4_bkey = ISNULL(NULLIF(ra.adrkodid4, 0), -1)
     , AccessCategory_Lvl5_bkey = ISNULL(NULLIF(ra.adrkodid5, 0), -1)
FROM Netadmin_RawTyped.r_Adress ra
OUTER APPLY (SELECT TOP 1 rm.Mojlighet_bkey FROM Sugar_RawTyped.r_Mojlighet rm WHERE rm.Netadminaddressidc = ra.Adress_bkey ORDER BY rm.SysValidFromDateTime DESC) rm
WHERE ra.Adress_bkey <> -1
GO
PRINT N'Altering [Norm_d].[CustomerCategory]...';


GO
ALTER VIEW Norm_d.CustomerCategory
AS
SELECT  SysDatetimeDeletedUTC         = CAST(NULL AS DATETIME2(0))
        , SysModifiedUTC              = CAST(LastChgDateTime AS DATETIME2(0))
        , SysValidFromDateTime        = CAST(LastChgDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime    = CAST(EnterDateTime AS DATETIME2(0))
        , CustomerCategory_bkey       = cc.ID
		, CustomerCategoryCode		= cc.Code
        , CustomerCategory = cc.Name
        , SalesHierarchy
        , SugarEnum_BusinessType_bkey = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.BusinessType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_AreaType_bkey     = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.AreaType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_OrderType_bkey    = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.OrderType))) AS NVARCHAR(100)), ''), '%')
        , OpportunityCustomerType     = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.OpportunityCustomerType))) AS NVARCHAR(100)), ''), '%')
        , SugarEnum_SubsidyArea_bkey  = ISNULL(NULLIF(CAST(UPPER(LTRIM(RTRIM(cc.SubsidyArea))) AS NVARCHAR(100)), ''), '%')
FROM OPENQUERY(MDS, 'SELECT * FROM DWH_0_MDM.[mdm].[CustomerCategory]') cc
GO
PRINT N'Creating [Norm_d].[Planning]...';


GO

CREATE VIEW Norm_d.Planning
AS


SELECT  SysDatetimeDeletedUTC         = CAST(IIF(State = 'Deleted', LastChgDateTime, NULL) AS DATETIME2(0))
        , SysModifiedUTC              = CAST(LastChgDateTime AS DATETIME2(0))
        , SysValidFromDateTime        = CAST(LastChgDateTime AS DATETIME2(0))
        , SysSrcGenerationDateTime    = CAST(EnterDateTime AS DATETIME2(0))
		, Planning_bkey = ID
		 , Scenario_bkey = Scenario_Code
		 , Phase_bkey = Phase_Code
		 , CustomerCategory_bkey = CustomerCategory_ID
		 , P01
		 , P02
		 , P03
		 , P04
		 , P05
		 , P06
		 , P07
		 , P08
		 , P09
		 , P10
		 , P11
		 , P12
FROM OPENQUERY(MDS, 'SELECT * FROM DWH_0_MDM.[mdm].[Planning]') oq
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

TRUNCATE TABLE [ManualData].[CustomerCategory]

SET IDENTITY_INSERT [ManualData].[CustomerCategory] ON 

GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (1, N'SDU Urban', N'SDU Urban', N'IP_MOJLIGHETER#KUNDTYP_C#SDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-S', N'', N'IP_OMRADE#TYP_AV_ORT_C#TATORT', N'<>IP_BESTALLNING#BESTALLNINGSTYP_C#EFTERBESTALLNING', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (2, N'SDU Urban', N'SDU Urban Upsell', N'IP_MOJLIGHETER#KUNDTYP_C#SDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-S', N'', N'IP_OMRADE#TYP_AV_ORT_C#TATORT', N'=IP_BESTALLNING#BESTALLNINGSTYP_C#EFTERBESTALLNING', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (3, N'SDU Rural', N'SDU Rural Commercial', N'IP_MOJLIGHETER#KUNDTYP_C#SDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-S', N'', N'IP_OMRADE#TYP_AV_ORT_C#GLESBYGD', N'<>IP_BESTALLNING#BESTALLNINGSTYP_C#EFTERBESTALLNING', N'IP_OMRADE#BIDRAGSOMRADE_C#NEJ')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (4, N'SDU Rural', N'SDU Rural Subsidies', N'IP_MOJLIGHETER#KUNDTYP_C#SDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-S', N'', N'IP_OMRADE#TYP_AV_ORT_C#GLESBYGD', N'<>IP_BESTALLNING#BESTALLNINGSTYP_C#EFTERBESTALLNING', N'IP_OMRADE#BIDRAGSOMRADE_C#JA_BEVILJAT, IP_OMRADE#BIDRAGSOMRADE_C#JA_ANSOKT  ')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (5, N'SDU Rural', N'SDU Rural Upsell', N'IP_MOJLIGHETER#KUNDTYP_C#SDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-S', N'', N'IP_OMRADE#TYP_AV_ORT_C#GLESBYGD', N'=IP_BESTALLNING#BESTALLNINGSTYP_C#EFTERBESTALLNING', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (6, N'MDU', N'MDU brf', N'IP_MOJLIGHETER#KUNDTYP_C#MDU,IP_MOJLIGHETER#KUNDTYP_C#SDU-R', N'Privat', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (7, N'MDU', N'MDU Byggherrar & Fast.äg.', N'IP_MOJLIGHETER#KUNDTYP_C#MDU-N,IP_MOJLIGHETER#KUNDTYP_C#SDU-N', N'', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (8, N'MDU', N'MDU Sthlm', N'IP_MOJLIGHETER#KUNDTYP_C#MDU-sthlm', N'Privat', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (9, N'MDU', N'Byalag', N'IP_MOJLIGHETER#KUNDTYP_C#SDU-FKA', N'', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (10, N'B2B', N'CORP-FKA', N'IP_MOJLIGHETER#KUNDTYP_C#CORP-FKA', N'', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (11, N'B2B', N'CORP', N'IP_MOJLIGHETER#KUNDTYP_C#CORP', N'', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (12, N'B2B', N'MDU företag', N'IP_MOJLIGHETER#KUNDTYP_C#MDU', N'Foretag', N'', N'', N'')
GO
INSERT [ManualData].[CustomerCategory] ([CustomerTypeCategoryID], [CustomerTypeCategory], [CustomerTypeCategoryDetail], [SugarEnum_BusinessType_bkey], [OpportunityCustomerType], [SugarEnum_AreaType_bkey], [SugarEnum_OrderType_bkey], [SugarEnum_SubsidyArea_bkey]) VALUES (13, N'B2B', N'MDU Sthlm företag', N'IP_MOJLIGHETER#KUNDTYP_C#MDU-sthlm', N'Foretag', N'', N'', N'')
GO
SET IDENTITY_INSERT [ManualData].[CustomerCategory] OFF
GO

GO
PRINT N'Update complete.';


GO
