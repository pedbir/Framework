-- =============================================
--
-- Author:		
-- Create date: 2016-06-05
-- Description:	
-- Example:	
--
--
-- =============================================
CREATE FUNCTION [Metadata].[GetSSASProcessingPatternString] (@SSISPackageGUID NVARCHAR(128))
RETURNS NVARCHAR(max)
AS
BEGIN
	DECLARE @CRLF NVARCHAR(10) = NCHAR(13)
		,@TAB NVARCHAR(1) = NCHAR(9)
		,@SQL NVARCHAR(max)

	SET @SQL = @TAB + '-- Declare XMLA variables' + @CRLF
	SET @SQL = @SQL + @TAB + 'DECLARE @XMLAScript varchar(max) = ''''' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + '-- Process dimensions' + @CRLF
	SET @SQL = @SQL + @TAB + 'DECLARE cTemp CURSOR FOR' + @CRLF
	SET @SQL = @SQL + @TAB + '	select XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	from [Tabular].[DimensionProcessingXMLA]' + @CRLF
	SET @SQL = @SQL + @TAB + '	order by 1' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'OPEN cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'WHILE @@FETCH_STATUS = 0' + @CRLF
	SET @SQL = @SQL + @TAB + '	BEGIN' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '			EXECUTE(@XMLAScript) AT TabularModel' + @CRLF
	SET @SQL = @SQL + @TAB + '		END TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '			GOTO DimensionProcessingError' + @CRLF
	SET @SQL = @SQL + @TAB + '		END CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '		FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	END' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'DEALLOCATE cTemp' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + '-- Create measure group partitions' + @CRLF
	SET @SQL = @SQL + @TAB + 'DECLARE cTemp CURSOR FOR' + @CRLF
	SET @SQL = @SQL + @TAB + '	select XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	from [Tabular].[PartitionCreationXMLA]' + @CRLF
	SET @SQL = @SQL + @TAB + '	order by 1' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'OPEN cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'WHILE @@FETCH_STATUS = 0' + @CRLF
	SET @SQL = @SQL + @TAB + '	BEGIN' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '			EXECUTE(@XMLAScript) AT TabularModel' + @CRLF
	SET @SQL = @SQL + @TAB + '		END TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '			GOTO PartitionCreateError' + @CRLF
	SET @SQL = @SQL + @TAB + '		END CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '		FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	END' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'DEALLOCATE cTemp' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + '-- Process fact table partitions' + @CRLF
	SET @SQL = @SQL + @TAB + 'DECLARE cTemp CURSOR FOR' + @CRLF
	SET @SQL = @SQL + @TAB + '	select XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	from [Tabular].[FactProcessingXMLA]' + @CRLF
	SET @SQL = @SQL + @TAB + '	order by 1' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'OPEN cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'WHILE @@FETCH_STATUS = 0' + @CRLF
	SET @SQL = @SQL + @TAB + '	BEGIN' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '			EXECUTE(@XMLAScript) AT TabularModel' + @CRLF
	SET @SQL = @SQL + @TAB + '		END TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '			GOTO PartitionProcessingError' + @CRLF
	SET @SQL = @SQL + @TAB + '		END CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '		FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	END' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '-- Re-Calculate Tabular Database' + @CRLF
	SET @SQL = @SQL + @TAB + 'DECLARE cTemp CURSOR FOR' + @CRLF
	SET @SQL = @SQL + @TAB + '	select XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	from [Tabular].[TabularDatabaseReCalculationXMLA]' + @CRLF
	SET @SQL = @SQL + @TAB + '	order by 1' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'OPEN cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'WHILE @@FETCH_STATUS = 0' + @CRLF
	SET @SQL = @SQL + @TAB + '	BEGIN' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '			EXECUTE(@XMLAScript) AT TabularModel' + @CRLF
	SET @SQL = @SQL + @TAB + '		END TRY' + @CRLF
	SET @SQL = @SQL + @TAB + '		BEGIN CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '			GOTO ReCalculationError' + @CRLF
	SET @SQL = @SQL + @TAB + '		END CATCH' + @CRLF
	SET @SQL = @SQL + @TAB + '		FETCH NEXT FROM cTemp into @XMLAScript' + @CRLF
	SET @SQL = @SQL + @TAB + '	END' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + 'GOTO AllSuccess' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'DimensionProcessingError:' + @CRLF
	SET @SQL = @SQL + @TAB + [Metadata].[GetLogEndPatternString](@SSISPackageGUID) + '		, @Status = ''Failure''' + @CRLF
	SET @SQL = @SQL + @TAB + '	CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	RAISERROR(N''Error called on Linked Server (Dimension Processing Error)'',16,1)' + @CRLF
	SET @SQL = @SQL + @TAB + '	RETURN;' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'PartitionCreateError:' + @CRLF
	SET @SQL = @SQL + @TAB + [Metadata].[GetLogEndPatternString](@SSISPackageGUID) + '		, @Status = ''Failure''' + @CRLF
	SET @SQL = @SQL + @TAB + '	CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	RAISERROR(N''Error called on Linked Server (Partition Creation Error)'',16,1)' + @CRLF
	SET @SQL = @SQL + @TAB + '	RETURN;' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'PartitionProcessingError:' + @CRLF
	SET @SQL = @SQL + @TAB + [Metadata].[GetLogEndPatternString](@SSISPackageGUID) + '		, @Status = ''Failure''' + @CRLF
	SET @SQL = @SQL + @TAB + '	CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	RAISERROR(N''Error called on Linked Server (Partition Processing Error)'',16,1)' + @CRLF
	SET @SQL = @SQL + @TAB + '	RETURN;' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'ReCalculationError:' + @CRLF
	SET @SQL = @SQL + @TAB + [Metadata].[GetLogEndPatternString](@SSISPackageGUID) + '		, @Status = ''Failure''' + @CRLF
	SET @SQL = @SQL + @TAB + '	CLOSE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	DEALLOCATE cTemp' + @CRLF
	SET @SQL = @SQL + @TAB + '	RAISERROR(N''Error called on Linked Server (Re-Calculation Error)'',16,1)' + @CRLF
	SET @SQL = @SQL + @TAB + '	RETURN;' + @CRLF + @CRLF
	SET @SQL = @SQL + @TAB + 'AllSuccess:' + @CRLF
	SET @SQL = @SQL + @TAB + '	-- Just move on' + @CRLF

	RETURN @SQL
END