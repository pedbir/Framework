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