param (    
    [Parameter(Mandatory=$true)][string]$DefaultWorkingDirectory,
    [Parameter(Mandatory=$true)][string]$TargetSsasSvr,    
    [Parameter(Mandatory=$true)][string]$sourceDb,
	[Parameter(Mandatory=$true)][string]$Environment   
 )
 #test
$SsasDbDirectory = $DefaultWorkingDirectory + "\KPIBuild\drop\SSAS\SSAS\Deploy\" + $Environment + "\" + $sourceDb

function publish-SsasDb
{
[CmdletBinding()]
param(
[Parameter(Position=0,mandatory=$true)]
[string] $TargetSsasSvr,
[Parameter(Position=1,mandatory=$true)]
[string] $sourceDb,
[Parameter()]
[switch] $runscript,
[Parameter()]
[switch] $createScript,
[Parameter()]
[switch] $deployScript)
 
$script:ASDeployWizard = "C:\Program Files (x86)\Microsoft SQL Server\130\Tools\Binn\ManagementStudio\Microsoft.AnalysisServices.Deployment.exe"
 
 
if(!(Test-Path $sourceDb))
{
Write-Error -message "The path to [$sourceDb] is either not accessable or does not exist" -category InvalidArgument
return
}
 
Write-Host "$(Get-Date): Starting"
 
Trap {Write-Host "Failed to publish database ($_.Exception.Message)" -foregroundcolor Black -backgroundcolor Red; break}
 
$path = [System.IO.Path]::GetDirectoryName($sourceDb)
$targetDatabase = [System.IO.Path]::GetFileNameWithoutExtension($sourceDb)
$outputScript = [System.IO.Path]::ChangeExtension($sourceDb,"xmla")
$deploymenttargets = [System.IO.Path]::ChangeExtension($sourceDb,"deploymenttargets")
$logPath = [System.IO.Path]::ChangeExtension($sourceDb,"log")
$deploymenttargetsPath = [System.IO.Path]::ChangeExtension($sourceDb,"deploymenttargets")

(Get-Content $deploymenttargetsPath).replace('localhost', $TargetSsasSvr) | Set-Content $deploymenttargetsPath    
 
if($runscript -or $createScript)
{
$arguments = @("`"$sourceDb`"", "/s:`"$logPath`"", "/o:`"$outputScript`"")
}
if($deployScript)
{
$arguments = @("`"$sourceDb`"", "/s:`"$logPath`"")

}
Write-Verbose "$(Get-Date): Start deployment wizard from deployment script located at [$sourceDb]. See log file [$logPath] for more info." -Verbose
Start-Process -FilePath $script:ASDeployWizard -ArgumentList $arguments -Wait
Write-Verbose "$(Get-Date): End deployment wizard from deployment script located at [$sourceDb]. See log file [$logPath] for more info." -Verbose
 
if($runscript -or $createScript)
{
if(!(Test-Path $outputScript))
{
Write-Error -message "Path [$outputScript] does not exist. Deployment script has not been generated as expected." -category InvalidOperation
return
}
}
$xmla = [string]::join([Environment]::NewLine, (Get-Content $outputScript))
if($runscript)
{
$xmla = [string]::join([Environment]::NewLine, (Get-Content $outputScript))
Write-Verbose "$(Get-Date): Start Database deployment script [$outputScript]" -Verbose
$xmlaresult = Execute-Xmla $TargetSsasSvr $xmla
Write-Verbose "Xmla Result: $xmlaresult" -Verbose
Write-Verbose "$(Get-Date): Finished Database deployment script [$outputScript]" -Verbose
}
Write-Host "$(Get-Date): Finished"
}
 
function Execute-Xmla
{
[CmdletBinding()]
param(
[Parameter(Position=0,mandatory=$true)]
[string] $TargetSsasSvr,
[Parameter(Position=1,mandatory=$true)]
[string] $xmla
)
begin
{
Add-Type -AssemblyName "Microsoft.AnalysisServices.AdomdClient, Version=13.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91"
$connectionectionString = "Data Source=$TargetSsasSvr;Provider=MSOLAP.4;Integrated Security=SSPI;Impersonation Level=Impersonate;"
$connection = New-Object Microsoft.AnalysisServices.AdomdClient.AdomdConnection($connectionectionString)
}
process
{
$connection.Open()
$comand = $connection.CreateCommand()
$comand.CommandTimeout = 20000
$comand.CommandType = [System.Data.CommandType]::Text
$comand.CommandText = $xmla
$reader = $comand.ExecuteXmlReader()
if($reader.Read())
{
$return = $reader.ReadOuterXml()
}
return $return
}
end
{
$connection.Close();
$connection.Dispose();
}
}


Write-Host "SsasDbDirectory $SsasDbDirectory DefaultWorkingDirectory $DefaultWorkingDirectory TargetSsasSvr $TargetSsasSvr sourceDb  $sourceDb "    

    
    
publish-SsasDb -TargetSsasSvr $TargetSsasSvr -sourceDb $SsasDbDirectory -createScript:$true
publish-SsasDb -TargetSsasSvr $TargetSsasSvr -sourceDb $SsasDbDirectory -deployScript:$true

