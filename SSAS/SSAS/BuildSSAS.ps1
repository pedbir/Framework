Param (
[Parameter(Mandatory=$true)]$solnPath,
[Parameter(Mandatory=$true)]$solnConfigName
)

$solnConfigName += "|Default"


#$solnPath = "C:\agent\_work\2\s\SSAS\SSAS\SSAS.dwproj"
#$workingFolder = "C:\Users\pedram.birounvand"

$compiler = "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
$solnCmdSwitch = "Rebuild"

if(!(Test-Path $solnPath))
	{
		Write-Host "##vso[task.logissue type=error;]Cannot access Project file path: $solnPath"
	} else {
		Write-Host ("Project file path: $solnPath")
	}

#Create Argument List
$argumentList = ("`"$solnPath`" /$solnCmdSwitch $solnConfigName")


Write-Host ("Executing command: $compiler $argumentList")
Write-host ("==============================================================================")

try	{
	#build Solution / Project
	Start-Process $compiler $argumentList -NoNewWindow -PassThru -Verbose
	Start-Process $compiler $argumentList -NoNewWindow -PassThru -Wait -Verbose
} catch {
	Write-Host ("##vso[task.logissue type=error;]Task_InternalError "+ $_.Exception.Message)
} 

Write-Host "Ending BuildSSASTask"


