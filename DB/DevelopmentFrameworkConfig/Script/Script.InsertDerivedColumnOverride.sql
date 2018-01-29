
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
--UNION ALL SELECT 24, N'dwInit', N'SysDateTimeDeletedUTC', N'ISNULL([SysDatetimeDeletedUTC])? [SysDatetimeDeletedUTC] : (DT_DBTIMESTAMP2,0)(SUBSTRING((DT_WSTR,100)GETUTCDATE(),1,19))', N'datetime', NULL, NULL, NULL
UNION ALL SELECT 24, N'dwInit', N'SysDateTimeDeletedUTC', N'[SysDatetimeDeletedUTC]', N'datetime', NULL, NULL, NULL



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
