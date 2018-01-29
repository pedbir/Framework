EXEC DevelopmentFrameworkConfig.Metadata.CreateNormEntity @source_DB = N'DWH_2_Norm' -- nvarchar(50)
                               , @dest_db = N'DWH_3_Fact' -- nvarchar(50)
                               , @source_schema = N'Fact' -- nvarchar(50)
                               , @dest_schema = N'Fact' -- nvarchar(50)
                               , @source_table = N'd_Geography' -- nvarchar(50)
                               , @BIP = N'' -- nvarchar(50)
                               , @GroupName = N'Dimension' 

