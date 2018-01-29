param (
    [Parameter(Mandatory=$true)][string]$SQLServer,
    [Parameter(Mandatory=$true)][string]$JobName,
	[Parameter(Mandatory=$true)][string]$RunJob # Y = Yes N = No
 )
 

function Start-SQLAgentJob
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)][string]$SQLServer ,
        [Parameter(Mandatory=$true)][string]$JobName
    )
    
    # Load the SQLPS module
    Push-Location; Import-Module SQLPS -DisableNameChecking; Pop-Location

    $ServerObj = New-Object Microsoft.SqlServer.Management.Smo.Server($SQLServer)
    $ServerObj.ConnectionContext.Connect()
    $JobObj = $ServerObj.JobServer.Jobs | Where-Object {$_.Name -eq $JobName}
    $JobObj.Refresh()

    # If the job is and enabled and not currently executing start it
    if ($JobObj.IsEnabled -and $JobObj.CurrentRunStatus -ne "Executing") {
        $JobObj.Start()
    }

    # Wait until the job completes. Check every second.
    do {
        Start-Sleep -Seconds 1
        # You have to run the refresh method to reread the status
        $JobObj.Refresh()
    } While ($JobObj.CurrentRunStatus -eq "Executing")

    # Get the run duration by adding all of the step durations
    $RunDuration = 0
    foreach($JobStep in $JobObj.JobSteps)     {
        $RunDuration += $JobStep.LastRunDuration
    }

    $JobObj | select Name,CurrentRunStatus,LastRunOutcome,LastRunDate,@{Name="LastRunDurationSeconds";Expression={$RunDuration}}

    if($JobObj.LastRunOutcome -ne "Succeeded")
    {
        Write-Error -Message "SQL Server Job ($JobName) failed on step ($JobStep)"
    }
}

if($RunJob -eq "Y")
{
	# Set a couple variables for testing and call the cmdlet
	Start-SQLAgentJob -SQLServer $SQLServer -JobName $JobName 
}
else 
{
    Write-Host -ForegroundColor RED "Job disabled"
}


