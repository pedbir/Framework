#ExportWsToCsv.ps1 -sourceFolderPath "C:\DW\" -destinationFolderPath "C:\DW\"

param(
    [string]$sourceFolderPath = $(throw "-sourceFolderPath is required."), 
    [string]$destinationFolderPath = $(throw "-destinationFolderPath is required.")
    )

ExportFolderToCSV -folderPath $sourceFolderPath -csvLoc $destinationFolderPath      


# https://www.mssqltips.com/sqlservertip/3223/extract-and-convert-all-excel-worksheets-into-csv-files-using-powershell/

Function ExportWSToCSV ($excelFilePath, $csvLoc)
{
        
    $filepath = Get-ChildItem $excelFilePath
    $excelFileName = $filepath.BaseName

     
    $E = New-Object -ComObject Excel.Application
    $E.Visible = $false
    $E.DisplayAlerts = $false
    $wb = $E.Workbooks.Open($excelFilePath)
    foreach ($ws in $wb.Worksheets)
    {
        $n = $excelFileName + "_" + $ws.Name
        $ws.SaveAs($csvLoc + $n + ".csv", 6)
    }
    $E.Quit()
}


Function ExportFolderToCSV ($folderPath, $csvLoc)
{
   $files = Get-ChildItem $folderPath *.xlsx
   
   for ($i=0; $i -lt $files.Count; $i++) 
   {    
        $file = $files[$i].FullName     
        ExportWSToCSV -excelFilePath $file -csvLoc $csvLoc
   }

}
