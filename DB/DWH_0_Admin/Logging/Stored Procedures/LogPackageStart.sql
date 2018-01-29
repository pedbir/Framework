

/*
**	Logs the start of a SSIS package
*/
CREATE PROC [Logging].[LogPackageStart]
    @PackageID UNIQUEIDENTIFIER
    , @PackageName VARCHAR(150)
    , @PackageDesc VARCHAR(250) = NULL
    , @VersionID UNIQUEIDENTIFIER
    , @VersionMajor SMALLINT
    , @VersionMinor SMALLINT
    , @VersionBuild INT
    , @VersionComments VARCHAR(250) = NULL
    , @CreationDate DATE
    , @CreatorName VARCHAR(50)
    , @CreatorComputerName VARCHAR(30)
    , @LocaleID INT
    , @ExecutionID UNIQUEIDENTIFIER
    , @ExecutionStartTime DATETIME
    , @ExecutionMachineName VARCHAR(30)
    , @ExecutionUserName VARCHAR(50)
    , @ProductVersion VARCHAR(15)
    , @InteractiveMode BIT
    , @SysBatchLogExecutionLog_key INT
    , @SysExecutionLog_key INT OUTPUT
	, @SourceTableCatalog VARCHAR(128) = ''
    , @SourceSchemaName VARCHAR(128)  = ''
    , @SourceTableName VARCHAR(128)  = ''
    , @DestinationTableCatalog VARCHAR(128) = ''
    , @DestinationSchemaName VARCHAR(128)  = ''
    , @DestinationTableName VARCHAR(128)  = ''
    , @SsisIncrementalLoad BIT  = 0
    , @SsisLoadType VARCHAR(20)  = ''
AS

	SET NOCOUNT ON

	-- Check if package already exist in DB, otehrwise add it to Package table
	IF NOT EXISTS (SELECT TOP 1 * FROM Package WHERE PackageID = @PackageID)
		INSERT INTO [Logging].Package 
			(PackageID, 
			 PackageName, 
			 PackageDescription)
		VALUES (@PackageID, @PackageName, @PackageDesc)
	
	ELSE
	-- Update name and description of the package if they are different
		UPDATE [Logging].Package 
		SET PackageName = @PackageName, 
			PackageDescription = @PackageDesc
		WHERE PackageID = @PackageID AND
			(PackageName <> @PackageName OR PackageDescription <> @PackageDesc)	


	-- Check if version already exist in DB, otehrwise add it to PackageVersion table
	IF NOT EXISTS (SELECT TOP 1 * FROM PackageVersion WHERE VersionID = @VersionID)
		INSERT INTO [Logging].PackageVersion 
			(VersionID, PackageID, VersionMajor, 
			 VersionMinor, VersionBuild, VersionComments,
			 CreationDate, CreatorName, CreatorComputerName, LocaleID)
		VALUES (@VersionID, @PackageID, @VersionMajor, 
			@VersionMinor, @VersionBuild, @VersionComments,
			@CreationDate, @CreatorName, @CreatorComputerName, @LocaleID)
	
	-- Log destination metadata
	IF NOT EXISTS (SELECT TOP 1 * FROM Logging.PackageDestinationTable pdt WHERE pdt.PackageName = @PackageName)
		INSERT INTO Logging.PackageDestinationTable (PackageID, SourceTableCatalog, SourceSchemaName, SourceTableName, DestinationTableCatalog, DestinationSchemaName, DestinationTableName, SsisIncrementalLoad, SsisLoadType, DateTimeCreatedUTC, PackageName)
		VALUES ( @PackageID ,@SourceTableCatalog ,@SourceSchemaName ,@SourceTableName ,@DestinationTableCatalog ,@DestinationSchemaName ,@DestinationTableName ,@SsisIncrementalLoad ,@SsisLoadType, GETUTCDATE(), @PackageName)
	ELSE
		UPDATE Logging.PackageDestinationTable
		SET    SourceTableCatalog = @SourceTableCatalog
			   , SourceSchemaName = @SourceSchemaName
			   , SourceTableName = @SourceTableName
			   , DestinationTableCatalog = @DestinationTableCatalog
			   , DestinationSchemaName = @DestinationSchemaName
			   , DestinationTableName = @DestinationTableName
			   , SsisIncrementalLoad = @SsisIncrementalLoad
			   , SsisLoadType = @SsisLoadType
			   , PackageID = @PackageID
			   , DateTimeUpdatedUTC = GETUTCDATE()
		WHERE  PackageName                = @PackageName
		  AND  (   SourceTableCatalog      <> @SourceTableCatalog
			  OR   SourceSchemaName        <> @SourceSchemaName
			  OR   SourceTableName         <> @SourceTableName
			  OR   DestinationTableCatalog <> @DestinationTableCatalog
			  OR   DestinationSchemaName   <> @DestinationSchemaName
			  OR   DestinationTableName    <> @DestinationTableName
			  OR   SsisIncrementalLoad     <> @SsisIncrementalLoad
			  OR   SsisLoadType            <> @SsisLoadType
			  OR   PackageID               <> @PackageID)


		-- Log the actual execution of this package
		INSERT INTO [Logging].[PackageExecution]
			   (ExecutionID
			   ,PackageVersionID
			   ,ExecutionStart
			   ,MachineName
			   ,UserName
			   ,ProductVersion
			   ,InteractiveMode
			   ,[Status]
			   ,SysBatchLogExecutionLog_key)
		 VALUES
			   (@ExecutionID
			   ,@VersionID
			   ,GETUTCDATE()
			   ,@ExecutionMachineName
			   ,@ExecutionUserName
			   ,@ProductVersion
			   ,@InteractiveMode
			   ,'In progress'
			   ,@SysBatchLogExecutionLog_key)

SET @SysExecutionLog_key = @@IDENTITY
RETURN @SysExecutionLog_key

