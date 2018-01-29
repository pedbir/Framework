
CREATE PROC [Logging].[LogPackageFileExecutionEnd]
    @PackageID UNIQUEIDENTIFIER
    , @ExecutionID UNIQUEIDENTIFIER    
    , @RowsRead BIGINT
    , @RowsInserted BIGINT
    , @RowsUpdated BIGINT
    , @RowsDeleted BIGINT
    , @RowsIgnored BIGINT
    , @RowsError BIGINT
    , @SysFileName NVARCHAR(250)   
    , @SysExecutionLog_key INT
	, @PackageVersionId UNIQUEIDENTIFIER
AS
DECLARE @Status AS VARCHAR(30)

IF EXISTS (   SELECT TOP 1 *
              FROM   Logging.ExecutionEvent
              WHERE  EventType  = 'OnError'
                AND  ExecutionID = @ExecutionID)
BEGIN
    SET @Status = 'Failure'
END
ELSE
    SET @Status = 'Success'


	INSERT INTO Logging.PackageFileExecution (ExecutionID	                     
	                                  , ExecutionEnd
	                                  , SysFileName
	                                  , Status	                  
	                                  , RowsRead
	                                  , RowsInserted
	                                  , RowsUpdated
	                                  , RowsDeleted
	                                  , RowsIgnored
	                                  , RowsError
	                                  , SysExecutionLog_key
									  , PackageVersionId
									  , PackageId)
	VALUES (@ExecutionID 	        
	        , GETUTCDATE() 
	        , @SysFileName 
	        , @Status 	        
	        , @RowsRead 
	        , @RowsInserted 
	        , @RowsUpdated 
	        , @RowsDeleted 
	        , @RowsIgnored 
	        , @RowsError 
	        , @SysExecutionLog_key 
			, @PackageVersionId
			, @PackageID
	    )