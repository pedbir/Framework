

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LoadBatchLogInsert]
@SysBatchLogExecutionLog_key int output,
@LoadGroupPackageID uniqueidentifier, 
@LoadGroupExecutionID uniqueidentifier,
@LoadGroupPackageName nvarchar(100),
@MainID int



AS

INSERT INTO Logging.LoadBatchLog
(
	LoadGroupPackageID, 
	LoadGroupPackageName, 
	LoadGroupExecutionID, 
	MainID,
	StartTime
	
)
values
(
	@LoadGroupPackageID, 
	@LoadGroupPackageName, 
	@LoadGroupExecutionID,
	@MainID , 
	GetDate() 
	
)

SET @SysBatchLogExecutionLog_key = @@IDENTITY
RETURN @SysBatchLogExecutionLog_key

