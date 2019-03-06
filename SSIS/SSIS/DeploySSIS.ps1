param (
    [Parameter(Mandatory=$true)][string][string]$ServerName,
    [Parameter(Mandatory=$true)][string]$CatalogPwd,
    [Parameter(Mandatory=$true)][string]$DefaultWorkingDirectory,    
    [string]$SSISCatalog = "SSISDB",
    [string]$Environment = "DEV",
    [string]$ProjectName = "SSIS",
    [string]$FolderName = "SSIS"
 )
 
$EnvironmentName = $Environment

$ProjectFilePath = $DefaultWorkingDirectory + "\KPIBuild\drop\SSIS\DeployPackage\Development\"+$ProjectName+".ispac"

# Load the IntegrationServices Assembly
[Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices")

# Store the IntegrationServices Assembly namespace to avoid typing it every time
$ISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"

Write-Host "Connecting to server ..."

# Create a connection to the server
$sqlConnectionString = "Data Source=$ServerName;Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

$integrationServices = New-Object "$ISNamespace.IntegrationServices" $sqlConnection

$catalog = $integrationServices.Catalogs | ? { $_.Name -eq $SSISCatalog }

# Create the Integration Services object if it does not exist
if (!$catalog) {
    # Provision a new SSIS Catalog
    Write-Host "Creating SSIS Catalog ..."
    $catalog = New-Object "$ISNamespace.Catalog" ($integrationServices, $SSISCatalog, $CatalogPwd)
    $catalog.Create()
}

$folder = $catalog.Folders[$FolderName]

if (!$folder)
{
    #Create a folder in SSISDB
    Write-Host "Creating Folder ..."
    $folder = New-Object "$ISNamespace.CatalogFolder" ($catalog, $FolderName, $FolderName)            
    $folder.Create()  
}

# Read the project file, and deploy it to the folder
Write-Host "Deploying Project ..."
[byte[]] $projectFile = [System.IO.File]::ReadAllBytes($ProjectFilePath)
$folder.DeployProject($ProjectName, $projectFile)

$environment = $folder.Environments[$EnvironmentName]

if (!$environment)
{
    Write-Host "Creating environment ..." 
    $environment = New-Object "$ISNamespace.EnvironmentInfo" ($folder, $EnvironmentName, $EnvironmentName)
    $environment.Create()            
}

$project = $folder.Projects[$ProjectName]
$ref = $project.References[$EnvironmentName, $folder.Name]

if (!$ref)
{
    # making project refer to this environment
    Write-Host "Adding environment reference to project ..."
    $project.References.Add($EnvironmentName, $folder.Name)
    $project.Alter() 
}