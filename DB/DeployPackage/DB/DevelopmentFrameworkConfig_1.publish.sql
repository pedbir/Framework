﻿/*
Deployment script for DevelopmentFrameworkConfig

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DWH_2_Norm "DWH_2_Norm"
:setvar DWH_3_Fact "DWH_3_Fact"
:setvar DatabaseName "DevelopmentFrameworkConfig"
:setvar DefaultFilePrefix "DevelopmentFrameworkConfig"
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

GO

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


SELECT id = 1, SQLServer = N'bigint', SSIS = N'DT_I8', Biml = N'Int64', DataTypeGroup = N'Numeric'
INTO #DataTypeTranslation 
UNION ALL SELECT 2, N'binary', N'DT_BYTES', N'Binary', N'Binary'
UNION ALL SELECT 3, N'bit', N'DT_BOOL', N'Boolean', N'Boolean'
UNION ALL SELECT 4, N'char', N'DT_STR', N'AnsiStringFixedLength', N'Text'
UNION ALL SELECT 5, N'date', N'DT_DBDATE', N'Date', N'Date'
UNION ALL SELECT 6, N'datetime', N'DT_DBTIMESTAMP', N'DateTime', N'Date'
UNION ALL SELECT 7, N'datetime2', N'DT_DBTIMESTAMP2', N'DateTime2', N'Date'
UNION ALL SELECT 8, N'datetimeoffset', N'DT_DBTIMESTAMPOFFSET', N'DateTimeOffset', N'Date'
UNION ALL SELECT 9, N'decimal', N'DT_DECIMAL', N'Decimal', N'Numeric'
UNION ALL SELECT 10, N'float', N'DT_R8', N'Double', N'Numeric'
UNION ALL SELECT 11, N'image', N'DT_IMAGE', N'Binary', N'Binary'
UNION ALL SELECT 12, N'int', N'DT_I4', N'Int32', N'Numeric'
UNION ALL SELECT 13, N'money', N'DT_CY', N'Currency', N'Numeric'
UNION ALL SELECT 14, N'nchar', N'DT_WSTR', N'StringFixedLength', N'Text'
UNION ALL SELECT 15, N'ntext', N'DT_NTEXT', N'String', N'Text'
UNION ALL SELECT 16, N'numeric', N'DT_NUMERIC', N'Decimal', N'Numeric'
UNION ALL SELECT 17, N'nvarchar', N'DT_WSTR', N'String', N'Text'
UNION ALL SELECT 18, N'real', N'DT_R4', N'Single', N'Numeric'
UNION ALL SELECT 19, N'smalldatetime', N'DT_DBTIMESTAMP', N'DateTime', N'Date'
UNION ALL SELECT 20, N'smallint', N'DT_I2', N'Int16', N'Numeric'
UNION ALL SELECT 21, N'smallmoney', N'DT_CY', N'Currency', N'Numeric'
UNION ALL SELECT 22, N'sql_variant', N'DT_WSTR', N'Object', N'Object'
UNION ALL SELECT 23, N'text', N'DT_TEXT', N'AnsiString', N'Text'
UNION ALL SELECT 24, N'time', N'DT_DBTIME2', N'Time', N'Date'
UNION ALL SELECT 25, N'tinyint', N'DT_UI1', N'Byte', N'Numeric'
UNION ALL SELECT 26, N'uniqueidentifier', N'DT_GUID', N'Guid', N'Guid'
UNION ALL SELECT 27, N'varbinary', N'DT_BYTES', N'Binary', N'Binary'
UNION ALL SELECT 28, N'varchar', N'DT_STR', N'AnsiString', N'Text'
UNION ALL SELECT 29, N'xml', N'DT_WSTR', N'Xml', N'XML'


SET IDENTITY_INSERT Metadata.DataTypeTranslation ON

INSERT Metadata.DataTypeTranslation (Id, SQLServer, SSIS, Biml, DataTypeGroup)
SELECT dtt.id
       , dtt.SQLServer
       , dtt.SSIS
       , dtt.Biml
       , dtt.DataTypeGroup
FROM   #DataTypeTranslation dtt
WHERE  dtt.id NOT IN (SELECT Id FROM Metadata.DataTypeTranslation)

SET IDENTITY_INSERT Metadata.DataTypeTranslation OFF



SELECT 3 [Id], N'dwInfFK' [DerivedColumnType], N'HistoryRecId' [DerivedColumnName], N'-1' [OverrideValue], N'bigint' [DataType], N'Extended field in Stage. To be populated in DW for missing Foreign Key members' [Comment], NULL [ApplicableTable], NULL [MaxLength]
INTO #DerivedColumnOverride
UNION ALL SELECT 6, N'dwInfFK', N'SourceSystemKey', N'-1', N'int', NULL, NULL, NULL
UNION ALL SELECT 13, N'dwError', N'DateTimeError', N'GETUTCDATE()', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 14, N'dwError', N'DWID', N'@[User::DWID]', N'int', NULL, NULL, NULL
UNION ALL SELECT 15, N'dwError', N'PackageName', N'@[System::PackageName]', N'nvarchar', NULL, NULL, 100
UNION ALL SELECT 16, N'dwError', N'SourceTableName', N'<<DynamicValue>>', N'nvarchar', NULL, NULL, 50
UNION ALL SELECT 17, N'dwError', N'RowData', N'<<DynamicValue>>', N'nvarchar', NULL, NULL, 4000
UNION ALL SELECT 18, N'dwInf', N'SysIsInferred', N'1', NULL, NULL, NULL, NULL
UNION ALL SELECT 19, N'dwInfFK', N'SysSrcGenerationDateTime', N'(DT_DBTIMESTAMP2, 0) ((DT_DBDATE)"1900-01-01")', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 20, N'dwInfFK', N'SysValidFromDateTime', N'(DT_DBTIMESTAMP2,0)(SUBSTRING((DT_WSTR,100)GETUTCDATE(),1,19))', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 21, N'dwInfFK', N'SysDatetimeInsertedUTC', N'(DT_DBTIMESTAMP2,0)(SUBSTRING((DT_WSTR,100)GETUTCDATE(),1,19))', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 22, N'dwInfFK', N'SysModifiedUTC', N'(DT_DBTIMESTAMP2,0)(SUBSTRING((DT_WSTR,100)GETUTCDATE(),1,19))', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 24, N'dwInit', N'SysDateTimeDeletedUTC', N'ISNULL([SysDatetimeDeletedUTC])? [SysDatetimeDeletedUTC] : (DT_DBTIMESTAMP2,0)(SUBSTRING((DT_WSTR,100)GETUTCDATE(),1,19))', N'datetime', NULL, NULL, NULL



SET IDENTITY_INSERT [Metadata].[DerivedColumnOverride] ON 

INSERT INTO Metadata.DerivedColumnOverride
        (Id 
		, DerivedColumnType
        , DerivedColumnName
        , OverrideValue
        , DataType
        , Comment
        , ApplicableTable
        , MaxLength )
SELECT dco.Id
     , dco.DerivedColumnType
     , dco.DerivedColumnName
     , dco.OverrideValue
     , dco.DataType
     , dco.Comment
     , dco.ApplicableTable
     , dco.MaxLength 
FROM #DerivedColumnOverride dco
WHERE dco.Id NOT IN (SELECT dco2.Id FROM Metadata.DerivedColumnOverride dco2)

SET IDENTITY_INSERT [Metadata].[DerivedColumnOverride] OFF


SELECT N'All' AS GroupName
INTO #DestinationTableGroup
UNION SELECT N'Datamart objects'
UNION SELECT N'Dimension'
UNION SELECT N'Fact'

INSERT INTO Metadata.DestinationTableGroup
        ( GroupName )
SELECT dtg.GroupName
FROM #DestinationTableGroup dtg
WHERE dtg.GroupName NOT IN (SELECT dtg2.GroupName FROM Metadata.DestinationTableGroup dtg2)

SELECT Id = 1
       , StagingEnvironmentName = 'DWH_1_Raw'
       , NormEnvironmentName = 'DWH_2_Norm'
       , MartEnvironmentName = 'DWH_3_Fact'
       , DefaultTableCompressionType = 'PAGE'
       , DefaultSSISIncrementalLoad = 1
       , DefaultSSISConfigurationFrameWorkCatalog = N'DWH_0_Admin'
       , DefaultDtsConfigEnvironmentVariableName = N'J_dwautogen_SSISAdminConfig'
       , DefaultNormLayerIndexStorageLocation = N'Norm_Index'
       , DefaultNormLayerDataStorageLocation = N'Norm_Data'
       , DefaultMartLayerIndexStorageLocation = N'Fact_Index'
       , DefaultMartLayerDataStorageLocation = N'Fact_Data'
       , RawEnvironmentName = 'DWH_1_Raw'
       , DefaultRawLayerIndexStorageLocation = 'PRIMARY'
       , DefaultRawLayerDataStorageLocation = 'PRIMARY'
INTO #EnvironmentVariables


SET IDENTITY_INSERT [Metadata].[EnvironmentVariables] ON

INSERT INTO Metadata.EnvironmentVariables
        (id 
		, StagingEnvironmentName
        , NormEnvironmentName
        , MartEnvironmentName
        , DefaultTableCompressionType
        , DefaultSSISIncrementalLoad
        , DefaultSSISConfigurationFrameWorkCatalog
        , DefaultDtsConfigEnvironmentVariableName
        , DefaultNormLayerIndexStorageLocation
        , DefaultNormLayerDataStorageLocation
        , DefaultMartLayerIndexStorageLocation
        , DefaultMartLayerDataStorageLocation
        , RawEnvironmentName
        , DefaultRawLayerIndexStorageLocation
        , DefaultRawLayerDataStorageLocation )
SELECT ev.Id
     , ev.StagingEnvironmentName
     , ev.NormEnvironmentName
     , ev.MartEnvironmentName
     , ev.DefaultTableCompressionType
     , ev.DefaultSSISIncrementalLoad
     , ev.DefaultSSISConfigurationFrameWorkCatalog
     , ev.DefaultDtsConfigEnvironmentVariableName
     , ev.DefaultNormLayerIndexStorageLocation
     , ev.DefaultNormLayerDataStorageLocation
     , ev.DefaultMartLayerIndexStorageLocation
     , ev.DefaultMartLayerDataStorageLocation
     , ev.RawEnvironmentName
     , ev.DefaultRawLayerIndexStorageLocation
     , ev.DefaultRawLayerDataStorageLocation 
FROM #EnvironmentVariables ev
WHERE ev.Id NOT IN (SELECT ev2.Id FROM Metadata.EnvironmentVariables ev2)

SET IDENTITY_INSERT [Metadata].[EnvironmentVariables] OFF


SELECT	null as ID,
        null as [COLUMN_NAME] ,
        null as  [DATA_TYPE] ,
        null as  [CHARACTER_MAXIMUM_LENGTH] ,
        null as  [DATETIME_PRECISION] ,
        null as  [ORDINAL_POSITION] ,
        null as  [NUMERIC_PRECISION] ,
        null as  [NUMERIC_SCALE] ,
        null as  [IS_NULLABLE] ,
        null as  [IncludeInChecksum_src] ,
        null as  [TableColumnSpecification] ,
        null as  [IsIdentity] ,
        null as  [CreateColumnIndex] ,
        null as  [SourceTableCatalog] ,
        null as  [DestinationTableCatalog] ,
        null as  [DestinationSchemaName] ,
        null as  [ApplicableTable] ,
        null as  [SSISDataType] ,
        null as  [SSISDataTypeLength] ,
        null as  [SSISColumnSpecification] ,
        null as  [SetFieldOnInsert] ,
        null as  [SetFieldOnUpdate] ,
        null as  [SetFieldOnDelete] ,
        null as  [GroupName]
INTO #DestinationFieldExtended
UNION ALL SELECT 1, N'SysIsInferred', N'bit', NULL, NULL, 9700, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'Boolean', NULL, N'0', 1, 1, 0, 'Dimension' 
UNION ALL SELECT 2, N'SysExecutionLog_key', N'int', NULL, NULL, 1003, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'Int32', NULL, N'@[User::SysExecutionLog_key]', 1, 1, 1, 'All' 
UNION ALL SELECT 3, N'SysDatetimeReprocessedUTC', N'datetime2', NULL, 0, 1007, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, NULL, 0, 0, 0, 'All' 
UNION ALL SELECT 4, N'SysIsInferred', N'bit', NULL, NULL, 9700, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'Boolean', NULL, N'0', 1, 1, 0, 'Dimension' 
UNION ALL SELECT 5, N'SysExecutionLog_key', N'int', NULL, NULL, 1003, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'Int32', NULL, N'@[User::SysExecutionLog_key]', 1, 1, 1, 'All' 
UNION ALL SELECT 6, N'SysDatetimeInsertedUTC', N'datetime2', NULL, 0, 1004, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 0, 0, 'All' 
UNION ALL SELECT 7, N'SysDatetimeUpdatedUTC', N'datetime2', NULL, 0, 1005, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 1, 0, 'All' 
UNION ALL SELECT 8, N'SysDatetimeDeletedUTC', N'datetime2', NULL, 0, 1006, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 0, 1, 'All' 
UNION ALL SELECT 9, N'SysModifiedUTC', N'datetime2', NULL, 0, 9500, NULL, NULL, 'NO', 0, NULL, 0, 1, N'DWH_1_Raw', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 1, 1, 'All' 
UNION ALL SELECT 10, N'SysDatetimeInsertedUTC', N'datetime2', NULL, 0, 1004, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 0, 0, 'All' 
UNION ALL SELECT 11, N'SysDatetimeUpdatedUTC', N'datetime2', NULL, 0, 1005, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 1, 0, 'All' 
UNION ALL SELECT 12, N'SysDatetimeDeletedUTC', N'datetime2', NULL, 0, 1006, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 0, 1, 'All' 
UNION ALL SELECT 13, N'SysModifiedUTC', N'datetime2', NULL, 0, 9500, NULL, NULL, 'NO', 0, NULL, 0, 1, N'DWH_2_Norm', N'DWH_2_Norm', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 1, 1, 'All' 
UNION ALL SELECT 14, N'SysIsInferred', N'bit', NULL, NULL, 9700, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'Boolean', NULL, N'0', 1, 1, 0, 'Dimension' 
UNION ALL SELECT 15, N'SysExecutionLog_key', N'int', NULL, NULL, 1003, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'Int32', NULL, N'@[User::SysExecutionLog_key]', 1, 1, 1, 'All' 
UNION ALL SELECT 16, N'SysDatetimeInsertedUTC', N'datetime2', NULL, 0, 1004, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 0, 0, 'All' 
UNION ALL SELECT 17, N'SysDatetimeUpdatedUTC', N'datetime2', NULL, 0, 1005, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 1, 0, 'All' 
UNION ALL SELECT 18, N'SysDatetimeDeletedUTC', N'datetime2', NULL, 0, 1006, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 0, 0, 1, 'All' 
UNION ALL SELECT 19, N'SysModifiedUTC', N'datetime2', NULL, 0, 9500, NULL, NULL, 'NO', 0, NULL, 0, 1, N'DWH_1_Raw', N'DWH_1_Raw', N'-', NULL, N'DateTime', NULL, N'(DT_DBTIMESTAMP2,0)GETUTCDATE()', 1, 1, 1, 'All' 
UNION ALL SELECT 20, N'SysExecutionLog_key', N'int', NULL, NULL, 1003, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_3_Fact', N'-', NULL, N'Int32', NULL, N'@[User::SysExecutionLog_key]', 1, 1, 1, 'All' 
UNION ALL SELECT 21, N'SysDatetimeInsertedUTC', N'datetime2', NULL, 0, 1004, NULL, NULL, 'NO', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_3_Fact', N'-', NULL, N'DateTime', NULL, N'@[User::SysDatetimeInsertedUTC]', 1, 0, 0, 'All' 
UNION ALL SELECT 22, N'SysDatetimeUpdatedUTC', N'datetime2', NULL, 0, 1005, NULL, NULL, 'YES', 0, NULL, 0, 0, N'DWH_2_Norm', N'DWH_3_Fact', N'-', NULL, N'DateTime', NULL, N'@[User::SysDatetimeUpdatedUTC]', 0, 1, 0, 'All' 
UNION ALL SELECT 23, N'SysModifiedUTC', N'datetime2', NULL, 0, 9500, NULL, NULL, 'NO', 0, NULL, 0, 1, N'DWH_2_Norm', N'DWH_3_Fact', N'-', NULL, N'DateTime', NULL, N'@[User::SysModifiedUTC]', 1, 1, 1, 'All' 



SET IDENTITY_INSERT [Metadata].[DestinationFieldExtended] ON  


INSERT INTO Metadata.DestinationFieldExtended
        ( ID
		, COLUMN_NAME
        , DATA_TYPE
        , CHARACTER_MAXIMUM_LENGTH
        , DATETIME_PRECISION
        , ORDINAL_POSITION
        , NUMERIC_PRECISION
        , NUMERIC_SCALE
        , IS_NULLABLE
        , IncludeInChecksum_src
        , TableColumnSpecification
        , IsIdentity
        , CreateColumnIndex
        , SourceTableCatalog
        , DestinationTableCatalog
        , DestinationSchemaName
        , ApplicableTable
        , SSISDataType
        , SSISDataTypeLength
        , SSISColumnSpecification
        , SetFieldOnInsert
        , SetFieldOnUpdate
        , SetFieldOnDelete
        , GroupName )
SELECT dfe.ID
     , dfe.COLUMN_NAME
     , dfe.DATA_TYPE
     , dfe.CHARACTER_MAXIMUM_LENGTH
     , dfe.DATETIME_PRECISION
     , dfe.ORDINAL_POSITION
     , dfe.NUMERIC_PRECISION
     , dfe.NUMERIC_SCALE
     , dfe.IS_NULLABLE
     , dfe.IncludeInChecksum_src
     , dfe.TableColumnSpecification
     , dfe.IsIdentity
     , dfe.CreateColumnIndex
     , dfe.SourceTableCatalog
     , dfe.DestinationTableCatalog
     , dfe.DestinationSchemaName
     , dfe.ApplicableTable
     , dfe.SSISDataType
     , dfe.SSISDataTypeLength
     , dfe.SSISColumnSpecification
     , dfe.SetFieldOnInsert
     , dfe.SetFieldOnUpdate
     , dfe.SetFieldOnDelete
     , dfe.GroupName 
FROM #DestinationFieldExtended dfe
WHERE dfe.ID NOT IN (SELECT ID FROM [Metadata].[DestinationFieldExtended])
AND dfe.ID IS NOT NULL

SET IDENTITY_INSERT [Metadata].[DestinationFieldExtended] OFF



GO

GO
PRINT N'Update complete.';


GO
