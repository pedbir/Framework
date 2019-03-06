IF (EXISTS (SELECT * FROM MDS.INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'MDM' AND  TABLE_NAME = 'SegmentLeaf'))
BEGIN    
	DROP TABLE MDS.mdm.SegmentLeaf 
END

CREATE TABLE #temptable ( [ID] int, [MUID] uniqueidentifier, [VersionName] nvarchar(50), [VersionNumber] int, [Version_ID] int, [VersionFlag] nvarchar(50), [Name] nvarchar(250), [Code] nvarchar(250), [ChangeTrackingMask] int, [SourceSystem_Code] nvarchar(250), [SourceSystem_Name] nvarchar(250), [SourceSystem_ID] int, [CategoryCode] nvarchar(100), [SegmentGolden_Code] nvarchar(250), [SegmentGolden_Name] nvarchar(250), [SegmentGolden_ID] int, [Category] nvarchar(100), [EnterDateTime] datetime2(3), [EnterUserName] nvarchar(100), [EnterVersionNumber] int, [LastChgDateTime] datetime2(3), [LastChgUserName] nvarchar(100), [LastChgVersionNumber] int, [ValidationStatus] nvarchar(250), [State] nvarchar(250) )
SELECT * 
INTO MDS.mdm.SegmentLeaf 
FROM #temptable 

DROP TABLE #temptable 


IF (EXISTS (SELECT * FROM MDS.INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'MDM' AND  TABLE_NAME = 'SegmentGolden'))
BEGIN    
	DROP TABLE MDS.mdm.SegmentGolden 
END

CREATE TABLE #temptable1 ( [ID] int, [MUID] uniqueidentifier, [VersionName] nvarchar(50), [VersionNumber] int, [Version_ID] int, [VersionFlag] nvarchar(50), [Name] nvarchar(250), [Code] nvarchar(250), [ChangeTrackingMask] int, [CategoryCode] nvarchar(100), [Category] nvarchar(100), [EnterDateTime] datetime2(3), [EnterUserName] nvarchar(100), [EnterVersionNumber] int, [LastChgDateTime] datetime2(3), [LastChgUserName] nvarchar(100), [LastChgVersionNumber] int, [ValidationStatus] nvarchar(250), [State] nvarchar(250) )
SELECT * 
INTO MDS.mdm.SegmentGolden 
FROM #temptable1

DROP TABLE #temptable1 