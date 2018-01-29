param (
    #[Parameter(Mandatory=$true)][string]$pwd,
    [Parameter(Mandatory=$true)][string]$DefaultWorkingDirectory,
    [Parameter(Mandatory=$true)][string]$Environment
    #[string]$User = "SQLTOOLSAGENT",     
    #[string]$TargetServerName = "."
 )

$dacpacDirectory = ${DefaultWorkingDirectory} +'\DB'
$PublishDirectory = ${DefaultWorkingDirectory} + '\DeployScript\' + $Environment 
$FilePath = $dacpacDirectory + '\*.dacpac'
$csvFileDirectory = ${DefaultWorkingDirectory} + '\DB'


$dacpacFiles = Get-ChildItem $FilePath 

Try
{


#Generate Report
for ($i=0; $i -lt $dacpacFiles.Count; $i++) {
    
    $FullFilePath = $dacpacFiles[$i].FullName
    $FileNameWithExtension = $dacpacFiles[$i].Name    

    $FileName= $FileNameWithExtension.Substring(0, $FileNameWithExtension.IndexOf("."))        
    $FullFilePathPublish = $PublishDirectory + '\' + ${FileNameWithExtension}.replace('.dacpac', '.publish.xml')    

    
    $DeployReport =  "${env:SSDTPath}\sqlpackage.exe /Action:DeployReport /SourceFile:'${dacpacDirectory}\$FileNameWithExtension' /pr:'$FullFilePathPublish' /Variables:Environment=$Environment /Variables:ProjectDirectory=$csvFileDirectory  /outputpath:'${DefaultWorkingDirectory}\Step1_$FileName.log'"
    Invoke-Expression $DeployReport -ErrorAction Stop
    
    }
          


  # Generate Script Report
for ($i=0; $i -lt $dacpacFiles.Count; $i++) {
    
    $FullFilePath = $dacpacFiles[$i].FullName
    $FileNameWithExtension = $dacpacFiles[$i].Name    

    $FileName= $FileNameWithExtension.Substring(0, $FileNameWithExtension.IndexOf("."))        
    $FullFilePathPublish = $PublishDirectory + '\' + ${FileNameWithExtension}.replace('.dacpac', '.publish.xml')    
    
    $GenerateScript  =  "${env:SSDTPath}\sqlpackage.exe /Action:Script /SourceFile:'${dacpacDirectory}\$FileNameWithExtension' /pr:'$FullFilePathPublish' /Variables:Environment=$Environment /Variables:ProjectDirectory=$csvFileDirectory /outputpath:'${DefaultWorkingDirectory}\Step2_$FileName.sql'" 
    Invoke-Expression $GenerateScript -ErrorAction Stop
        
}

# Database Publish
for ($i=0; $i -lt $dacpacFiles.Count; $i++) {
    
    $FullFilePath = $dacpacFiles[$i].FullName
    $FileNameWithExtension = $dacpacFiles[$i].Name    

    $FileName= $FileNameWithExtension.Substring(0, $FileNameWithExtension.IndexOf("."))        
    $FullFilePathPublish = $PublishDirectory + '\' + ${FileNameWithExtension}.replace('.dacpac', '.publish.xml')        
    
    $publish  =  "${env:SSDTPath}\sqlpackage.exe /Action:Publish /SourceFile:'${dacpacDirectory}\$FileNameWithExtension' /pr:'$FullFilePathPublish' /Variables:Environment=$Environment /Variables:ProjectDirectory=$csvFileDirectory"
    Invoke-Expression $publish | Out-File ${DefaultWorkingDirectory}\Step3_$FileName.publish.log -ErrorAction Stop
    
    }
 }       
Catch
{
    $ErrorMessage = $_.Exception.Message
    $FailedItem = $_.Exception.ItemName + ' ' + $FileNameWithExtension
    
    Break
}