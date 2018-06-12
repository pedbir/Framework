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
   $files = Get-ChildItem $folderPath
   
   for ($i=0; $i -lt $files.Count; $i++) 
   {    
        $file = $files[$i].FullName     
        ExportWSToCSV -excelFilePath $file -csvLoc $csvLoc
   }

}

ExportFolderToCSV -folderPath "C:\DW\se_credit_deposits\Source\Raw\" -csvLoc "C:\DW\se_credit_deposits\Source\"        


