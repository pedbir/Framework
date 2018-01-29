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


