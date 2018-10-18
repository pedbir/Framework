﻿CREATE TABLE [Metadata].[DestinationTableFlatFileSource] (
    [SSISPackageName]           VARCHAR (128) NOT NULL,
    [SourceArea]                VARCHAR (128) NULL,
    [FilePattern]               VARCHAR (128) NULL,
    [ColumnNamesInFirstDataRow] INT           NULL,
    [HeaderRowsToSkip]          INT           NULL,
    [DataRowsToSkip]            INT           NULL,
    [FlatFileType]              VARCHAR (128) NULL,
    [HeaderRowDelimiter]        VARCHAR (128) NULL,
    [RowDelimiter]              VARCHAR (128) NULL,
    [ColumnDelimiter]           VARCHAR (128) NULL,
    [TextQualifer]              VARCHAR (128) NULL,
    [IsUnicode]                 INT           NULL,
    [CodePage]                  INT           NULL,
    [DestinationDatabaseName]   VARCHAR (128) NULL,
    [Locale]                    VARCHAR (128) NULL,
    [FileNameRegExDateTime]     VARCHAR (128) NULL,
    [FileNameDateTimePattern]   VARCHAR (128) NULL,
    [DestinationSchemaName]     VARCHAR (128) NULL,
    [DestinationTableName]      VARCHAR (128) NULL,
    [SourceRootFolder]          VARCHAR (250) NULL,
    [ExecProcAnnotation]        VARCHAR (MAX) NULL,
    [UserNameInserted]          VARCHAR (128) CONSTRAINT [DF_DestinationTableFlatFileSource_UserNameInserted] DEFAULT (suser_sname()) NULL,
    [DateTimeInsertedUTC]       DATETIME      CONSTRAINT [DF_DestinationTableFlatFileSource_DateTimeInsertedUTC] DEFAULT (getutcdate()) NULL,
    [UserNameUpdated]           VARCHAR (128) NULL,
    [DateTimeUpdatedUTC]        DATETIME      NULL,
    CONSTRAINT [PK_DestinationTableFlatFileSource] PRIMARY KEY CLUSTERED ([SSISPackageName] ASC)
);

