

/*
**	Logs the end of a SSIS package execution
*/
CREATE PROC [Logging].[LogPackageEnd]
	@PackageID uniqueidentifier,
	@ExecutionID uniqueidentifier,
	@ExecutionEndTime datetime = NULL,
	@RowsRead bigint,
    @RowsInserted bigint,
    @RowsUpdated bigint,
    @RowsDeleted bigint,
    @RowsIgnored bigint,
    @RowsError bigint
AS
	
	DECLARE @Status as varchar(30)
	
	IF @ExecutionEndTime IS NULL
		SET @ExecutionEndTime = CURRENT_TIMESTAMP


	IF EXISTS (SELECT TOP 1 * FROM [Logging].ExecutionEvent
				WHERE EventType = 'OnError' AND
				ExecutionID = @ExecutionID)
	BEGIN
		SET @Status = 'Failure'
	END
	ELSE
		SET @Status = 'Success'

	IF EXISTS (SELECT TOP 1 * FROM [Logging].PackageFileExecution pfe WHERE pfe.ExecutionID = @ExecutionID)
		SELECT   @RowsDeleted = SUM(pfe.RowsDeleted)
				 , @RowsError = SUM(pfe.RowsError)
				 , @RowsIgnored = SUM(pfe.RowsIgnored)
				 , @RowsInserted = SUM(pfe.RowsInserted)
				 , @RowsRead = SUM(pfe.RowsRead)
				 , @RowsUpdated = SUM(pfe.RowsUpdated)
		FROM     Logging.PackageFileExecution pfe
		WHERE    pfe.ExecutionID = @ExecutionID
		GROUP BY pfe.ExecutionID


	UPDATE [Logging].PackageExecution
	SET ExecutionEnd = GETUTCDATE(), 
		[Status] = @Status,
		RowsRead = @RowsRead, 
		RowsInserted = @RowsInserted, 
		RowsUpdated = @RowsUpdated, 
		RowsDeleted = @RowsDeleted, 
		RowsIgnored = @RowsIgnored, 
		RowsError = @RowsError
	WHERE ExecutionID = @ExecutionID
